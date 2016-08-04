//
//  InputTextView.m
//  FlowersOnline
//
//  Created by Viktor on 02.05.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "InputTextView.h"
#import "CustomTextField.h"

@implementation InputTextView
{
//    CustomTextField * textFieldInput;
    UILabel * labelPlaceHoldInput;
    UIView * mainView;
    BOOL keyboardUp;
}



- (instancetype)initWithView: (UIView*) view
                     andRect: (CGRect) frame
                    andImage: (NSString*) imageName
          andTextPlaceHolder: (NSString*) placeHolder
              andScrollWidth: (CGFloat) scrollWidth
{
    self = [super init];
    if (self) {
        self.frame = frame;
        self.layer.cornerRadius = 23.f;
        self.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_GREEN alpha:0.75f].CGColor;
        self.layer.borderWidth = 1.f;
        self.backgroundColor = [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.75f];
        keyboardUp = NO;
        
        mainView = view;
        
        //Картинка объекта--------
        UIImageView * imageViewInput = [[UIImageView alloc] initWithFrame:CGRectMake(20.f, 3.f, 38.f, 38.f)];
        imageViewInput.image = [UIImage imageNamed:imageName];
        imageViewInput.alpha = 0.5f;
        [imageViewInput sizeThatFits:CGSizeMake(40.f, 40.f)];
        [self addSubview:imageViewInput];
        
        //Ввод текста-------------
        self.textFieldInput = [[CustomTextField alloc] initWithFrame:CGRectMake(60.f, 0.f, self.frame.size.width - 60.f, 46.f)];
        self.textFieldInput.delegate = self;
        self.textFieldInput.isBoll = YES;
        self.textFieldInput.keyboardType = UIKeyboardTypeDefault;
        self.textFieldInput.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textFieldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:12];
        self.textFieldInput.textColor = [UIColor blackColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabel:) name:UITextFieldTextDidChangeNotification object:self.textFieldInput];
        [self addSubview:self.textFieldInput];
        
        //Плесхолдер --------------
        labelPlaceHoldInput = [[UILabel alloc] initWithFrame:self.textFieldInput.frame];
        labelPlaceHoldInput.text = placeHolder;
        labelPlaceHoldInput.textColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_TEXT_GREEN alpha:0.5f];
        labelPlaceHoldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:12];
        [self addSubview:labelPlaceHoldInput];
        
    }
    return self;
}

- (void) setHeight:(CGFloat)height
{
    CGRect myRect = self.frame;
    myRect.origin.y = height;
    self.frame = myRect;
}

#pragma mark - UITextFieldDelegate

//Скрытие клавиатуры----------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//Анимация Лейблов при вводе SMS-------------------------
- (void) animationLabel: (NSNotification*) notification
{
    CustomTextField * testField = notification.object;
    if (testField.text.length != 0 && testField.isBoll) {
        [UIView animateWithDuration:0.2f animations:^{
            CGRect rect;
            rect = labelPlaceHoldInput.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHoldInput.frame = rect;
            labelPlaceHoldInput.alpha = 0.f;
            testField.isBoll = NO;
        }];
    } else if (testField.text.length == 0 && !testField.isBoll) {
        [UIView animateWithDuration:0.25f animations:^{
            CGRect rect;
            rect = labelPlaceHoldInput.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHoldInput.frame = rect;
            labelPlaceHoldInput.alpha = 1.f;
            testField.isBoll = YES;
        }];
    }
}


//Отвязка от всех нотификаций------------------------------
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
