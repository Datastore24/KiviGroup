//
//  SingleTone.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SingleTone : NSObject

@property (strong,nonatomic) NSString* superKey;
@property (strong,nonatomic) NSString* catalogKey;
@property (strong, nonatomic) NSString * typeMenu;

//Временные синглтоны корзины (после подвязки базы удалить)

@property (strong, nonatomic) NSString * countType; //Колличество выбранного товара
@property (strong, nonatomic) NSString * priceType; //Общая цена выбранных товаров

//Булевая переменная для отобрадения вкладки телефона
@property (assign, nonatomic) BOOL boolPhone;

//Временная булевая переменная для окна приветсвия
@property (assign, nonatomic) BOOL helloBool;

//Переменная сохранения рахмера скрола
@property (assign, nonatomic) CGFloat scrollHeight;

@property (strong, nonatomic) NSString * titlSize;
@property (strong, nonatomic) NSString * htmlSize;

+ (id)sharedManager;

@end
