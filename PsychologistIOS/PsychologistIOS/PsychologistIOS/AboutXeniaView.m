//
//  AboutXeniaView.m
//  PsychologistIOS
//
//  Created by Viktor on 10.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "AboutXeniaView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@implementation AboutXeniaView
{
    NSArray * arrayImage;
    
    //Алерт
    UIView * darkView;
    UIView * alertViewXenia;
    UITextView * mainAlertText;
    UITextField * textFieldMail;
    UILabel * labelPlaceHolderMail;
    BOOL isBoolEmail;
}

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 64);
        
        isBoolEmail = YES;
        
        //Масив картинок------------------------------
        arrayImage = [NSArray arrayWithObjects:@"imageVK.png", @"imageFace.png", @"imageInst.png", @"imagePeres.png", @"imageSkype.png", nil];
        
        //Основная картинка Ксении--------------------
        UIImageView * mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 84, 24, 168, 168)];
        mainImageView.layer.cornerRadius = 84;
//        mainImageView.layer.borderColor = [UIColor colorWithHexString:@"f69679"].CGColor;
//        mainImageView.layer.borderWidth = 0.4f;
        mainImageView.image = [UIImage imageNamed:@"imageXenia.png"];
        [self addSubview:mainImageView];
        
        //Заголовок------------------------------------
        UILabel * mainTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 208, self.frame.size.width, 22)];
        mainTitle.text = @"Ксения Буракова";
        mainTitle.textColor = [UIColor colorWithHexString:@"515050"];
        mainTitle.textAlignment = NSTextAlignmentCenter;
        mainTitle.font = [UIFont fontWithName:FONTREGULAR size:22];
        [self addSubview:mainTitle];
        
        //Подзаголовок----------------------------------
        UILabel * subTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 238, self.frame.size.width, 16)];
        subTitle.text = @"Профессиональный психолог";
        subTitle.textColor = [UIColor colorWithHexString:@"f26e6e"];
        subTitle.textAlignment = NSTextAlignmentCenter;
        subTitle.font = [UIFont fontWithName:FONTLITE size:13];
        [self addSubview:subTitle];
        
        //Основной текст--------------------------------
        UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 268, self.frame.size.width - 48, 160)];
        textLabel.numberOfLines = 0;
        textLabel.text = @"Одним из важных условий эффективной психологической \nпомощи становится целевая установка психолога-практика, \nмотивы его профессиональной деятельности. \nДействительно ли он желает оказывать помощь людям, \nделая доброе дело, или же смотрит на оказываемую \nпомощь, как на возможность больше зарабатывать на \nнесчастьях людей? трудные для клиента дни, или же \nостался довольным, что получил хорошее материальное вознаграждение";
        textLabel.textColor = [UIColor colorWithHexString:@"5b5b5b"];
        textLabel.font = [UIFont fontWithName:FONTREGULAR size:13];
        [self addSubview:textLabel];
        
        //Кнопка Рекомендую--------------------------------------
        UIButton * buttonRecommend = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonRecommend.frame = CGRectMake(24, 450, self.frame.size.width - 48, 48);
        buttonRecommend.backgroundColor = nil;
        buttonRecommend.layer.cornerRadius = 25;
        buttonRecommend.layer.borderColor = [UIColor colorWithHexString:@"4babe4"].CGColor;
        buttonRecommend.layer.borderWidth = 1.f;
        [buttonRecommend setTitle:@"РЕКОМЕНДУЮ" forState:UIControlStateNormal];
        [buttonRecommend setTitleColor:[UIColor colorWithHexString:@"4babe4"] forState:UIControlStateNormal];
        buttonRecommend.titleLabel.font = [UIFont fontWithName:FONTLITE size:16];
        [buttonRecommend addTarget:self action:@selector(buttonRecommendAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonRecommend];
        
        //Добавить в избранное----------------------------------------------
        UIButton * buttonContact = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonContact.frame = CGRectMake(24, 506, self.frame.size.width - 48, 48);
        buttonContact.backgroundColor = [UIColor colorWithHexString:@"44d05c"];
        buttonContact.layer.cornerRadius = 25;
        buttonContact.layer.borderColor = [UIColor colorWithHexString:@"a6a6a6"].CGColor;
        buttonContact.layer.borderWidth = 1.f;
        [buttonContact setTitle:@"СВЯЗАТЬСЯ С КСЕНИЕЙ" forState:UIControlStateNormal];
        [buttonContact setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonContact.titleLabel.font = [UIFont fontWithName:FONTLITE size:16];
        [buttonContact addTarget:self action:@selector(buttonContactAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonContact];
        
        //Лейьл соц сети----------------------------------------------------
        UILabel * labelSocialNetwork = [[UILabel alloc] initWithFrame:CGRectMake(0, 562, self.frame.size.width, 16)];
        labelSocialNetwork.text = @"Я в социальных сетях";
        labelSocialNetwork.textColor = [UIColor colorWithHexString:@"a6a6a6"];
        labelSocialNetwork.textAlignment = NSTextAlignmentCenter;
        labelSocialNetwork.font = [UIFont fontWithName:FONTREGULAR size:13];
        [self addSubview:labelSocialNetwork];
        
        //Кнопки для соц сетей-----------------------------------------------
        for (int i = 0; i < arrayImage.count; i++) {
            UIButton * buttonSocial = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonSocial.frame = CGRectMake((self.frame.size.width / 2 - 150) + 64 * i, 594, 48, 48);
            buttonSocial.layer.cornerRadius = 24;
            UIImage * buttonSocialImage = [UIImage imageNamed:[arrayImage objectAtIndex:i]];
            [buttonSocial setImage:buttonSocialImage forState:UIControlStateNormal];
            buttonSocial.tag = 40 + i;
            [buttonSocial addTarget:self action:@selector(buttonSocialAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:buttonSocial];
        }
            
        //Сайт Ксении-----------------------------------------------------------
        UILabel * labelSite = [[UILabel alloc] initWithFrame:CGRectMake(0, 650, self.frame.size.width, 16)];
        labelSite.text = @"www.ksenia.ru";
        labelSite.textColor = [UIColor colorWithHexString:@"a6a6a6"];
        labelSite.textAlignment = NSTextAlignmentCenter;
        labelSite.font = [UIFont fontWithName:FONTREGULAR size:13];
        [self addSubview:labelSite];
        
#pragma mark - Create Alert
        
        //Затемнение-----------------------------------------------------
        darkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        darkView.backgroundColor = [UIColor blackColor];
        darkView.alpha = 0.0;
        [self addSubview:darkView];
        
        //Создаем алерт---------------------------------------------------
        alertViewXenia = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 192, -600, 384, 368)];
        alertViewXenia.layer.cornerRadius = 5.f;
        alertViewXenia.backgroundColor = [UIColor whiteColor];
        alertViewXenia.userInteractionEnabled = YES;
        [self addSubview:alertViewXenia];
        
        //Кнопка отмены--------------------------------------------------
        UIButton * buttonCancelXania = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonCancelXania.frame = CGRectMake(10, 10, 24, 24);
        UIImage *btnImage = [UIImage imageNamed:@"imageCancel.png"];
        [buttonCancelXania setImage:btnImage forState:UIControlStateNormal];
        [buttonCancelXania addTarget:self action:@selector(buttonCancelAction) forControlEvents:UIControlEventTouchUpInside];
        [alertViewXenia addSubview:buttonCancelXania];
        
        //Основной текст--------------------------------------------------
        mainAlertText = [[UITextView alloc] initWithFrame:CGRectMake(40, 40, alertViewXenia.frame.size.width - 80, 192)];
        mainAlertText.delegate = self;
        mainAlertText.textColor = [UIColor colorWithHexString:@"4b4a4a"];
        mainAlertText.font = [UIFont fontWithName:FONTULTRALIGHT size:12];
        mainAlertText.editable = YES;
        mainAlertText.scrollEnabled = YES;
        mainAlertText.layer.cornerRadius = 5.f;
        mainAlertText.layer.borderColor = [UIColor colorWithHexString:@"c0c0c0"].CGColor;
        mainAlertText.layer.borderWidth = 0.4f;
        [alertViewXenia addSubview:mainAlertText];
        
        //Вью почты-------------------------------------------------------
        UIView * viewMail = [[UIView alloc] initWithFrame:CGRectMake(40, mainAlertText.frame.size.height + mainAlertText.frame.origin.y + 16, alertViewXenia.frame.size.width - 80, 48)];
        viewMail.layer.cornerRadius = 5.f;
        viewMail.layer.borderColor = [UIColor colorWithHexString:@"c0c0c0"].CGColor;
        viewMail.layer.borderWidth = 0.4f;
        [alertViewXenia addSubview:viewMail];
        
        //Ввод телефона-----------------------------------------------------------------
        textFieldMail = [[UITextField alloc] initWithFrame:CGRectMake(60, mainAlertText.frame.size.height + mainAlertText.frame.origin.y + 16, alertViewXenia.frame.size.width - 120, 48)];
        textFieldMail.delegate = self;
        textFieldMail.autocorrectionType = UITextAutocorrectionTypeNo;
        textFieldMail.font = [UIFont fontWithName:FONTREGULAR size:19];
        textFieldMail.textColor = [UIColor colorWithHexString:@"c0c0c0"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelMail:) name:UITextFieldTextDidChangeNotification object:textFieldMail];
        [alertViewXenia addSubview:textFieldMail];
        
        //Плэйс холдер телефона----------------------------------------------------------
        labelPlaceHolderMail = [[UILabel alloc] initWithFrame:CGRectMake(60, mainAlertText.frame.size.height + mainAlertText.frame.origin.y + 16, alertViewXenia.frame.size.width - 120, 48)];
        labelPlaceHolderMail.tag = 3022;
        labelPlaceHolderMail.text = @"Введите Email";
        labelPlaceHolderMail.textColor = [UIColor colorWithHexString:@"c0c0c0"];
        labelPlaceHolderMail.font = [UIFont fontWithName:FONTREGULAR size:19];
        [alertViewXenia addSubview:labelPlaceHolderMail];
        
        //Кнопка открыть категорию--------------------------------------
        UIButton * buttonSend = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonSend.frame = CGRectMake(40, viewMail.frame.origin.y + viewMail.frame.size.height + 16, alertViewXenia.frame.size.width - 80, 48);
        buttonSend.backgroundColor = [UIColor colorWithHexString:@"44d05c"];
        buttonSend.layer.cornerRadius = 25;
        buttonSend.layer.borderColor = [UIColor colorWithHexString:@"a6a6a6"].CGColor;
        buttonSend.layer.borderWidth = 1.f;
        [buttonSend setTitle:@"ОТПРАВИТЬ" forState:UIControlStateNormal];
        [buttonSend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonSend.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:16];
        [buttonSend addTarget:self action:@selector(buttonSendAction) forControlEvents:UIControlEventTouchUpInside];
        [alertViewXenia addSubview:buttonSend];
        

        
  
    }
    return self;
}

#pragma mark - Action Methods
//действие кнопки рекомендую------------
- (void) buttonRecommendAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PUSH_ABOUT_XENIA_WITH_RECOMMEND object:nil];
}

//Действие кнопки связаться с Ксенией---
- (void) buttonContactAction
{
    //Анимация алерта---------------------------------------------
    [UIView animateWithDuration:0.1 animations:^{
        darkView.alpha = 0.4f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rectAlert = alertViewXenia.frame;
            rectAlert.origin.y += 750;
            alertViewXenia.frame = rectAlert;
        }];
    }];

}

//Действие кнопок соц сетей--------------
- (void) buttonSocialAction: (UIButton*) button
{
    for (int i = 0; i < arrayImage.count; i++) {
        if (button.tag == 40 + i) {
            NSLog(@"button %d", i + 1);
        }
    }
}

//Действие кнопки закрыть алерт
- (void) buttonCancelAction
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rectAlert = alertViewXenia.frame;
        rectAlert.origin.y -= 750;
        alertViewXenia.frame = rectAlert;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            darkView.alpha = 0;
        }];
    }];
}

//Действие кнопки отправить-------
- (void) buttonSendAction
{
    //Отправить письмо-------------
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rectAlert = alertViewXenia.frame;
        rectAlert.origin.y -= 750;
        alertViewXenia.frame = rectAlert;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            darkView.alpha = 0;
        }];
    }];
}

//Анимация Лейблов при вводе Почты-------------------------
- (void) animationLabelMail: (NSNotification*) notification
{
    UITextField * testField = notification.object;
    if (testField.text.length != 0 && isBoolEmail) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderMail.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHolderMail.frame = rect;
            labelPlaceHolderMail.alpha = 0.f;
            isBoolEmail = NO;
        }];
    } else if (testField.text.length == 0 && !isBoolEmail) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderMail.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHolderMail.frame = rect;
            labelPlaceHolderMail.alpha = 1.f;
            isBoolEmail = YES;
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



@end
