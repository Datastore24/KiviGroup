//
//  AddParamsModel.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 20.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AddParamsModelDelegate <NSObject>

@required

@property (strong, nonatomic) NSArray * profArray;

@end


@interface AddParamsModel : NSObject

@property (assign, nonatomic) id <AddParamsModelDelegate> delegate;

+ (NSArray*) setArrayHeight; //Данные пикер вью
+ (NSArray*) setArrayTitl; //Заголовки для пикер вью
+ (NSArray *) setTestArray;


//Массив языков
+ (NSArray*) setArrayData;

@end
