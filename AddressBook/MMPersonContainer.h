//
//  MMPersonContainer.h
//  AddressBook
//
//  Created by Admin on 26.03.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMPerson.h"

@interface MMPersonContainer : NSObject

@property (nonatomic, strong) NSMutableArray* fractions;

-(void)loadFromPlist;
-(void)saveToPlist;
//-(void)genereRandomArray;
//-(NSString*)getAllArrayAsString;

@end
