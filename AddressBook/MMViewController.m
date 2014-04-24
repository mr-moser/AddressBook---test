//
//  MMViewController.m
//  AddressBook
//
//  Created by Admin on 12.03.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MMViewController.h"

@interface MMViewController ()

@end

@implementation MMViewController

@synthesize arrPersons;

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"dataPersons.plist"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //arrPersons = [[NSMutableArray alloc] init];
    
    [self loadFromPlist];
    
    self.numPersonsLabel.text = [NSString stringWithFormat:@"%d", [arrPersons count]];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateNumPersons:)
                                                 name:@"updateNumPersons"
                                               object:nil];
}

//считать массив из файла
-(void)loadFromPlist {
    //получаем путь к файлу
    NSString *filePath = [self dataFilePath];
    //проверка: если файл существует
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        //считать массив словарей из файла
        NSArray *arrayFromFile = [[NSArray alloc] initWithContentsOfFile:filePath];
        //создаем массив NSMutableArray
        arrPersons = [[NSMutableArray alloc] initWithCapacity:arrayFromFile.count];
        //перебирая массив arrayFromFile
        for (int i = 0; i < arrayFromFile.count; i++) {
            //считываем словарь, как элемент массива
            NSDictionary* fractionDict = (NSDictionary*)[arrayFromFile objectAtIndex:i];
            //перегнать все NSDictionary  в MMPerson
            MMPerson * P = [[MMPerson alloc] initWithDictionary:fractionDict];
            //добавить P в массив
            [arrPersons addObject:P];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateNumPersons:(NSNotification*)notification {
    arrPersons = [notification object];
    self.numPersonsLabel.text = [NSString stringWithFormat:@"%d", [arrPersons count]];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"new_record"])
    {
        MMaddRecordViewController * controller = (MMaddRecordViewController*) segue.destinationViewController;
        controller.arrPersons = arrPersons;
    }
    if ([segue.identifier isEqualToString:@"all_record"])
    {
        MMallRecordsViewController * controller = (MMallRecordsViewController*) segue.destinationViewController;
        controller.arrPersons = arrPersons;
    }
}
@end
