//
//  AuthDBClass.h
//  FlowersOnline
//
//  Created by Кирилл Ковыршин on 29.07.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthDBClass : NSObject
- (void)registerUser:(NSString *) login
         andPassword: (NSString*) password
             andName: (NSString*) name
            andEmail: (NSString*) email
          andAddress: (NSString*) address
            andPhone: (NSString*) phone; //Регистрация пользователя

- (BOOL)checkRegistration; //Проверка регистрации

- (NSArray *) showAllUsers; //Показать всех пользователей

-(void) deleteAll; //Удалить все из базы

@end
