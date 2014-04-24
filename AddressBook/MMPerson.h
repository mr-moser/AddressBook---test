//
//  MMPerson.h
//  AddressBook
//
//  Created by Admin on 12.03.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMPerson : NSObject

@property (nonatomic, strong) NSString* firstName;
@property (nonatomic, strong) NSString* lastName;
@property (nonatomic, strong) NSString* dateOfBirthday;
@property (nonatomic, strong) NSString* phone;
@property (nonatomic, strong) NSString* sex;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* status;
@property (nonatomic, strong) NSString* country;

+(id)createNewPersonFirstName:(NSString*)_firstName
                  andLastName:(NSString*)_lastName
            andDateOfBirthday:(NSString*)_dateOfBirthday
                     andPhone:(NSString*)_phone
                       andSex:(NSString*)_sex
                     andEmail:(NSString*)_email
                    andStatus:(NSString*)_status
                   andCountry:(NSString*)_country;

-(id)initWithPersonFirstName:(NSString*)_firstName
                 andLastName:(NSString*)_lastName
           andDateOfBirthday:(NSString*)_dateOfBirthday
                    andPhone:(NSString*)_phone
                      andSex:(NSString*)_sex
                    andEmail:(NSString*)_email
                   andStatus:(NSString*)_status
                  andCountry:(NSString*)_country;

-(MMPerson*)initWithDictionary:(NSDictionary*)personDictionary;
-(NSDictionary*)convertToDictionary;

@end
