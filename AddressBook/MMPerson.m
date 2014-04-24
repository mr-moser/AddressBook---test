//
//  MMPerson.m
//  AddressBook
//
//  Created by Admin on 12.03.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MMPerson.h"

@implementation MMPerson

@synthesize firstName;
@synthesize lastName;
@synthesize dateOfBirthday;
@synthesize phone;
@synthesize sex;
@synthesize email;
@synthesize status;
@synthesize country;

+(id)createNewPersonFirstName:(NSString *)_firstName
                  andLastName:(NSString *)_lastName
            andDateOfBirthday:(NSString *)_dateOfBirthday
                     andPhone:(NSString *)_phone
                       andSex:(NSString *)_sex
                     andEmail:(NSString *)_email
                    andStatus:(NSString *)_status
                   andCountry:(NSString *)_country
{
    MMPerson * person = [[MMPerson alloc ]initWithPersonFirstName:_firstName
                                                      andLastName:_lastName
                                                andDateOfBirthday:_dateOfBirthday
                                                         andPhone:_phone
                                                           andSex:_sex
                                                         andEmail:_email
                                                        andStatus:_status
                                                       andCountry:_country];
    return person;
}

-(id)initWithPersonFirstName:(NSString*)_firstName
                 andLastName:(NSString*)_lastName
           andDateOfBirthday:(NSString*)_dateOfBirthday
                    andPhone:(NSString*)_phone
                      andSex:(NSString*)_sex
                    andEmail:(NSString*)_email
                   andStatus:(NSString*)_status
                  andCountry:(NSString*)_country
{
    if (self == [super init]) {
        self.firstName = _firstName;
        self.lastName = _lastName;
        self.dateOfBirthday = _dateOfBirthday;
        self.phone = _phone;
        self.sex = _sex;
        self.email = _email;
        self.status = _status;
        self.country = _country;
    }
    return self;
}

-(MMPerson*)initWithDictionary:(NSDictionary*)personDictionary {
    self = [super init];
    if (self)
    {
        self.firstName = [personDictionary objectForKey:@"firstName"];
        self.lastName = [personDictionary objectForKey:@"lastName"];
        self.dateOfBirthday = [personDictionary objectForKey:@"dateOfBirthday"];
        self.phone = [personDictionary objectForKey:@"phone"];
        self.sex = [personDictionary objectForKey:@"sex"];
        self.email = [personDictionary objectForKey:@"email"];
        self.status = [personDictionary objectForKey:@"status"];
        self.country = [personDictionary objectForKey:@"country"];
    }
    return self;
}

-(NSDictionary*)convertToDictionary {
    NSDictionary* personDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                      [NSString stringWithString:self.firstName], @"firstName",
                                      [NSString stringWithString:self.lastName], @"lastName",
                                      [NSString stringWithString:self.dateOfBirthday], @"dateOfBirthday",
                                      [NSString stringWithString:self.phone], @"phone",
                                      [NSString stringWithString:self.sex], @"sex",
                                      [NSString stringWithString:self.email], @"email",
                                      [NSString stringWithString:self.status], @"status",
                                      [NSString stringWithString:self.country], @"country",
                                      nil];
    return personDictionary;
}

@end


























