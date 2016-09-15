//
//  AuthorizationView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 08/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "AuthorizationView.h"
#import "InputTextView.h"
#import "CustomButton.h"
#import "CustomLabels.h"
#import "Macros.h"
#import "HexColors.h"
#import "UIView+BorderView.h"
#import "SingleTone.h"

@interface AuthorizationView () <UITextViewDelegate>

@property (strong, nonatomic) UIView * viewChangeName;
@property (strong, nonatomic) CustomLabels * labelNumberComments;
@property (strong, nonatomic) UILabel * labelTextView;
@property (strong, nonatomic) UITextView * textView;
@property (strong, nonatomic) UIView * viewPuss;

@end

@implementation AuthorizationView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height - 64);
        
        if ([[[SingleTone sharedManager] typeMenu] isEqualToString:@"0"]) { //Если окно авторизации
            self.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
            
            UIView * viewCentre = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 130.f, self.frame.size.height / 2 - 164.f, 260.f, 160.f)];
            viewCentre.backgroundColor = [UIColor whiteColor];
            [viewCentre.layer setBorderColor:[UIColor colorWithWhite:0.8f alpha:0.6f].CGColor];
            viewCentre.layer.borderWidth = 1.5f;
            viewCentre.layer.cornerRadius = 5.f;
            [self addSubview:viewCentre];
            ;
            NSArray * arrayName = [NSArray arrayWithObjects:@"Email", @"Пароль", nil];
            for (int i = 0; i < 2; i++) {
                InputTextView * inputText = [[InputTextView alloc] initInputTextWithView:viewCentre
                                                                                 andRect:CGRectMake(15.f, 10.f + 40 * i, viewCentre.frame.size.width - 30.f, 40) andImage:nil
                                                                      andTextPlaceHolder:[arrayName objectAtIndex:i] colorBorder:nil];
                if (i == 0) {
                    inputText.textFieldInput.keyboardType = UIKeyboardTypeEmailAddress;
                } else if (i == 1) {
                    inputText.textFieldInput.secureTextEntry = YES;
                }
                inputText.textFieldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
                inputText.textFieldInput.textColor = [UIColor blackColor];
                inputText.labelPlaceHoldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
                inputText.labelPlaceHoldInput.textColor = [UIColor lightGrayColor];
                [viewCentre addSubview:inputText];
                [UIView borderViewWithHeight:39.f andWight:10.f andView:inputText andColor:@"efeff4" andHieghtBorder:1.f];
            }
            
            
            UIButton * buttonEntrance = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonEntrance.frame = CGRectMake(15.f, 105.f, viewCentre.frame.size.width - 30.f, 40);
            buttonEntrance.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
            [buttonEntrance setTitle:@"Войти" forState:UIControlStateNormal];
            [buttonEntrance setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            buttonEntrance.layer.cornerRadius = 3.f;
            buttonEntrance.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:16];
            [viewCentre addSubview:buttonEntrance];
            
            UIButton * buttonRegistration = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonRegistration.frame = CGRectMake(30.f, 260.f, 100, 20);
            [buttonRegistration setTitle:@"Регистрация" forState:UIControlStateNormal];
            [buttonRegistration setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_800] forState:UIControlStateNormal];
            buttonRegistration.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:16];
            [self addSubview:buttonRegistration];
            
            
            UIButton * buttonPassword = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonPassword.frame = CGRectMake(140.f, 260.f, 150, 20);
            [buttonPassword setTitle:@"Напомнить пароль" forState:UIControlStateNormal];
            [buttonPassword setTitleColor:[UIColor hx_colorWithHexRGBAString:@"5C5C5C"] forState:UIControlStateNormal];
            buttonPassword.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:16];
            [self addSubview:buttonPassword];
        } else { //Если мой профиль
            
            NSArray * arrayNames = [NSArray arrayWithObjects:@"Имя", @"Email", @"Пароль", @"Платежный счет", nil];
            for (int i = 0; i < 4; i++) {
                CustomLabels * labelTitl = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:15.f + 60 * i andSizeWidht:self.frame.size.width - 30 andSizeHeight:20 andColor:@"5C5C5C"
                                                                                 andText:[arrayNames objectAtIndex:i]];
                labelTitl.font = [UIFont fontWithName:VM_FONT_REGULAR size:12];
                labelTitl.textAlignment = NSTextAlignmentLeft;
                labelTitl.numberOfLines = 1;
                [self addSubview:labelTitl];
            }
            
            NSArray * arrayNamesData = [NSArray arrayWithObjects:@"Viktor", @"mrdoro@gmail.com", @"* * * * * * * * * *", nil];
            for (int i = 0; i < 3; i++) {
                CustomLabels * labelTitl = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:35.f + 60 * i andSizeWidht:self.frame.size.width - 30 andSizeHeight:20 andColor:@"000000"
                                                                                 andText:[arrayNamesData objectAtIndex:i]];
                labelTitl.font = [UIFont fontWithName:VM_FONT_BOLD size:13];
                labelTitl.textAlignment = NSTextAlignmentLeft;
                labelTitl.numberOfLines = 1;
                [self addSubview:labelTitl];
                
                [UIView borderViewWithHeight:60 + 60 * i andWight:15.f andView:self andColor:@"5C5C5C"];
                
                if (i != 1) {
                    UIButton * buttonChange = [UIButton buttonWithType:UIButtonTypeSystem];
                    buttonChange.frame = CGRectMake(self.frame.size.width - 95.f, 15.f + 60 * i, 80, 20);
                    [buttonChange setTitle:@"Изменить" forState:UIControlStateNormal];
                    [buttonChange setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_800] forState:UIControlStateNormal];
                    buttonChange.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:12];
                    [self addSubview:buttonChange];
                }
            }
            
            self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10.f, 220.f, self.frame.size.width - 30.f, 160)];
            self.textView.textColor = [UIColor blackColor];
            self.textView.delegate = self;
            self.textView.font = [UIFont fontWithName:VM_FONT_REGULAR size:12];
            //        textView.autocorrectionType = UITextAutocorrectionTypeNo;
            [self addSubview:self.textView];
            
            [UIView borderViewWithHeight:380.f andWight:10.f andView:self andColor:VM_COLOR_800];
            
        
        self.labelNumberComments = [[CustomLabels alloc] initLabelTableWithWidht:self.frame.size.width - 80.f andHeight:195.f andSizeWidht:60.f andSizeHeight:20.f andColor:VM_COLOR_300 andText:@"300"];
        self.labelNumberComments.font = [UIFont fontWithName:VM_FONT_BEAU_SANS_LITE size:12];
        self.labelNumberComments.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.labelNumberComments];
            
            self.labelTextView = [[UILabel alloc] initWithFrame:CGRectMake(15.f, 221.f, self.frame.size.width - 30.f, 40)];
            self.labelTextView.text = @"Эти данные необходимы для более быстрой идентификации Ваших платежей.";
            self.labelTextView.textColor = [UIColor hx_colorWithHexRGBAString:@"5C5C5C"];
            self.labelTextView.numberOfLines = 2.f;
            self.labelTextView.font = [UIFont fontWithName:VM_FONT_REGULAR size:12];
            [self addSubview:self.labelTextView];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeText) name:UITextViewTextDidChangeNotification object:nil];
            
            
            
            
            self.viewChangeName = [self createViewChange];
            self.viewChangeName.alpha = 0.f;
            [self addSubview: self.viewChangeName];
            
            
            
            self.viewPuss = [self createViewPuss];
            self.viewPuss.alpha = 0.f;
            [self addSubview: self.viewPuss];
            
            

            
        }
        
    }
    return self;
}

#pragma mark - ViewChange

- (UIView*) createViewChange {
    UIView * viewFon = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
    viewFon.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"000000" alpha:0.5];
    
    UIView * mainView = [[UIView alloc] initWithFrame:CGRectMake(15.f, self.frame.size.height / 2 - 100.f, self.frame.size.width - 30.f, 100.f)];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.layer.cornerRadius = 5.f;
    [viewFon addSubview:mainView];
    
    InputTextView * inputText = [[InputTextView alloc] initInputTextWithView:mainView andRect:CGRectMake(0.f, 20.f, mainView.frame.size.width, 20) andImage:nil andTextPlaceHolder:@"" colorBorder:nil];
    inputText.textFieldInput.text = @"Viktor";
    inputText.textFieldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
    [mainView addSubview: inputText];
    
    [UIView borderViewWithHeight:50.f andWight:10.f andView:mainView andColor:VM_COLOR_800];
    
    UIButton * buttonCancel = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonCancel.frame = CGRectMake(90, 60.f, 90, 30);
    [buttonCancel setTitle:@"Отмена" forState:UIControlStateNormal];
    [buttonCancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    buttonCancel.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
    [mainView addSubview:buttonCancel];
    
    UIButton * buttonConfirm = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonConfirm.frame = CGRectMake(190, 60.f, 90, 30);
    buttonConfirm.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
    buttonConfirm.layer.cornerRadius = 3.f;
    [buttonConfirm setTitle:@"Сохранить" forState:UIControlStateNormal];
    [buttonConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonConfirm.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
    [mainView addSubview:buttonConfirm];
    
    
    return viewFon;
}

#pragma mark - ViewPass

- (UIView*) createViewPuss {
    UIView * viewFon = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
    viewFon.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"000000" alpha:0.5];
    
    UIView * mainView = [[UIView alloc] initWithFrame:CGRectMake(15.f, self.frame.size.height / 2 - 100.f, self.frame.size.width - 30.f, 200.f)];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.layer.cornerRadius = 5.f;
    [viewFon addSubview:mainView];
    
    NSArray * arrayName = [NSArray arrayWithObjects:@"Введите старый пароль", @"Введите новый пароль", @"Повторите новый пароль", nil];
    for (int i = 0; i < 3; i++) {
        InputTextView * inputText = [[InputTextView alloc] initInputTextWithView:mainView andRect:CGRectMake(0.f, 20.f + 50 * i, mainView.frame.size.width, 20) andImage:nil andTextPlaceHolder:[arrayName objectAtIndex:i] colorBorder:nil];
        inputText.textFieldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        inputText.textFieldInput.secureTextEntry = YES;
        inputText.labelPlaceHoldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        inputText.labelPlaceHoldInput.textColor = [UIColor hx_colorWithHexRGBAString:@"5C5C5C"];
        [mainView addSubview: inputText];
        
        [UIView borderViewWithHeight:50.f + 50 * i andWight:10.f andView:mainView andColor:VM_COLOR_800];
    }
    

    
    UIButton * buttonCancel = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonCancel.frame = CGRectMake(90, 160.f, 90, 30);
    [buttonCancel setTitle:@"Отмена" forState:UIControlStateNormal];
    [buttonCancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    buttonCancel.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
    [mainView addSubview:buttonCancel];
    
    UIButton * buttonConfirm = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonConfirm.frame = CGRectMake(190, 160.f, 90, 30);
    buttonConfirm.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
    buttonConfirm.layer.cornerRadius = 3.f;
    [buttonConfirm setTitle:@"Сохранить" forState:UIControlStateNormal];
    [buttonConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonConfirm.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
    [mainView addSubview:buttonConfirm];
    
    
    return viewFon;
}

- (void) changeText {
    if (self.textView.text.length != 0) {
        self.labelTextView.alpha = 0.f;
    } else {
        self.labelTextView.alpha = 1.f;
    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    

    
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    NSUInteger newLength = (textView.text.length - range.length) + text.length;
    NSInteger labelCount = 300 - newLength;
        self.labelNumberComments.text = [NSString stringWithFormat:@"%d", labelCount];
    
    if(newLength <= 299)
    {
        return YES;
    } else {
        NSUInteger emptySpace = 299 - (textView.text.length - range.length);
        textView.text = [[[textView.text substringToIndex:range.location]
                          stringByAppendingString:[text substringToIndex:emptySpace]]
                         stringByAppendingString:[textView.text substringFromIndex:(range.location + range.length)]];
        return NO;
        
    }
}
@end
