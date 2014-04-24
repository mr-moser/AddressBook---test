//
//  MMaddRecordViewController.m
//  AddressBook
//
//  Created by Admin on 12.03.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MMaddRecordViewController.h"

#define kStateComponent 0
#define kZipComponent 1

@interface MMaddRecordViewController ()

@end

@implementation MMaddRecordViewController

@synthesize arrPersons;
@synthesize arrCountry;
@synthesize arrStatus;
@synthesize arrSex;
@synthesize countryPicker;
@synthesize statusPicker;
@synthesize sexPicker;
@synthesize person;
@synthesize creatButton;
@synthesize idPerson;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _typeOfView = TYPE_FOR_ADD;
    }
    return self;
}

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"dataPersons.plist"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrCountry = [NSArray arrayWithObjects:@"Ukraine", @"Russia", @"USA", @"France", @"German", nil];
    arrStatus = [NSArray arrayWithObjects:@"Служащий", @"", @"Клиент", nil];
    arrSex = [NSArray arrayWithObjects:@"Мужской", @"", @"Женский", nil];
    
//Создаем UIPickerView, который будет вместо клавиатуры для поля "country"  
    countryPicker = [[UIPickerView alloc]init];
    countryPicker.tag = 1;
    [countryPicker setDataSource: self];
    [countryPicker setDelegate: self];
    countryPicker.showsSelectionIndicator = YES;
    [self.country setInputView:countryPicker];
//////////////////////////////////////////////////////////////////////////
//Создаем UIPickerView, который будет вместо клавиатуры для поля "status"
    statusPicker = [[UIPickerView alloc]init];
    statusPicker.tag = 2;
    [statusPicker setDataSource: self];
    [statusPicker setDelegate: self];
    statusPicker.showsSelectionIndicator = YES;
    [statusPicker selectRow:1 inComponent:0 animated:NO];
    [self.status setInputView:statusPicker];
//////////////////////////////////////////////////////////////////////////
//Создаем UIPickerView, который будет вместо клавиатуры для поля "status"
    sexPicker = [[UIPickerView alloc]init];
    sexPicker.tag = 3;
    [sexPicker setDataSource: self];
    [sexPicker setDelegate: self];
    sexPicker.showsSelectionIndicator = YES;
    [sexPicker selectRow:1 inComponent:0 animated:NO];
    [self.sex setInputView:sexPicker];
//////////////////////////////////////////////////////////////////////////
    
//Создаем UIDatePicker, который будет вместо клавиатуры
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
//задаем текушую дату
    [datePicker setDate:[NSDate date]];
//Задаем обработчик updateTextField для события UIControlEventValueChanged для текстового поля _textFirstDate
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.dateOfBirthday setInputView:datePicker];
    
    tempRect = self.view.frame;
    
//Загрузка из файла
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURL = [bundle URLForResource:@"Property List" withExtension:@"plist"];
    self.stateZips = [NSDictionary dictionaryWithContentsOfURL:plistURL];;
    //массив всех штатов
    NSArray *allStates = [self.stateZips allKeys];
    //сортированный массив всех штатов
    NSArray *sortedStates = [allStates sortedArrayUsingSelector: @selector(compare:)];
    //записываем сортированный массив всех штатов в property
    self.states = sortedStates;
    //выбранный штат
    NSString *selectedState = self.states[0];
    //массив индексов для выбранного штата
    self.zips = self.stateZips[selectedState];
}

-(void)viewWillAppear:(BOOL)animated
{
    if (_typeOfView == TYPE_FOR_EDIT)
    {
        self.firstName.text = [person firstName];
        self.lastName.text = [person lastName];
        self.sex.text = [person sex];
        self.dateOfBirthday.text = [person dateOfBirthday];
        self.phone.text = [person phone];
        self.email.text = [person email];
        self.status.text = [person status];
        self.country.text = [person country];
        [self setTitle:@"Редактирование"];
        [self.creatButton setTitle:@"Сохранить запись" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)editPerson:(MMPerson*)person_ idPerson:(NSInteger)idPerson_ {
    _typeOfView = TYPE_FOR_EDIT;
    person = person_;
    idPerson = idPerson_;
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                //Picker View Country
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//вернуть количество столбцов
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    switch (pickerView.tag) {
        case 1: return 2; break;
        case 2: return 1; break;
        case 3: return 1; break;
    }
    return 0;
}
//вернуть количество строк для заданного столбца
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case 1: {
            if (component == kStateComponent)
                return [self.states count];
            else
                return [self.zips count];
            break;
        }
        case 2: return [arrStatus count]; break;
        case 3: return [arrSex count]; break;
    }
    return 0;
}

//!!!!возвращаем текст для заданного столбца и заданной строки!!!
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case 1: {
            if (component == kStateComponent)
                return [self.states objectAtIndex:row];
            else
                return [self.zips objectAtIndex:row];
                
            break;
        }
        case 2: return [arrStatus objectAtIndex:row]; break;
        case 3: return [arrSex objectAtIndex:row]; break;
    }
    return nil;
}
//!!обработчик выбранной строки !!!
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case 1: {
            if (component == kZipComponent)
                self.country.text = [self.zips objectAtIndex:row];
            else {
                //название выбранного штата (из первого столбца)
                NSString *selectedState = self.states[row];
                
                //получаем индексы для  selectedState из общего словаря
                //оба варианта эквивалентны друг другу
                //self.zips = self.stateZips[selectedState]; //вариант 1
                self.zips = [self.stateZips objectForKey:selectedState];//вариант 2
                //перезагружаем данные у вторго барабана
                [self.countryPicker reloadComponent:kZipComponent];
                //выбираем первую строку во втором барабане
                [self.countryPicker selectRow:0
                               inComponent:kZipComponent
                                  animated:YES];
            }
            break;
        }
        case 2: self.status.text = [arrStatus objectAtIndex:row]; break;
        case 3: self.sex.text = [arrSex objectAtIndex:row]; break;
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////===================обработчики появления и скрытия клавиатуры === начало
- (IBAction)editingDidBegin:(id)sender {
    self.view.frame = CGRectMake(tempRect.origin.x, -30, tempRect.size.width, tempRect.size.height);
}
- (IBAction)editingDidEnd:(id)sender {
    if ([sender respondsToSelector:@selector(tag)])
    {
        //[UIView animateWithDuration:0.3f animations:^ {
            self.view.frame = CGRectMake(tempRect.origin.x, 0, tempRect.size.width, tempRect.size.height);
        //}];
    }
}
//////////===================обработчики появления и скрытия клавиатуры === конец

-(void)updateTextField:(id)sender
{
    if([self.dateOfBirthday isFirstResponder]){
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd.MM.yyyy"]; //yyyy.MM.dd G 'at' HH:mm:ss zzz
        UIDatePicker *picker = (UIDatePicker*)self.dateOfBirthday.inputView;
        NSString *stringFromDate = [formatter stringFromDate:picker.date];
        self.dateOfBirthday.text = [NSString stringWithFormat:@"%@",stringFromDate];
    }
}

- (IBAction)fillData:(UIButton *)sender {
    if ([self.firstName.text isEqualToString: @""] ||
        [self.lastName.text isEqualToString: @""] ||
        [self.dateOfBirthday.text isEqualToString: @""] ||
        [self.phone.text isEqualToString: @""] ||
        [self.sex.text isEqualToString: @""] ||
        [self.email.text isEqualToString: @""] ||
        [self.status.text isEqualToString: @""] ||
        [self.country.text isEqualToString: @""])
    {
        self.label.text = @"Заполнены не все поля";
        [self touchDown:nil];
    }
    else
    {
        MMPerson * tempPerson = [MMPerson createNewPersonFirstName:self.firstName.text
                                                       andLastName:self.lastName.text
                                                 andDateOfBirthday:self.dateOfBirthday.text
                                                          andPhone:self.phone.text
                                                            andSex:self.sex.text
                                                          andEmail:self.email.text
                                                         andStatus:self.status.text
                                                        andCountry:self.country.text];
        if (_typeOfView == TYPE_FOR_ADD) {
            [arrPersons addObject:tempPerson];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateNumPersons" object:arrPersons];
        }
        else if (_typeOfView == TYPE_FOR_EDIT) {
            [arrPersons replaceObjectAtIndex:idPerson withObject:tempPerson];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateFullPersons" object:tempPerson];
        }
        self.label.text = @"";
        [self touchDown:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
        [self saveToPlist];
//        //запись в файл
//        NSMutableArray* arrayForSave = [[NSMutableArray alloc] initWithCapacity:<#(NSUInteger)#>];
//        NSDictionary* fDict = [tempPerson convertToDictionary];
//        [arrayForSave addObject:fDict];
//        NSString *filePath = [self dataFilePath];
//        [arrayForSave writeToFile:filePath atomically:YES];
    }
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

- (IBAction)didEndOnExit:(id)sender { //закрытие клавиатуры при нажатии на кнопку return
    [sender resignFirstResponder];
}
- (IBAction)touchDown:(id)sender { //закрытие клавиатуры при постукивании по фону
    [self.firstName resignFirstResponder];
    [self.lastName resignFirstResponder];
    [self.sex resignFirstResponder];
    [self.dateOfBirthday resignFirstResponder];
    [self.phone resignFirstResponder];
    [self.email resignFirstResponder];
    [self.status resignFirstResponder];
    [self.country resignFirstResponder];
}

@end
