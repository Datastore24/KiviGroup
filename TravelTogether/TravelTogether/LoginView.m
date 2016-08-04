//
//  LoginView.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 02/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "LoginView.h"
#import "InputTextView.h"
#import "UIButton+ButtonImage.h"
#import "HexColors.h"
#import "Macros.h"
#import "LoginViewController.h"
#import "CustomLabels.h"

@implementation LoginView

- (instancetype)initMainViewMethodWithView: (UIView*) view
                                   andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height);
        
        NSArray * arrayNames = [data objectAtIndex:0];
        NSArray * arrayImages = [data objectAtIndex:1];
        NSArray * arrayImagesNetWork = [data objectAtIndex:2];
        
        
        for (int i = 0; i < 3; i++) {
            InputTextView * inputText = [[InputTextView alloc] initWithView:self
                                                                    andRect:CGRectMake(22.5f, 137.5f + 60.f * i, 277.5f, 46.f)
                                                                   andImage:[arrayImages objectAtIndex:i]
                                                         andTextPlaceHolder:[arrayNames objectAtIndex:i]
                                                             andScrollWidth:0.f];
            [self addSubview:inputText];
        }
        
        UIButton * buttonLogin = [UIButton createButtonTextWithName:@"НАЧАТЬ" andFrame:CGRectMake(22.5f, 347.5f, 277.5f, 46.f)
                                                           fontName:VM_FONT_REGULAR];
        buttonLogin.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_RED alpha:0.3f];
        buttonLogin.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_WHITE alpha:0.3f].CGColor;
        buttonLogin.layer.borderWidth = 1.f;
        buttonLogin.layer.cornerRadius = 23.f;
        [buttonLogin addTarget:self.delegate action:@selector(buttonLoginActionWithLoginView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonLogin];
        

        //Подумать как успрастить работу с лейблами (проблема заключается что на 2 лейбла надо было повесить джесторы)
        
        
        CustomLabels * labelDescription = [[CustomLabels alloc] initLabelWithWidht:22.5f andHeight:447.5f andColor:VM_COLOR_WHITE
                                                                           andText:@"Продолжая, вы подтверждаете, что прочитали и принимаете \n\bПользовательское Соглашение и \bПолитику \nконфиденциальности."
                                                                       andTextSize:9.f andLineSpacing:5.f fontName:VM_FONT_BEAU_SANS_LITE];
        [self addSubview:labelDescription];
        
        CustomLabels * labelTermsOfUse = [[CustomLabels alloc] initLabelWithWidht:22.5f andHeight:459.f andColor:VM_COLOR_WHITE
                                                                           andText:@"Пользовательское Соглашение"
                                                                       andTextSize:8.f andLineSpacing:5.f fontName:VM_FONT_BEAU_SANS_BOLD];
        
        [self addSubview:labelTermsOfUse];
        UITapGestureRecognizer * tapOnTermsOfUse = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnTermsOfUseAction:)];
        labelTermsOfUse.userInteractionEnabled = YES;
        [labelTermsOfUse addGestureRecognizer:tapOnTermsOfUse];
        
        CustomLabels * labelAnd = [[CustomLabels alloc] initLabelWithWidht:labelTermsOfUse.frame.origin.x + labelTermsOfUse.frame.size.width + 2.f andHeight:459.f andColor:VM_COLOR_WHITE
                                                                          andText:@"и"
                                                                      andTextSize:9.f andLineSpacing:5.f fontName:VM_FONT_BEAU_SANS_LITE];
        [self addSubview:labelAnd];
        
        CustomLabels * labelPrivacyPolicyPart1 = [[CustomLabels alloc] initLabelWithWidht:labelAnd.frame.origin.x + labelAnd.frame.size.width + 2.f andHeight:459.f andColor:VM_COLOR_WHITE
                                                                          andText:@"Политику конфиденциальности."
                                                                      andTextSize:8.f andLineSpacing:5.f fontName:VM_FONT_BEAU_SANS_BOLD];
        [self addSubview:labelPrivacyPolicyPart1];
        UITapGestureRecognizer * tapPrivacyPolicyPart1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPrivacyPolicyAction:)];
        labelPrivacyPolicyPart1.userInteractionEnabled = YES;
        [labelPrivacyPolicyPart1 addGestureRecognizer:tapPrivacyPolicyPart1];
       
        
        //Кннопки авторизации через соц сети----------------------------------------
        
        for (int i = 0; i < 4; i++) {
            UIImage * buttonSocialNetWorkImage = [UIImage imageNamed:[arrayImagesNetWork objectAtIndex:i]];
            UIButton * buttonSocialNetWork = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonSocialNetWork.frame = CGRectMake((self.frame.size.width / 2.f - (36.f * 2.f + 16.f)) + (36.f + 12.f) * i, self.frame.size.height - 70.f, 36.f, 36.f);
            [buttonSocialNetWork setImage:buttonSocialNetWorkImage forState:UIControlStateNormal];
            buttonSocialNetWork.layer.cornerRadius = 18.f;
            buttonSocialNetWork.layer.shadowColor = [UIColor whiteColor].CGColor;
            buttonSocialNetWork.layer.shadowRadius = 10.0f;
            buttonSocialNetWork.layer.shadowOpacity = 2.f;
            buttonSocialNetWork.layer.shadowOffset = CGSizeZero;
            [self addSubview:buttonSocialNetWork];
            
        }
        
        CustomLabels * labelSocialNetWorkn = [[CustomLabels alloc] initLabelTableWithWidht:0.f andHeight:self.frame.size.height - 30.f andSizeWidht:self.frame.size.width andSizeHeight:20.f andColor:VM_COLOR_WHITE andText:@"Авторизоваться с помощью"];
        labelSocialNetWorkn.font = [UIFont fontWithName:VM_FONT_BEAU_SANS_LITE size:9.f];
        labelSocialNetWorkn.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labelSocialNetWorkn];

        

    }
    return self;
}

#pragma mark - Action Methods

- (void) tapOnTermsOfUseAction: (UIGestureRecognizer*) recognizer {
    if( [recognizer state] == UIGestureRecognizerStateEnded ) {
        [self.delegate tapOnTermsOfUseWithLoginView:self];
    }
}

- (void) tapPrivacyPolicyAction: (UIGestureRecognizer*) recognizer {
    if( [recognizer state] == UIGestureRecognizerStateEnded ) {
        [self.delegate tapPrivacyPolicyWithLoginView:self];
    }
}



@end
