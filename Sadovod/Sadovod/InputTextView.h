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
#import "HexColors.h"
#import "CustomTextField.h"

@protocol InputTextViewDelegate;

@interface InputTextView : UIView <UITextFieldDelegate>

@property (weak, nonatomic) id <InputTextViewDelegate> delegate;
// Метод инициализации объекта для ввода текста-----------
// Элемент scrollWidth используется только в расширенном экране
// скрол вью для смещения объектов в оcи Х
- (instancetype)initWithView: (UIView*) view
                     andRect: (CGRect) frame
                    andImage: (NSString*) imageName
          andTextPlaceHolder: (NSString*) placeHolder
              andScrollWidth: (CGFloat) scrollWidth;

- (instancetype)initInputTextWithView: (UIView*) view
                              andRect: (CGRect) frame
                             andImage: (NSString*) imageName
                   andTextPlaceHolder: (NSString*) placeHolder
                          colorBorder: (NSString*) colorBorder;

- (instancetype)initInputTextSearchWithView: (UIView*) view
                                    andRect: (CGRect) frame
                                   andImage: (NSString*) imageName
                         andTextPlaceHolder: (NSString*) placeHolder
                                colorBorder: (NSString*) colorBorder;


@property (assign, nonatomic) CGFloat height;
@property (strong, nonatomic) CustomTextField * textFieldInput;
@property (strong, nonatomic) UILabel * labelPlaceHoldInput;

@end

@protocol InputTextViewDelegate <NSObject>

@optional

- (void) inputText: (InputTextView*) inputTextView;

@end
