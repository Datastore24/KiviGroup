//
//  ApplicationView.m
//  mykamchatka
//
//  Created by Viktor on 26.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "ApplicationView.h"
#import "ApplicationController.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@interface ApplicationView () <UITextFieldDelegate>

@end

@implementation ApplicationView
{
    UITextField * textFieldLogin;
    UILabel * labelLoginPlaceholder;
    BOOL loginBool;
    
    UITextField * textFieldEmail;
    UILabel * labelEmailPlaceholder;
    BOOL emailBool;
    
    UIScrollView * mainScrollView;    
    BOOL confirmBool;
}

- (instancetype)initBackgroundWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        
        //Создаем фон из двух частей фонофого затемнения и изображения--------------------
        UIView * secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        secondView.backgroundColor = [UIColor colorWithHexString:@"eceff3"];
        [self addSubview:secondView];
        UIImageView * mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        mainImageView.image = [UIImage imageNamed:@"RequirementsFon.jpg"];
        mainImageView.alpha = 0.25f;
        [secondView addSubview:mainImageView];
        
    }
    return self;
}

- (instancetype)initWithView: (UIView*) view
{
    
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        mainScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        [self addSubview:mainScrollView];
        
       
        
        
        //Наносим текст-------------------------------------------------------------------
        UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, self.frame.size.width - 60, 350)];
        labelText.text = @"Для регистрации, пожалуйста, заполните предлагаемую форму, указав в соответствующих графах ваши фамилию, имя и адрес электронной почты, на который Оргкомитетом будет отправлено подтверждение вашей регистрации.\n\n\nПожалуйста, отправьте на электронный адрес Оргкомитета фотоконкурса photokamchatka@irinayarovaya.ru не более трех фотографий, соответствующих требованиям, не забыв при этом указать НОМИНАЦИЮ, НАЗВАНИЕ ФОТОГРАФИИ, ВАШ ВОЗРАСТ и НОМЕР КОНТАКТНОГО ТЕЛЕФОНА";
        labelText.numberOfLines = 0;
        labelText.font = [UIFont fontWithName:FONTREGULAR size:16];
        if (isiPhone5) {
            labelText.frame = CGRectMake(30, 0, self.frame.size.width - 60, 300);
            labelText.font = [UIFont fontWithName:FONTREGULAR size:13];
        }
        [mainScrollView addSubview:labelText];
        
        //Создаем вью Имени------------------------------------------------------------
        UIView * loginView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width/2) - 120, 360, 240, 35)];
        if (isiPhone5) {
            loginView.frame = CGRectMake((self.frame.size.width/2) - 100, 300, 200, 30);
        }
        loginView.backgroundColor = [UIColor whiteColor];
        loginView.layer.cornerRadius = 5.f;
        [mainScrollView addSubview:loginView];
        
        //ТекстФилд для Ввода имени-------------------------------------------------------
        textFieldLogin = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, 200, 35)];
        textFieldLogin.font = [UIFont fontWithName:FONTREGULAR size:16];
        if (isiPhone5) {
            textFieldLogin.frame = CGRectMake(20, 0, 180, 30);
            textFieldLogin.font = [UIFont fontWithName:FONTREGULAR size:14];
        }
        textFieldLogin.tag = 300;
        textFieldLogin.delegate = self;
        [loginView addSubview:textFieldLogin];
        
        //Кастомный плесхолдер------------------------------------------------------------
        labelLoginPlaceholder = [[UILabel alloc] init];
        labelLoginPlaceholder.frame = textFieldLogin.frame;
        labelLoginPlaceholder.text = @"Фамилия Имя";
        labelLoginPlaceholder.textColor = [UIColor colorWithHexString:@"5f5f5f"];
        labelLoginPlaceholder.font = [UIFont fontWithName:FONTREGULAR size:16];
        if (isiPhone5) {
            labelLoginPlaceholder.font = [UIFont fontWithName:FONTREGULAR size:14];
        }
        [loginView addSubview:labelLoginPlaceholder];
        
        //Булевая переменная для логина---------------------------------------------------
        loginBool = YES;
        
        //Нотификация изменения TextField--------------------------------------------------
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelLoginPlaceholder) name:UITextFieldTextDidChangeNotification object:nil];
        
        //Создаем вью Почты----------------------------------------------------------------
        UIView * emailView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width/2) - 120, 420, 240, 35)];
        if (isiPhone5) {
            emailView.frame = CGRectMake((self.frame.size.width/2) - 100, 340, 200, 30);
        }
        emailView.backgroundColor = [UIColor whiteColor];
        emailView.layer.cornerRadius = 5.f;
        [mainScrollView addSubview:emailView];
        
        //ТекстФилд для Ввода Потчы-------------------------------------------------------
        textFieldEmail = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, 200, 35)];
        textFieldEmail.font = [UIFont fontWithName:FONTREGULAR size:16];
        if (isiPhone5) {
            textFieldEmail.frame = CGRectMake(20, 0, 180, 30);
            textFieldEmail.font = [UIFont fontWithName:FONTREGULAR size:14];
        }
        textFieldEmail.tag = 300;
        textFieldEmail.delegate = self;
        [emailView addSubview:textFieldEmail];
        
        //Кастомный плесхолдер------------------------------------------------------------
        labelEmailPlaceholder = [[UILabel alloc] init];
        labelEmailPlaceholder.frame = textFieldLogin.frame;
        labelEmailPlaceholder.text = @"Email";
        labelEmailPlaceholder.textColor = [UIColor colorWithHexString:@"5f5f5f"];
        labelEmailPlaceholder.font = [UIFont fontWithName:FONTREGULAR size:16];
        if (isiPhone5) {
            labelEmailPlaceholder.font = [UIFont fontWithName:FONTREGULAR size:14];
        }
        [emailView addSubview:labelEmailPlaceholder];
        
        //Булевая переменная для логина---------------------------------------------------
        emailBool = YES;
        
        //Создаем кнопку отпраки заявки---------------------------------------------------
        UIButton * buttonSendApplication = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonSendApplication.frame = CGRectMake((self.frame.size.width/2) - 120, 480, 240, 35);
        buttonSendApplication.backgroundColor = [UIColor colorWithHexString:@"2f8fe7"];
        [buttonSendApplication setTitle:@"ОТПРАВИТЬ ЗАЯВКУ" forState:UIControlStateNormal];
        [buttonSendApplication setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonSendApplication.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:16];
        if (isiPhone5) {
            buttonSendApplication.frame = CGRectMake((self.frame.size.width/2) - 100, 380, 200, 30);
            buttonSendApplication.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:14];
        }
        buttonSendApplication.layer.cornerRadius = 5.f;
        [buttonSendApplication addTarget:self action:@selector(buttonSendApplicationAction)
                        forControlEvents:UIControlEventTouchUpInside];
        [mainScrollView addSubview:buttonSendApplication];
        
        //Создаем кнопку загрузки фото---------------------------------------------------
        UIImage *imageBarButton = [UIImage imageNamed:@"imagePhoto.png"];
        UIButton * buttonLoadPhoto = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonLoadPhoto.frame = CGRectMake((self.frame.size.width/2) - 120, 525, 40, 31);
        if (isiPhone5) {
            buttonLoadPhoto.frame = CGRectMake((self.frame.size.width/2) - 100, 420, 30, 23);
        }
        [buttonLoadPhoto setImage:imageBarButton forState:UIControlStateNormal];
        ApplicationController * appController = [[ApplicationController alloc] init];
        [buttonLoadPhoto addTarget:appController action:@selector(openPhotoLibraryButton:)
                              forControlEvents:UIControlEventTouchUpInside];
        [mainScrollView addSubview:buttonLoadPhoto];
        
         mainScrollView.contentSize = CGSizeMake(0, 565);
        
        //Создаем кнопку подтверждения условия соглашения---------------------------------
        UIButton * buttonСonfirm = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonСonfirm.frame = CGRectMake(30, mainScrollView.frame.size.height - 104, 20, 20);
        if (isiPhone5) {
            buttonСonfirm.frame = CGRectMake(15, mainScrollView.contentSize.height - 97, 15, 15);
        }
        buttonСonfirm.backgroundColor = [UIColor whiteColor];
        [buttonСonfirm addTarget:self action:@selector(buttonСonfirmAction) forControlEvents:UIControlEventTouchUpInside];
        [mainScrollView addSubview:buttonСonfirm];
        
        //Нет галочки---------------------------------------------------------------------
        confirmBool = NO;
        
        //Создаем лейбл подверждения лиц. соглашения--------------------------------------
        UILabel * labelConfirm = [[UILabel alloc] initWithFrame:CGRectMake(60, self.frame.size.height - 104, self.frame.size.width - 60, 20)];
        labelConfirm.text = @"Согласен(а) с правилами конкурса и условиями участия";
        labelConfirm.font = [UIFont fontWithName:FONTBOND size:10];
        if (isiPhone5) {
            labelConfirm.frame = CGRectMake(40, mainScrollView.contentSize.height - 104, mainScrollView.frame.size.width - 60, 30);
            labelConfirm.numberOfLines = 0;
        }
        [mainScrollView addSubview:labelConfirm];
        
        
        
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

//Анимация кастомного плейсхолдера для логина---------------
- (void) animationLabelLoginPlaceholder
{
    if (textFieldLogin.text.length != 0 && loginBool) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect customRect = labelLoginPlaceholder.frame;
            customRect.origin.x += 100;
            labelLoginPlaceholder.frame = customRect;
            labelLoginPlaceholder.alpha = 0.f;
            loginBool = NO;
        }];
    } else if (textFieldLogin.text.length == 0 && !loginBool) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect customRect = labelLoginPlaceholder.frame;
            customRect.origin.x -= 100;
            labelLoginPlaceholder.frame = customRect;
            labelLoginPlaceholder.alpha = 1.f;
            loginBool = YES;
        }];
    }
    
    
    if (textFieldEmail.text.length != 0 && emailBool) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect customRect = labelEmailPlaceholder.frame;
            customRect.origin.x += 100;
            labelEmailPlaceholder.frame = customRect;
            labelEmailPlaceholder.alpha = 0.f;
            emailBool = NO;
        }];
    } else if (textFieldEmail.text.length == 0 && !emailBool) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect customRect = labelEmailPlaceholder.frame;
            customRect.origin.x -= 100;
            labelEmailPlaceholder.frame = customRect;
            labelEmailPlaceholder.alpha = 1.f;
            emailBool = YES;
        }];
    }
}

//Метод перед вводом текста---------------------------------
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (isiPhone5) {
        mainScrollView.contentOffset = (CGPoint){
            0, // ось x нас не интересует
            120 // Скроллим скролл к верхней границе текстового поля - Вы можете настроить эту величину по своему усмотрению
        };
    }else {
    
    if (textField == textFieldEmail) {
        mainScrollView.contentOffset = (CGPoint){
            0, // ось x нас не интересует
            80 // Скроллим скролл к верхней границе текстового поля - Вы можете настроить эту величину по своему усмотрению
        };
    }
    }
}

//Метод после ввода текста----------------------------------
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (isiPhone5) {
    mainScrollView.contentOffset = (CGPoint){0, 0}; // Возвращаем скролл в начало, так как редактирование текстового поля закончено
    } else {
    if (textField == textFieldEmail) {
    mainScrollView.contentOffset = (CGPoint){0, 0}; // Возвращаем скролл в начало, так как редактирование текстового поля закончено
}
}
}
#pragma mark - Buttons Methods
//Действие кнопки отправить заявку-------------------------
- (void) buttonSendApplicationAction
{
    
    NSLog(@"Отправить фото");
    ApplicationController * appController = [[ApplicationController alloc] init];
    [appController getAPIWithFio:textFieldLogin.text andEmail:textFieldEmail.text];
}



//Действие кнопки согласиться с лиц. соглашением------------
- (void) buttonСonfirmAction
{
    if (!confirmBool) {
        NSLog(@"Ставим галочку");
        confirmBool = YES;
    } else {
        NSLog(@"Убираем галочку");
        confirmBool = NO;
    }
    
}


#pragma mark - DEALLOC

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
