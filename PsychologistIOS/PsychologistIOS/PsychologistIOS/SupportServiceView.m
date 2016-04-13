//
//  SupportServiceView.m
//  PsychologistIOS
//
//  Created by Viktor on 13.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "SupportServiceView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@interface SupportServiceView () <UITextFieldDelegate, UITextViewDelegate>

@end

@implementation SupportServiceView
{
    //Имя
    UITextField * textFieldName;
    UILabel * labelPlaceHolderName;
    BOOL isBoolName;
    //Потча
    UITextField * textFieldMail;
    UILabel * labelPlaceHolderMail;
    BOOL isBoolMail;
    //Текст
    UITextView * mainMailText;
    UILabel * labelPlaceHolderText;
    BOOL isBoolText;
}

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 64);
        
        isBoolName = YES;
        isBoolMail = YES;
        isBoolText = YES;
        
        //Основной заголовок-------------------------------------------
        UILabel * labelMainTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 48, self.frame.size.width, 16)];
        labelMainTitle.text = @"НАПИШИТЕ НАМ И МЫ СВЯЖЕМСЯ С ВАМИ";
        labelMainTitle.textColor = [UIColor colorWithHexString:@"4f4f4e"];
        labelMainTitle.textAlignment = NSTextAlignmentCenter;
        labelMainTitle.font = [UIFont fontWithName:FONTREGULAR size:13];
        [self addSubview:labelMainTitle];
        
        //Имя----------------
        //Вью Имени-------------------------------------------------------
        UIView * viewName = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 168, 88, 336, 40)];
        viewName.layer.cornerRadius = 10.f;
        viewName.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
        viewName.layer.borderColor = [UIColor colorWithHexString:@"4a4a4a"].CGColor;
        viewName.layer.borderWidth = 0.4f;
        [self addSubview:viewName];
        
        //Ввод Имени-----------------------------------------------------------------
        textFieldName = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, viewName.frame.size.width - 40, 40)];
        textFieldName.delegate = self;
        textFieldName.autocorrectionType = UITextAutocorrectionTypeNo;
        textFieldName.font = [UIFont fontWithName:FONTREGULAR size:13];
        textFieldName.textColor = [UIColor colorWithHexString:@"4f4f4e"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelName:) name:UITextFieldTextDidChangeNotification object:textFieldName];
        [viewName addSubview:textFieldName];
        
        //Плэйс холдер Имени----------------------------------------------------------
        labelPlaceHolderName = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, viewName.frame.size.width - 40, 40)];
        labelPlaceHolderName.text = @"Имя";
        labelPlaceHolderName.textColor = [UIColor colorWithHexString:@"4f4f4e"];
        labelPlaceHolderName.font = [UIFont fontWithName:FONTREGULAR size:13];
        [viewName addSubview:labelPlaceHolderName];
        
        //Почта------------
        //Вью Почты-----------------------------------------------------------------
        UIView * viewMail = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 168, 160, 336, 40)];
        viewMail.layer.cornerRadius = 10.f;
        viewMail.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
        viewMail.layer.borderColor = [UIColor colorWithHexString:@"4a4a4a"].CGColor;
        viewMail.layer.borderWidth = 0.4f;
        [self addSubview:viewMail];
        
        //Ввод Имени-----------------------------------------------------------------
        textFieldMail = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, viewName.frame.size.width - 40, 40)];
        textFieldMail.delegate = self;
        textFieldMail.autocorrectionType = UITextAutocorrectionTypeNo;
        textFieldMail.font = [UIFont fontWithName:FONTREGULAR size:13];
        textFieldMail.textColor = [UIColor colorWithHexString:@"4f4f4e"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelMail:) name:UITextFieldTextDidChangeNotification object:textFieldMail];
        [viewMail addSubview:textFieldMail];
        
        //Плэйс холдер Имени----------------------------------------------------------
        labelPlaceHolderMail = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, viewName.frame.size.width - 40, 40)];
        labelPlaceHolderMail.text = @"Email";
        labelPlaceHolderMail.textColor = [UIColor colorWithHexString:@"4f4f4e"];
        labelPlaceHolderMail.font = [UIFont fontWithName:FONTREGULAR size:13];
        [viewMail addSubview:labelPlaceHolderMail];
        
        //Текст Письма----------
        //Вью текста---------------------------------------------------------------
        UIView * viewText = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 168, 232, 336, 160)];
        viewText.layer.cornerRadius = 10.f;
        viewText.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
        viewText.layer.borderColor = [UIColor colorWithHexString:@"4a4a4a"].CGColor;
        viewText.layer.borderWidth = 0.4f;
        [self addSubview:viewText];
        
        //Текст вью----------------------------------------------------------------
        mainMailText = [[UITextView alloc] initWithFrame:CGRectMake(16, 0, viewText.frame.size.width - 32, 158)];
        mainMailText.delegate = self;
        mainMailText.textColor = [UIColor colorWithHexString:@"4f4f4e"];
        mainMailText.font = [UIFont fontWithName:FONTREGULAR size:13];
        mainMailText.editable = YES;
        mainMailText.scrollEnabled = YES;
        mainMailText.backgroundColor = nil;
        mainMailText.showsVerticalScrollIndicator = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelText:) name:UITextViewTextDidChangeNotification object:mainMailText];
        [viewText addSubview:mainMailText];
        
        //Плэйс холдер Текста письма-----------------------------------------------------
        labelPlaceHolderText = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, viewName.frame.size.width - 40, 20)];
        labelPlaceHolderText.text = @"Сообщение";
        labelPlaceHolderText.textColor = [UIColor colorWithHexString:@"4f4f4e"];
        labelPlaceHolderText.font = [UIFont fontWithName:FONTREGULAR size:13];
        [viewText addSubview:labelPlaceHolderText];
        
        //Кнопка отправить--------------------------------------------------------------
        UIButton * buttonSend = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonSend.frame = CGRectMake(self.frame.size.width / 2 - 168, viewText.frame.size.height + viewText.frame.origin.y + 40, 336, 40);
        buttonSend.backgroundColor = [UIColor colorWithHexString:@"74b65f"];
        [buttonSend setTitle:@"ОТПРАВИТЬ" forState:UIControlStateNormal];
        [buttonSend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonSend.titleLabel.font = [UIFont fontWithName:FONTBOND size:15];
        buttonSend.layer.cornerRadius = 10.f;
        [buttonSend addTarget:self action:@selector(buttonSendAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonSend];
        
        //Кнопка скайпа-------------------------------------------------------------------
        UIButton * buttonSkype = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonSkype.frame = CGRectMake(40, buttonSend.frame.origin.y + buttonSend.frame.size.height + 100, 32, 32);
        UIImage * imgeButtonSkype = [UIImage imageNamed:@"skypeButtonImage.png"];
        [buttonSkype setImage:imgeButtonSkype forState:UIControlStateNormal];
        [buttonSkype addTarget:self action:@selector(buttonSkypeAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonSkype];
        
        //Лейбл кнопки скайп--------------------------------------------------------------
        UILabel * labelButtonSkype = [[UILabel alloc] initWithFrame:CGRectMake(80, buttonSkype.frame.origin.y + 10, 60, 16)];
        labelButtonSkype.text = @"Support";
        labelButtonSkype.textColor = [UIColor colorWithHexString:@"5c5b5a"];
        labelButtonSkype.font = [UIFont fontWithName:FONTREGULAR size:15];
        [self addSubview:labelButtonSkype];
        
        //Кнопка звонка-------------------------------------------------------------------
        UIButton * buttonPhone = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonPhone.frame = CGRectMake(236, buttonSkype.frame.origin.y + 7, 32, 24);
        UIImage * imgeButtonPhone = [UIImage imageNamed:@"phoneButtonImage.png"];
        [buttonPhone setImage:imgeButtonPhone forState:UIControlStateNormal];
        [buttonPhone addTarget:self action:@selector(buttonPhoneAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonPhone];
        
        //Лейбл кнопки позвонить--------------------------------------------------------------
        UILabel * labelButtonPhone = [[UILabel alloc] initWithFrame:CGRectMake(272, buttonPhone.frame.origin.y + 4, 160, 16)];
        labelButtonPhone.text = @"8 (999) 99 99 99";
        labelButtonPhone.textColor = [UIColor colorWithHexString:@"5c5b5a"];
        labelButtonPhone.font = [UIFont fontWithName:FONTREGULAR size:15];
        [self addSubview:labelButtonPhone];
        
        
        

    }
    return self;
}

//Анимация Лейблов при вводе Имени-------------------------
- (void) animationLabelName: (NSNotification*) notification
{
    UITextField * testField = notification.object;
    if (testField.text.length != 0 && isBoolName) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderName.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHolderName.frame = rect;
            labelPlaceHolderName.alpha = 0.f;
            isBoolName = NO;
        }];
    } else if (testField.text.length == 0 && !isBoolName) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderName.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHolderName.frame = rect;
            labelPlaceHolderName.alpha = 1.f;
            isBoolName = YES;
        }];
    }
}

//Анимация Лейблов при вводе Почты-------------------------
- (void) animationLabelMail: (NSNotification*) notification
{
    UITextField * testField = notification.object;
    if (testField.text.length != 0 && isBoolMail) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderMail.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHolderMail.frame = rect;
            labelPlaceHolderMail.alpha = 0.f;
            isBoolMail = NO;
        }];
    } else if (testField.text.length == 0 && !isBoolMail) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderMail.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHolderMail.frame = rect;
            labelPlaceHolderMail.alpha = 1.f;
            isBoolMail = YES;
        }];
    }
}

//Анимация Лейблов при вводе Почты-------------------------
- (void) animationLabelText: (NSNotification*) notification
{
    UITextView * testView = notification.object;
    if (testView.text.length != 0 && isBoolText) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderText.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHolderText.frame = rect;
            labelPlaceHolderText.alpha = 0.f;
            isBoolText = NO;
        }];
    } else if (testView.text.length == 0 && !isBoolText) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderText.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHolderText.frame = rect;
            labelPlaceHolderText.alpha = 1.f;
            isBoolText = YES;
        }];
    }
}

#pragma mark - UITextFieldDelegate

//Скрытие клавиатуры----------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - UITextViewDelegate

//Скрытие клавиатуры----------------------------------------
- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
    }
    return YES;
}

#pragma mark - DEALLOC
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Action Methods

//Действие кнпоки отправить-----------------------------------
- (void) buttonSendAction
{
    NSLog(@"Кнопка отправить");
}

//Действие кнопки Skype---------------------------------------
- (void) buttonSkypeAction
{
    NSLog(@"Skype !!!!");
}

//Действие кнопки позвонить----------------------------------
- (void) buttonPhoneAction
{
    NSLog(@"Дзынь дзынь");
}


@end
