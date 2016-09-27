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
@property (strong, nonatomic) NSString * customID;
@property (strong, nonatomic) NSString * customValue;
@property (strong, nonatomic) NSString * customValueTwo;

//Кнопка корзины
+ (UIButton*) createButtonBasket;
//Кнопка меню в приложении
+ (UIButton*) createButtonMenu;
//Текстовая кнопка
+ (UIButton*) customButtonSystemWithFrame: (CGRect) frame
                                 andColor: (NSString*) colorName
                          andAlphaBGColor: (CGFloat) alphaColor
                           andBorderColor: (NSString*) borderColor
                          andCornerRadius: (CGFloat) cornerRadius
                              andTextName: (NSString*) textNameButton
                             andColorText: (NSString*) colorText
                              andSizeText: (CGFloat) sizeText
                           andBorderWidht: (CGFloat) borderWidht;

//Кнопка назад
+ (UIButton*) createButtonBack;

+ (UIButton*) createButtonCustomImageWithImage: (NSString*) imageName
                                       andRect: (CGRect) rect;

+ (UIButton*) createButtonWriteWithImage: (NSString*) image;


@end
