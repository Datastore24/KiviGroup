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
    UILabel * labelUp;
    UIView * mainView;
    BOOL keyboardUp;
}



- (instancetype)initWithView: (UIView*) view
                      PointY: (CGFloat) pointY
                    andImage: (NSString*) imageName
          andTextPlaceHolder: (NSString*) placeHolder
              andScrollWidth: (CGFloat) scrollWidth
                     andText: (NSString*) text
             andKeyboardType: (UIKeyboardType) keyboardType
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(20 + scrollWidth, pointY, view.frame.size.width - 40, 60);
        self.layer.cornerRadius = 30.f;
        if (isiPhone5 || isiPhone4s) {
            self.frame = CGRectMake(20 + scrollWidth, pointY, view.frame.size.width - 40, 50);
            self.layer.cornerRadius = 25.f;
        }
        self.backgroundColor = [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.5];
        keyboardUp = NO;
        
        mainView = view;
        
        //Картинка объекта--------
        UIImageView * imageViewInput = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
        imageViewInput.image = [UIImage imageNamed:imageName];
        imageViewInput.alpha = 0.5;
        [imageViewInput sizeThatFits:CGSizeMake(40, 40)];
        if (isiPhone5 || isiPhone4s) {
            imageViewInput.frame = CGRectMake(20, 7.5, 35, 35);
            [imageViewInput sizeThatFits:CGSizeMake(35, 35)];
        }
        [self addSubview:imageViewInput];
        
        //Ввод текста-------------
        self.textFieldInput = [[CustomTextField alloc] initWithCustomFrame:CGRectMake(70, 0, self.frame.size.width - 70, 60) andText:text typeKeyBoardType:keyboardType];
        if (isiPhone5 || isiPhone4s) {
            self.textFieldInput.frame = CGRectMake(70, 0, self.frame.size.width - 70, 50);
        }
        self.textFieldInput.delegate = self;
        self.textFieldInput.isBoll = YES;
        self.textFieldInput.keyboardType = UIKeyboardTypeDefault;
        self.textFieldInput.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textFieldInput.font = [UIFont fontWithName:FONTREGULAR size:17];
        self.textFieldInput.textColor = [UIColor whiteColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabel:) name:UITextFieldTextDidChangeNotification object:self.textFieldInput];
        [self addSubview:self.textFieldInput];
        
        //Плесхолдер --------------
        labelPlaceHoldInput = [[UILabel alloc] initWithFrame:self.textFieldInput.frame];
        labelPlaceHoldInput.text = placeHolder;
        labelPlaceHoldInput.textColor = [UIColor whiteColor];
        labelPlaceHoldInput.font = [UIFont fontWithName:FONTREGULAR size:17];
        [self addSubview:labelPlaceHoldInput];
        
        //Проверка на начилие текста-------------------------
        if (self.textFieldInput.text.length != 0) {
            self.textFieldInput.isBoll = NO;
            CGRect rect;
            rect = labelPlaceHoldInput.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHoldInput.frame = rect;
            labelPlaceHoldInput.alpha = 0.f;
        }
    }
    return self;
}


- (instancetype)initCheckoutWithView: (UIView*) view
                              PointY: (CGFloat) pointY
                  andTextPlaceHolder: (NSString*) placeHolder
                             andText: (NSString*) text
                     andKeyboardType: (UIKeyboardType) keyboardType
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(20, pointY, view.frame.size.width - 40, 40);
        self.layer.borderColor = [UIColor colorWithHexString:COLORGREEN].CGColor;
        self.layer.borderWidth = 1.f;
        if (isiPhone5 || isiPhone4s) {
            self.frame = CGRectMake(20, pointY, view.frame.size.width - 40, 30);

        }
        keyboardUp = NO;
        
        mainView = view;
        
        //Ввод текста-------------
        self.textFieldInput = [[CustomTextField alloc] initWithCustomFrame:CGRectMake(20, 0, self.frame.size.width - 70, 40) andText:text typeKeyBoardType:keyboardType];
        if (isiPhone5 || isiPhone4s) {
            self.textFieldInput.frame = CGRectMake(10, 0, self.frame.size.width - 70, 30);
        }
        self.textFieldInput.delegate = self;
        self.textFieldInput.isBoll = YES;
        self.textFieldInput.tag = 90;
        self.textFieldInput.keyboardType = UIKeyboardTypeDefault;
        self.textFieldInput.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textFieldInput.font = [UIFont fontWithName:FONTREGULAR size:17];
        self.textFieldInput.textColor = [UIColor colorWithHexString:COLORTEXTGRAY];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabel:) name:UITextFieldTextDidChangeNotification object:self.textFieldInput];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationStartid:) name:UITextFieldTextDidBeginEditingNotification object:self.textFieldInput];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationEnd:) name:UITextFieldTextDidEndEditingNotification object:self.textFieldInput];
        [self addSubview:self.textFieldInput];
        
        //Плесхолдер --------------
        labelPlaceHoldInput = [[UILabel alloc] initWithFrame:self.textFieldInput.frame];
        labelPlaceHoldInput.text = placeHolder;
        labelPlaceHoldInput.textColor = [UIColor colorWithHexString:COLORTEXTGRAY];
        labelPlaceHoldInput.font = [UIFont fontWithName:FONTLITE size:17];
        [self addSubview:labelPlaceHoldInput];
        
        labelUp = [[UILabel alloc] initWithFrame:CGRectMake(7, 0, 10, 35)];
        if (isiPhone5 || isiPhone4s) {
            labelUp.frame = CGRectMake(3, 0, 10, 25);
            
        }
        labelUp.text = @"+";
        if (self.textFieldInput.keyboardType == UIKeyboardTypeNumbersAndPunctuation && self.textFieldInput.text.length != 0) {
            labelUp.alpha = 1;
        } else {
            labelUp.alpha = 0;
        }
        [self addSubview:labelUp];
        
        //Проверка--------------------
        if (self.textFieldInput.text.length != 0) {
            self.textFieldInput.isBoll = NO;
            CGRect rect;
            rect = labelPlaceHoldInput.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHoldInput.frame = rect;
            labelPlaceHoldInput.alpha = 0.f;
        }
        
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
    if (testField.keyboardType == UIKeyboardTypeNumbersAndPunctuation) {
        if ([testField.text isEqualToString:@""]) {
            testField.text = @"7";
        }
    }
    if (testField.text.length != 0 && testField.isBoll) {
        [UIView animateWithDuration:0.2 animations:^{
            CGRect rect;
            rect = labelPlaceHoldInput.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHoldInput.frame = rect;
            labelPlaceHoldInput.alpha = 0.f;
            testField.isBoll = NO;
        }];
    } else if (testField.text.length == 0 && !testField.isBoll) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect rect;
            rect = labelPlaceHoldInput.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHoldInput.frame = rect;
            labelPlaceHoldInput.alpha = 1.f;
            testField.isBoll = YES;
        }];
    }
}

- (void) animationStartid: (NSNotification*) notification {
    CustomTextField * testField = notification.object;
    if (testField.keyboardType == UIKeyboardTypeNumbersAndPunctuation) {
        if (testField.text.length == 0 || [testField.text isEqualToString:@"7"]) {
            testField.text = @"7";
            labelUp.alpha = 1;
            [UIView animateWithDuration:0.2 animations:^{
                CGRect rect;
                rect = labelPlaceHoldInput.frame;
                rect.origin.x = rect.origin.x + 100.f;
                labelPlaceHoldInput.frame = rect;
                labelPlaceHoldInput.alpha = 0.f;
                testField.isBoll = NO;
            }];
        }
    }
}

- (void) animationEnd: (NSNotification*) notification {
    CustomTextField * testField = notification.object;
    if (testField.keyboardType == UIKeyboardTypeNumbersAndPunctuation) {
        if ([testField.text isEqualToString:@"7"]) {
            testField.text = @"";
            labelUp.alpha = 0;
            [UIView animateWithDuration:0.25 animations:^{
                CGRect rect;
                rect = labelPlaceHoldInput.frame;
                rect.origin.x = rect.origin.x - 100.f;
                labelPlaceHoldInput.frame = rect;
                labelPlaceHoldInput.alpha = 1.f;
                testField.isBoll = YES;
            }];
        }
    }
        
}

//Поднимаем текст вверх--------------------------------------
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 90) {
        
    } else {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect rectAnimation = mainView.frame;
            rectAnimation.origin.y -= 90;
        mainView.frame = rectAnimation;
    } completion:^(BOOL finished) {
    }];
    }
    
}

//Восстанавливаем стандартный размер-----------------------
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 90) {
        
    } else {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect rectAnimation = mainView.frame;
            rectAnimation.origin.y += 90;
        mainView.frame = rectAnimation;
    } completion:^(BOOL finished) {
    }];
    }
}



// NOTE: This code assumes you have set the UITextField(s)'s delegate property to the object that will contain this code, because otherwise it would never be called.
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    if (textField.keyboardType == UIKeyboardTypeNumbersAndPunctuation) {
        NSNumberFormatter * nf = [[NSNumberFormatter alloc] init];
        [nf setNumberStyle:NSNumberFormatterNoStyle];
        
        NSString * newString = [NSString stringWithFormat:@"%@%@",textField.text,string];
        NSNumber * number = [nf numberFromString:newString];
        
        if (number)
            return YES;
        else
            return NO;
    }
    
    return YES;
}

//Отвязка от всех нотификаций------------------------------
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
