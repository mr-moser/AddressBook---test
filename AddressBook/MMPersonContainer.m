//
//  MMPersonContainer.m
//  AddressBook
//
//  Created by Admin on 26.03.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MMPersonContainer.h"

@implementation MMPersonContainer

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"dataPersons.plist"];
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
        _fractions = [[NSMutableArray alloc] initWithCapacity:arrayFromFile.count];
        //перебирая массив arrayFromFile
        for (int i = 0; i < arrayFromFile.count; i++) {
        //считываем словарь, как элемент массива
            NSDictionary* fractionDict = (NSDictionary*)[arrayFromFile objectAtIndex:i];
            //перегнать все NSDictionary  в MMPerson
            MMPerson * P = [[MMPerson alloc] initWithDictionary:fractionDict];
            //добавить f в массив
            [_fractions addObject:P];
        }
    }
}

-(void)saveToPlist {
    //создать массив NSArray состоящий из экземпляров NSDictionary
    NSMutableArray* arrayForSave = [[NSMutableArray alloc] initWithCapacity:[_fractions count]];
    //добавляем в arrayForSave экземпляры NSDictionary, полученные из Дроби
    for (NSInteger i = 0; i < [_fractions count]; i++) {
        MMPerson * P = (MMPerson*)[_fractions objectAtIndex:i];
        NSDictionary* fDict = [P convertToDictionary];
        [arrayForSave addObject:fDict];
    }
    //записать этот массив в файл
    NSString *filePath = [self dataFilePath];
    [arrayForSave writeToFile:filePath atomically:YES];
}

////генерируем массив дробей случайным образом
//-(void)genereRandomArray {
//    //генерируем количество элементов в массиве (от 5 до 9)
//    //arc4random_uniform(5) - возвращает число от 0 до 4
//    NSInteger countRnd = arc4random_uniform(5)+5;
//    
//    //создаем экземпляр NSMutableArray
//    _fractions = [[NSMutableArray alloc] initWithCapacity:countRnd];
//    
//    for (NSInteger i = 0; i < countRnd; i++)
//    {
//        //создаем экземпляр MyFraction
//        MMPerson * P = [[MMPerson alloc] init];
//        
//        //заполняем дробь случайными числами
//        [P setTo:arc4random_uniform(5)+1 over:arc4random_uniform(5)+1];
//        
//        //добавляем дробь в массив
//        [_fractions addObject:P];
//    }
//}

//-(NSString*)getAllArrayAsString
//{
//    NSMutableString* resultStr = [[NSMutableString alloc] init];
//    //перебираем все дроби в _fractions
//    for (MMPerson * P in _fractions)
//    {
//        //добавляем в конец строки очередную дробь
//        [resultStr appendFormat:@"%@, ", [P toStringMy]];
//    }
//    return [NSString stringWithString:resultStr];
//    
//}

@end
