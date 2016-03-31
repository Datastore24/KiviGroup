//
//  LoginView.m
//  PsychologistIOS
//
//  Created by Viktor on 31.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "LoginView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@implementation LoginView
{
    
    UIScrollView * mainScrollView;
    
    UITextField * textFieldPhone;
    UILabel * labelPlaceHolderPhone;
    BOOL isBool;
    BOOL isBoolSMS;
}

- (instancetype)initWithBackgroundView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        //Основной фон---------------------
        UIImageView * mainImageView = [[UIImageView alloc] initWithFrame:self.frame];
        mainImageView.image = [UIImage imageNamed:@"mainFoniOS.png"];
        [self addSubview:mainImageView];
    }
    return self;
}


- (instancetype)initWithContentView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        isBool = YES;
        isBoolSMS = YES;
        
        mainScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        [self addSubview:mainScrollView];
        
        //Вью ввода телефона----------------
        UIView * viewPhone = [[UIView alloc] initWithFrame:CGRectMake(16, 440, self.frame.size.width - 32, 64)];
        viewPhone.backgroundColor = [UIColor colorWithHexString:@"a04c43"];
        viewPhone.layer.borderColor = [UIColor colorWithHexString:@"e18c82"].CGColor;
        viewPhone.layer.borderWidth = 0.4f;
        viewPhone.layer.cornerRadius = 5;
        [mainScrollView addSubview:viewPhone];
        
        //Ввод телефона---------------------
        textFieldPhone = [[UITextField alloc] initWithFrame:CGRectMake(24, 0, viewPhone.frame.size.width - 48, viewPhone.frame.size.height)];
        textFieldPhone.delegate = self;
        textFieldPhone.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        textFieldPhone.autocorrectionType = UITextAutocorrectionTypeNo;
        textFieldPhone.font = [UIFont fontWithName:FONTLITE size:19];
        textFieldPhone.textColor = [UIColor colorWithHexString:@"b3b3b4"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelPhone:) name:UITextFieldTextDidChangeNotification object:textFieldPhone];
        [viewPhone addSubview:textFieldPhone];
        
        //Плэйс холдер телефона----------------------------------------------------------
        labelPlaceHolderPhone = [[UILabel alloc] initWithFrame:CGRectMake(24, 0, viewPhone.frame.size.width - 48, viewPhone.frame.size.height)];
        labelPlaceHolderPhone.tag = 3022;
        labelPlaceHolderPhone.text = @"Телефон";
        labelPlaceHolderPhone.textColor = [UIColor colorWithHexString:@"b3b3b4"];
        labelPlaceHolderPhone.font = [UIFont fontWithName:FONTLITE size:19];
        [viewPhone addSubview:labelPlaceHolderPhone];
        
        //Кнопка входа---------------------------------------------------------------------
        UIButton * buttonLogin = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonLogin.frame = CGRectMake(16, viewPhone.frame.size.height + viewPhone.frame.origin.y + 16, self.frame.size.width - 32, 64);
        buttonLogin.backgroundColor = [UIColor colorWithHexString:@"3cc354"];
        buttonLogin.layer.borderColor = [UIColor whiteColor].CGColor;
        buttonLogin.layer.cornerRadius = 30;
        [buttonLogin setTitle:@"ПОЛУЧИТЬ КОД СМС" forState:UIControlStateNormal];
        [buttonLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonLogin.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:17];
        [mainScrollView addSubview:buttonLogin];
        
        
        
    }
    return self;
}

#pragma mark - UITextFieldDelegate

//Скрытие клавиатуры----------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//Метод ввода тоьлко чисел-----------------------------------
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    /* for backspace */
    if([string length]==0){
        return YES;
    }
    
    /*  limit to only numeric characters  */
    
    if ([textField isEqual:textFieldPhone]) {
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:i];
            if ([myCharSet characterIsMember:c]) {
                
                
                /*  limit the users input to only 9 characters  */
                NSUInteger newLength = [textField.text length] + [string length] - range.length;
                return (newLength > 12) ? NO : YES;
            }
        }
        return NO;
    } else {
        /*  limit the users input to only 9 characters  */
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 6) ? NO : YES;
    }
    
    return NO;
}

//Анимация Лейблов при вводе Телефона------------------------
- (void) animationLabelPhone: (NSNotification*) notification
{
    UITextField * testField = notification.object;
    
    if (testField.text.length < 3) {
        testField.text = @"+7";
    }
    
    
    if (testField.text.length != 0 && isBool) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderPhone.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHolderPhone.frame = rect;
            labelPlaceHolderPhone.alpha = 0.f;
            isBool = NO;
        }];
    } else if (testField.text.length == 0 && !isBool) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderPhone.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHolderPhone.frame = rect;
            labelPlaceHolderPhone.alpha = 1.f;
            isBool = YES;
        }];
    }
}

////Анимация Лейблов при вводе SMS-------------------------
//- (void) animationLabelSMS: (NSNotification*) notification
//{
//    UITextField * testField = notification.object;
//    if (testField.text.length != 0 && isBoolSMS) {
//        [UIView animateWithDuration:0.3 animations:^{
//            CGRect rect;
//            rect = labelPlaceHolderSMS.frame;
//            rect.origin.x = rect.origin.x + 100.f;
//            labelPlaceHolderSMS.frame = rect;
//            labelPlaceHolderSMS.alpha = 0.f;
//            isBoolSMS = NO;
//        }];
//    } else if (testField.text.length == 0 && !isBoolSMS) {
//        [UIView animateWithDuration:0.3 animations:^{
//            CGRect rect;
//            rect = labelPlaceHolderSMS.frame;
//            rect.origin.x = rect.origin.x - 100.f;
//            labelPlaceHolderSMS.frame = rect;
//            labelPlaceHolderSMS.alpha = 1.f;
//            isBoolSMS = YES;
//        }];
//    }
//}

//Поднимаем текст вверх--------------------------------------
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:textFieldPhone]) {
        if ([textField.text isEqualToString:@""]) {
            textField.text = @"+7";
            if (textField.text.length != 0 && isBool) {
                [UIView animateWithDuration:0.3 animations:^{
                    CGRect rect;
                    rect = labelPlaceHolderPhone.frame;
                    rect.origin.x = rect.origin.x + 100.f;
                    labelPlaceHolderPhone.frame = rect;
                    labelPlaceHolderPhone.alpha = 0.f;
                    isBool = NO;
                }];
            }
            
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        mainScrollView.contentOffset = (CGPoint){
            0, // ось x нас не интересует
            30 // Скроллим скролл к верхней границе текстового поля - Вы можете настроить эту величину по своему усмотрению
        };
    }];

    textField.textAlignment = NSTextAlignmentLeft;
}

//Восстанавливаем стандартный размер-----------------------
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:textFieldPhone]) {
        if ([textField.text isEqualToString:@"+7"]) {
            textField.text = @"";
            if (textField.text.length == 0 && !isBool) {
                [UIView animateWithDuration:0.3 animations:^{
                    CGRect rect;
                    rect = labelPlaceHolderPhone.frame;
                    rect.origin.x = rect.origin.x - 100.f;
                    labelPlaceHolderPhone.frame = rect;
                    labelPlaceHolderPhone.alpha = 1.f;
                    isBool = YES;
                }];
            }
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
            mainScrollView.contentOffset = (CGPoint){0, 0}; // Возвращаем скролл в начало, так как редактирование текстового поля закончено
    }];
    textField.textAlignment = NSTextAlignmentCenter;
}

//Отвязка от всех нотификаций------------------------------
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
