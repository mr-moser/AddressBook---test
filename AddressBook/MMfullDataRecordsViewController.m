//
//  MMfullDataRecordsViewController.m
//  AddressBook
//
//  Created by Admin on 12.03.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MMfullDataRecordsViewController.h"

@interface MMfullDataRecordsViewController ()

@end

@implementation MMfullDataRecordsViewController

@synthesize person;
@synthesize arrPersons;
@synthesize idPerson;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    int indexPerson = [arrPersons indexOfObject:person];
    [self setData:indexPerson];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateFullPersons:)
                                                 name:@"updateFullPersons"
                                               object:nil];
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Все записи" style:UIBarButtonItemStyleBordered target:self action:@selector(allRecords:)];
    self.navigationItem.leftBarButtonItem=newBackButton;
}
- (void)allRecords:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateAllPersons" object:arrPersons];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateFullPersons:(NSNotification*)notification {
    int indexPerson = [arrPersons indexOfObject:[notification object]];
    [self setData:indexPerson];
}
-(void)setData:(int)_index {
    person = [arrPersons objectAtIndex:_index];
    self.firstNameLabel.text = [person firstName];
    self.lastNameLabel.text = [person lastName];
    self.sexLabel.text = [person sex];
    self.birthdayLabel.text = [person dateOfBirthday];
    self.phoneLabel.text = [person phone];
    self.emailLabel.text = [person email];
    self.statusLabel.text = [person status];
    self.countyLabel.text = [person country];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"redact_record"]) {
        MMaddRecordViewController * controller = (MMaddRecordViewController*) segue.destinationViewController;
        [controller editPerson:person idPerson:idPerson];
        [controller setArrPersons:arrPersons];
    }
}

@end
