//
//  AuthDbClass.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 19.08.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthDbClass : NSObject

- (NSArray *) showAllUsers;
- (void)deleteAuth;
- (void)addKey: (NSString *) superKey andCatalogKey: (NSString*) catalogKey;
- (BOOL)checkKey:(NSString*) superKey andCatalogKey: (NSString*) catalogKey;
- (void)updateToken:(NSString *)token;
- (void)DeleteUserWithOutKey;
- (BOOL)checkPopUp;
- (void)updatePopUp;
- (void)changeEnter:(NSString *) enter;
- (BOOL)checkEnter;

@end
