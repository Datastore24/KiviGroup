//
//  InputTextView.h
//  FlowersOnline
//
//  Created by Viktor on 02.05.16.
//  Copyright © 2016 datastore24. All rights reserved.
//


//Класс содает объект для ввода текста в окнах регистрации------------------------


#import <UIKit/UIKit.h>
#import "Macros.h"
#import "UIColor+HexColor.h"
#import "CustomTextField.h"

@interface InputTextView : UIView <UITextFieldDelegate>
// Метод инициализации объекта для ввода текста-----------
// Элемент scrollWidth используется только в расширенном
// скрол вью для смещения объектов в очи Х
// text - если текст записывается при инициализации текст филд
- (instancetype)initWithView: (UIView*) view
                      PointY: (CGFloat) pointY
                    andImage: (NSString*) imageName
          andTextPlaceHolder: (NSString*) placeHolder
              andScrollWidth: (CGFloat) scrollWidth
                     andText: (NSString*) text
             andKeyboardType: (UIKeyboardType) keyboardType;

- (instancetype)initCheckoutWithView: (UIView*) view
                              PointY: (CGFloat) pointY
                  andTextPlaceHolder: (NSString*) placeHolder
                             andText: (NSString*) text
                     andKeyboardType: (UIKeyboardType) keyboardType;

@property (assign, nonatomic) CGFloat height;
@property (strong, nonatomic) CustomTextField * textFieldInput;

@end
