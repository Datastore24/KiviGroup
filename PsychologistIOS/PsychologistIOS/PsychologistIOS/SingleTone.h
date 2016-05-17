//
//  SingleTone.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleTone : NSObject

@property (strong, nonatomic) NSString * titleSubCategory;
@property (strong, nonatomic) NSString * titleCategory;
@property (strong, nonatomic) NSString * titleSubject;
@property (strong, nonatomic) NSString * titleInstruction;


//АПИ--------------------------------------------
@property (strong, nonatomic) NSString * identifierCategory;
@property (strong, nonatomic) NSString * identifierSubCategory;
@property (strong, nonatomic) NSString * identifierSubjectModel;

@property (strong, nonatomic) NSString * apiImage;

//Тарифы-----------------------------------------

@property (strong, nonatomic) NSString * tariffID;

//Работа с аудио---------------------------------
@property (strong, nonatomic) NSString * audioURL;

//Авторизация
@property (strong,nonatomic) NSMutableArray* token_ios;
@property (strong, nonatomic) NSString* login;

//Чат
@property (strong, nonatomic) NSString * userID;
@property (strong, nonatomic) NSString * postID;



+ (id)sharedManager;

@end
