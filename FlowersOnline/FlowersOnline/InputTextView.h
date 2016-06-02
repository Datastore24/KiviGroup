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

@interface InputTextView : UIView <UITextFieldDelegate>
//Метод инициализации объекта для ввода текста-----------
- (instancetype)initWithView: (UIView*) view
                      PointY: (CGFloat) pointY
                    andImage: (NSString*) imageName
          andTextPlaceHolder: (NSString*) placeHolder;

@property (assign, nonatomic) CGFloat height;

@end
