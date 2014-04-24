//
//  MMallRecordsViewController.h
//  AddressBook
//
//  Created by Admin on 12.03.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMPerson.h"
#import "MMfullDataRecordsViewController.h"

@interface MMallRecordsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) NSMutableArray * arrPersons;
@property (nonatomic, retain) NSArray * filteredPersons;
@property (weak, nonatomic) IBOutlet UITableView * tableView;
@property (nonatomic) BOOL isEdit;

@end
