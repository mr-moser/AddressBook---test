//
//  MMallRecordsViewController.m
//  AddressBook
//
//  Created by Admin on 12.03.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MMallRecordsViewController.h"

@interface MMallRecordsViewController ()

@end

@implementation MMallRecordsViewController

@synthesize arrPersons;
@synthesize filteredPersons;
@synthesize isEdit;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"dataPersons.plist"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isEdit = false;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateAllPersons:)
                                                 name:@"updateAllPersons"
                                               object:nil];
    UIBarButtonItem *edit =[[UIBarButtonItem alloc] initWithTitle:@"Редактировать" style:UIBarButtonItemStylePlain target:self action:@selector(editing)];
    self.navigationItem.rightBarButtonItem = edit;
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Главная" style:UIBarButtonItemStyleBordered target:self action:@selector(home:)];
    self.navigationItem.leftBarButtonItem=newBackButton;
}
-(void)updateAllPersons:(NSNotification*)notification {
    [_tableView reloadData];
}
//включение редактирования
- (void)editing {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    if (isEdit) {
        isEdit = false;
        [self saveToPlist];
    } else {
        isEdit = true;
    }
}
//надпиьс на кнопке удаления
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Удалить";
}
//смена расположения строк
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [arrPersons exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}

- (void)home:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateNumPersons" object:arrPersons];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveToPlist {
    //создать массив NSArray состоящий из экземпляров NSDictionary
    NSMutableArray* arrayForSave = [[NSMutableArray alloc] initWithCapacity:[arrPersons count]];
    //добавляем в arrayForSave экземпляры NSDictionary, полученные из Дроби
    for (NSInteger i = 0; i < [arrPersons count]; i++) {
        MMPerson * P = (MMPerson*)[arrPersons objectAtIndex:i];
        NSDictionary* fDict = [P convertToDictionary];
        [arrayForSave addObject:fDict];
    }
    //записать этот массив в файл
    NSString *filePath = [self dataFilePath];
    [arrayForSave writeToFile:filePath atomically:YES];
}



-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[cd]%@",searchString];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.firstName contains[cd] %@ OR SELF.lastName contains[cd] %@", searchString, searchString];
    
//    NSArray *filteredItem = [arrPersons filteredArrayUsingPredicate:predicate];
//    NSLog(@"%@", filteredItem);
    
    self.filteredPersons = [arrPersons filteredArrayUsingPredicate:predicate];
    
    return YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return filteredPersons.count;
    } else {
        return arrPersons.count;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//Возвращает количество секций в таблице
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell *cell;
    static NSString *const cell_id1 = @"cell";
    MMPerson * tempPerson = [arrPersons objectAtIndex:indexPath.row];
    cell = [self.tableView dequeueReusableCellWithIdentifier:cell_id1];
    
    if (self.tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [[filteredPersons objectAtIndex:indexPath.row] firstName], [[filteredPersons objectAtIndex:indexPath.row] lastName]];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [tempPerson firstName], [tempPerson lastName]];
    }
    
    NSLog(@"cell.textLabel.text - %@", cell.textLabel.text);
    NSLog(@"firstName - %@ lastName - %@", [[filteredPersons objectAtIndex:indexPath.row] firstName], [[filteredPersons objectAtIndex:indexPath.row] lastName]);
    NSLog(@"cell - %@", cell);
    
    return cell; //возвращает ячейку с заполненными данными
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"full_data"])
    {
        MMfullDataRecordsViewController * controller = (MMfullDataRecordsViewController*) segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow]; //получение индекса выбранной ячейки
        [controller setPerson:[arrPersons objectAtIndex:indexPath.row]];
        [controller setIdPerson:indexPath.row];
        [controller setArrPersons:arrPersons];
    }
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [arrPersons removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end








