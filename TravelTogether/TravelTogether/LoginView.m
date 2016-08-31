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
        
        NSArray * networkImage = [data objectAtIndex:0];
        
        
        
        for (int i = 0; i < networkImage.count; i++) {
            UIButton * buttonSocNetwork = [UIButton createButtonWithImage:[networkImage objectAtIndex:i] anfFrame:CGRectMake(self.frame.size.width / 2 - 102.5f, 259.f + 40.f * i, 205.f, 36.f)];
            [self addSubview:buttonSocNetwork];
        }
        
        

        

        //Подумать как успрастить работу с лейблами (проблема заключается что на 2 лейбла надо было повесить джесторы)
        
        
        CustomLabels * labelDescription = [[CustomLabels alloc] initLabelWithWidht:22.5f andHeight:517.5f andColor:VM_COLOR_WHITE
                                                                           andText:@"Продолжая, вы подтверждаете, что прочитали и принимаете \n\bПользовательское Соглашение и \bПолитику \nконфиденциальности."
                                                                       andTextSize:9.f andLineSpacing:5.f fontName:VM_FONT_BEAU_SANS_LITE];
        [self addSubview:labelDescription];
        
        CustomLabels * labelTermsOfUse = [[CustomLabels alloc] initLabelWithWidht:22.5f andHeight:529.f andColor:VM_COLOR_WHITE
                                                                           andText:@"Пользовательское Соглашение"
                                                                       andTextSize:8.f andLineSpacing:5.f fontName:VM_FONT_BEAU_SANS_BOLD];
        
        [self addSubview:labelTermsOfUse];
        UITapGestureRecognizer * tapOnTermsOfUse = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnTermsOfUseAction:)];
        labelTermsOfUse.userInteractionEnabled = YES;
        [labelTermsOfUse addGestureRecognizer:tapOnTermsOfUse];
        
        CustomLabels * labelAnd = [[CustomLabels alloc] initLabelWithWidht:labelTermsOfUse.frame.origin.x + labelTermsOfUse.frame.size.width + 2.f andHeight:529.f andColor:VM_COLOR_WHITE
                                                                          andText:@"и"
                                                                      andTextSize:9.f andLineSpacing:5.f fontName:VM_FONT_BEAU_SANS_LITE];
        [self addSubview:labelAnd];
        
        CustomLabels * labelPrivacyPolicyPart1 = [[CustomLabels alloc] initLabelWithWidht:labelAnd.frame.origin.x + labelAnd.frame.size.width + 2.f andHeight:529.f andColor:VM_COLOR_WHITE
                                                                          andText:@"Политику конфиденциальности."
                                                                      andTextSize:8.f andLineSpacing:5.f fontName:VM_FONT_BEAU_SANS_BOLD];
        [self addSubview:labelPrivacyPolicyPart1];
        UITapGestureRecognizer * tapPrivacyPolicyPart1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPrivacyPolicyAction:)];
        labelPrivacyPolicyPart1.userInteractionEnabled = YES;
        [labelPrivacyPolicyPart1 addGestureRecognizer:tapPrivacyPolicyPart1];
       

    }
    return self;
}

#pragma mark - Action Methods

- (void) tapOnTermsOfUseAction: (UIGestureRecognizer*) recognizer
{
    if( [recognizer state] == UIGestureRecognizerStateEnded ) {
        [self.delegate tapOnTermsOfUseWithLoginView:self];
    }
}

- (void) tapPrivacyPolicyAction: (UIGestureRecognizer*) recognizer
{
    if( [recognizer state] == UIGestureRecognizerStateEnded ) {
        [self.delegate tapPrivacyPolicyWithLoginView:self];
    }
}



@end
