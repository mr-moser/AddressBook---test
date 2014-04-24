//
//  MMViewController.h
//  AddressBook
//
//  Created by Admin on 12.03.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMPerson.h"
#import "MMaddRecordViewController.h"
#import "MMallRecordsViewController.h"

@interface MMViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *numPersonsLabel;
@property (strong, nonatomic) NSMutableArray * arrPersons;
-(void)updateNumPersons:(NSNotification*)notification;

@end
