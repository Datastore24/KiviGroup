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
        self.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_400 alpha:0.75f].CGColor;
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
        self.labelPlaceHoldInput = [[UILabel alloc] initWithFrame:self.textFieldInput.frame];
        self.labelPlaceHoldInput.text = placeHolder;
        self.labelPlaceHoldInput.textColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_400 alpha:0.5f];
        self.labelPlaceHoldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:12];
        [self addSubview:self.labelPlaceHoldInput];
        
    }
    return self;
}



- (instancetype)initInputTextWithView: (UIView*) view
                              andRect: (CGRect) frame
                             andImage: (NSString*) imageName
                   andTextPlaceHolder: (NSString*) placeHolder
                          colorBorder: (NSString*) colorBorder
{
    self = [super init];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        keyboardUp = NO;
        
        //Ввод текста-------------
        self.textFieldInput = [[CustomTextField alloc] initWithFrame:CGRectMake(15.f, 0.f, self.frame.size.width - 15.f, self.frame.size.height)];
        self.textFieldInput.delegate = self;
        self.textFieldInput.isBoll = YES;
        self.textFieldInput.keyboardType = UIKeyboardTypeDefault;
        self.textFieldInput.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textFieldInput.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:9];
        self.textFieldInput.textColor = [UIColor blackColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabel:) name:UITextFieldTextDidChangeNotification object:self.textFieldInput];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelStart:) name:UITextFieldTextDidBeginEditingNotification object:self.textFieldInput];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelEnd:) name:UITextFieldTextDidEndEditingNotification object:self.textFieldInput];
        [self addSubview:self.textFieldInput];
        
        //Плесхолдер --------------
        self.labelPlaceHoldInput = [[UILabel alloc] initWithFrame:self.textFieldInput.frame];
        self.labelPlaceHoldInput.text = placeHolder;
        self.labelPlaceHoldInput.textColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_300 alpha:1.f];
        self.labelPlaceHoldInput.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:9];
        [self addSubview:self.labelPlaceHoldInput];
        
    }
    return self;
}


- (instancetype)initInputTextSearchWithView: (UIView*) view
                              andRect: (CGRect) frame
                             andImage: (NSString*) imageName
                   andTextPlaceHolder: (NSString*) placeHolder
                          colorBorder: (NSString*) colorBorder
{
    self = [super init];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        keyboardUp = NO;
        
        //Ввод текста-------------
        self.textFieldInput = [[CustomTextField alloc] initWithFrame:CGRectMake(15.f, 0.f, self.frame.size.width - 15.f, self.frame.size.height)];
        self.textFieldInput.delegate = self;
        self.textFieldInput.isBoll = YES;
        self.textFieldInput.keyboardType = UIKeyboardTypeDefault;
        self.textFieldInput.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textFieldInput.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:13];
        self.textFieldInput.textColor = [UIColor blackColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabel:) name:UITextFieldTextDidChangeNotification object:self.textFieldInput];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditingCustomLabel:) name:UITextFieldTextDidEndEditingNotification object:self.textFieldInput];
        [self addSubview:self.textFieldInput];
        
        //Плесхолдер --------------
        self.labelPlaceHoldInput = [[UILabel alloc] initWithFrame:self.textFieldInput.frame];
        self.labelPlaceHoldInput.text = placeHolder;
        self.labelPlaceHoldInput.textColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_300 alpha:1.f];
        self.labelPlaceHoldInput.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:13];
        [self addSubview:self.labelPlaceHoldInput];
        
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
    [self.delegate inputText:self];
    CustomTextField * testField = notification.object;
    if (testField.text.length != 0 && testField.isBoll) {
        [UIView animateWithDuration:0.2f animations:^{
            CGRect rect;
            rect = self.labelPlaceHoldInput.frame;
            rect.origin.x = rect.origin.x + 100.f;
            self.labelPlaceHoldInput.frame = rect;
            self.labelPlaceHoldInput.alpha = 0.f;
            testField.isBoll = NO;
        }];
    } else if (testField.text.length == 0 && !testField.isBoll) {
        [UIView animateWithDuration:0.25f animations:^{
            CGRect rect;
            rect = self.labelPlaceHoldInput.frame;
            rect.origin.x = rect.origin.x - 100.f;
            self.labelPlaceHoldInput.frame = rect;
            self.labelPlaceHoldInput.alpha = 1.f;
            testField.isBoll = YES;
        }];
    }
    if (testField.keyboardType == UIKeyboardTypeNumbersAndPunctuation && testField.tag >= 225 && testField.tag < 250) {
        
        if (testField.text.length == 5) {
            testField.text = [testField.text substringToIndex:[testField.text length] - 1];
        }
        
        if (testField.text.length > 11) {
            testField.text = [testField.text substringToIndex:[testField.text length] - 1];
        }

    } else if (testField.keyboardType == UIKeyboardTypeNumbersAndPunctuation && testField.tag >= 800 && testField.tag < 810) {
        
    } else if (testField.keyboardType == UIKeyboardTypeNumbersAndPunctuation) {
        if (testField.text.length <= 2) {
            testField.text = @"+7";
        }
    }
}

- (void) animationLabelStart: (NSNotification*) notification {
    CustomTextField * testField = notification.object;
    if (testField.keyboardType == UIKeyboardTypeNumbersAndPunctuation && testField.tag >= 225 && testField.tag < 250) {
        

    } else if (testField.keyboardType == UIKeyboardTypeNumbersAndPunctuation && testField.tag >= 800 && testField.tag < 810) {
        
    }  else if (testField.keyboardType == UIKeyboardTypeNumbersAndPunctuation) {
        if (testField.text.length <= 2) {
            testField.text = @"+7";
            [UIView animateWithDuration:0.2f animations:^{
                CGRect rect;
                rect = self.labelPlaceHoldInput.frame;
                rect.origin.x = rect.origin.x + 100.f;
                self.labelPlaceHoldInput.frame = rect;
                self.labelPlaceHoldInput.alpha = 0.f;
                testField.isBoll = NO;
            }];
        }
    }
}

- (void) animationLabelEnd: (NSNotification*) notification {
    CustomTextField * testField = notification.object;
    if (testField.keyboardType == UIKeyboardTypeNumbersAndPunctuation && testField.tag >= 225 && testField.tag < 250) {
   
    } else if (testField.keyboardType == UIKeyboardTypeNumbersAndPunctuation && testField.tag >= 800 && testField.tag < 810) {
        
    }  else if (testField.keyboardType == UIKeyboardTypeNumbersAndPunctuation) {
        if (testField.text.length <= 2) {
            [UIView animateWithDuration:0.2f animations:^{
                CGRect rect;
                rect = self.labelPlaceHoldInput.frame;
                rect.origin.x = rect.origin.x - 100.f;
                self.labelPlaceHoldInput.frame = rect;
                self.labelPlaceHoldInput.alpha = 1.f;
                testField.isBoll = YES;
            }];
            testField.text = @"";
        }
    }
}

- (void) endEditingCustomLabel: (NSNotification*) notification {
    CustomTextField * testField = notification.object;
    if (testField.text.length != 0) {
        [UIView animateWithDuration:0.25f animations:^{
            CGRect rect;
            rect = self.labelPlaceHoldInput.frame;
            rect.origin.x = rect.origin.x - 100.f;
            self.labelPlaceHoldInput.frame = rect;
            self.labelPlaceHoldInput.alpha = 1.f;
            testField.isBoll = YES;
        }];
    }
}


//Отвязка от всех нотификаций------------------------------
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    
    
    if (textField.keyboardType == UIKeyboardTypeNumbersAndPunctuation && textField.tag >= 225 && textField.tag < 250) {
            NSString *text = [textField.text stringByReplacingCharactersInRange:range
                                                                     withString: string];
        
            if (text.length == 4) { //or probably better, check if int
                textField.text = [NSString stringWithFormat: @"%@ ", text];
                return NO;
            }
        
        if (text.length > 10) {
            return YES;
        }

    }
    
    
    
    if (textField.keyboardType == UIKeyboardTypeNumbersAndPunctuation) {
        NSCharacterSet *nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        return ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0) || [string isEqualToString:@""];
    } else if (textField.keyboardType == UIKeyboardTypeDefault) {
        NSRange spaceRange = [string rangeOfString:@" "];
        if (spaceRange.location != NSNotFound)
        {
            return NO;
        } else {
            return YES;
        }
    }
    
    

    return YES;
}


@end
