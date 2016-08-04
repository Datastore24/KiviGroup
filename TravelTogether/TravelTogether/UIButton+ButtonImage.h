//
//  UIButton+ButtonImage.h
//  PsychologistIOS
//
//  Created by Viktor on 09.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ButtonImage)

@property (strong, nonatomic) UIImage * imageButton;
@property (assign, nonatomic) BOOL isBool; //параметр для двух положений кнопки

//Кнопка корзины
+ (UIButton*) createButtonBasket;
//Кнопка меню в приложении
+ (UIButton*) createButtonMenu;
//Текстовая кнопка
+ (UIButton*) createButtonTextWithName: (NSString*) name
                              andFrame: (CGRect) rect
                              fontName: (NSString*) font;

//Кнопка назад
+ (UIButton*) createButtonBack;

@end
