//
//  MMaddRecordViewController.h
//  AddressBook
//
//  Created by Admin on 12.03.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMPerson.h"
#import "MMViewController.h"

enum ETypeOfView {
    TYPE_FOR_ADD = 0,
    TYPE_FOR_EDIT = 1
    };

@interface MMaddRecordViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    CGRect tempRect;
    CGRect oldViewRectMy;
    enum ETypeOfView _typeOfView;
}
@property (strong, nonatomic) NSMutableArray * arrPersons;
@property (nonatomic) NSArray * arrCountry;
@property (nonatomic) NSArray * arrStatus;
@property (nonatomic) NSArray * arrSex;
@property (strong, nonatomic) IBOutlet UIPickerView * countryPicker;
@property (strong, nonatomic) IBOutlet UIPickerView * statusPicker;
@property (strong, nonatomic) IBOutlet UIPickerView * sexPicker;

@property (weak, nonatomic) IBOutlet UILabel * label;

@property (weak, nonatomic) IBOutlet UITextField * firstName;
@property (weak, nonatomic) IBOutlet UITextField * lastName;
@property (weak, nonatomic) IBOutlet UITextField * sex;
@property (weak, nonatomic) IBOutlet UITextField * dateOfBirthday;
@property (weak, nonatomic) IBOutlet UITextField * phone;
@property (weak, nonatomic) IBOutlet UITextField * email;
@property (weak, nonatomic) IBOutlet UITextField * status;
@property (weak, nonatomic) IBOutlet UITextField * country;

@property (weak, nonatomic) IBOutlet UIButton *creatButton;

- (IBAction)fillData:(UIButton *)sender;
- (IBAction)didEndOnExit:(id)sender;
- (IBAction)touchDown:(id)sender;
- (IBAction)editingDidBegin:(id)sender;
- (IBAction)editingDidEnd:(id)sender;

- (void)editPerson:(MMPerson*)person_ idPerson:(NSInteger)idPerson_;

@property (weak, nonatomic) MMPerson* person;
@property (nonatomic) NSInteger idPerson;

@property (strong, nonatomic) NSDictionary *stateZips;//общий словарь (штаты+индексы)
@property (strong, nonatomic) NSArray *states;  //только названия штатов
@property (strong, nonatomic) NSArray *zips;    //только индексы штатов

@end