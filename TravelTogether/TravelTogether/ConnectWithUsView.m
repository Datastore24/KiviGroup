//
//  ConnectWithUsView.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 29/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "ConnectWithUsView.h"
#import "CustomLabels.h"
#import "HexColors.h"
#import "Macros.h"
#import "InputTextView.h"
#import "InputTextToView.h"
#import "MessagePopUp.h"

@implementation ConnectWithUsView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height - 64.f);
        
        CustomLabels * titleLabel = [[CustomLabels alloc] initLabelTableWithWidht:0.f andHeight:51.f andSizeWidht:self.frame.size.width andSizeHeight:15.f andColor:@"626262" andText:@"НАПИШИТЕ НАМ И МЫ СВЯЖЕМСЯ С ВАМИ"];
        titleLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:11];
        [self addSubview:titleLabel];
        
        NSArray * arrayHolders = [NSArray arrayWithObjects:@"Имя", @"Email", nil];
        for (int i = 0; i < 2; i++) {
            InputTextView * inputText = [[InputTextView alloc] initInputTextWithView:self andRect:CGRectMake(12.5f, 82.5f + 65.f * i, self.frame.size.width - 25.f, 34.f) andImage:nil andTextPlaceHolder:[arrayHolders objectAtIndex:i] colorBorder:@"626262"];
            inputText.layer.borderWidth = 0.5f;
            inputText.layer.cornerRadius = 34.f / 2;
            inputText.textFieldInput.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:11];
            inputText.textFieldInput.textColor = [UIColor hx_colorWithHexRGBAString:@"626262"];
            if (i == 1) {
                inputText.textFieldInput.keyboardType = UIKeyboardTypeEmailAddress;
            }
            inputText.labelPlaceHoldInput.textColor = [UIColor hx_colorWithHexRGBAString:@"626262"];
            inputText.textFieldInput.textColor = [UIColor hx_colorWithHexRGBAString:@"626262"];
            [self addSubview:inputText];
        }
        
        InputTextToView * messegeText = [[InputTextToView alloc] initWithTextViewFrame:CGRectMake(12.5f, 217.5f, self.frame.size.width - 25.f, 140.f)];
        messegeText.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"626262"].CGColor;
        messegeText.layer.borderWidth = 0.5f;
        messegeText.layer.cornerRadius = 15.f;
        messegeText.mainTextView.frame = CGRectMake(10.f, 0.f, messegeText.frame.size.width - 20.f, messegeText.frame.size.height);
        messegeText.mainTextView.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:11];
        messegeText.mainTextView.textColor = [UIColor hx_colorWithHexRGBAString:@"626262"];
        messegeText.placeholder = @"Сообщение";
        messegeText.placeHolderLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:11];
        messegeText.placeHolderLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"626262"];
        [self addSubview:messegeText];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startInputText:) name:UITextViewTextDidBeginEditingNotification object:nil];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endInputText:) name:UITextViewTextDidEndEditingNotification object:nil];
        
        UIButton * buttonSend = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonSend.frame = CGRectMake(12.5f, self.frame.size.height - 114.f, self.frame.size.width - 25.f, 37.5f);
        buttonSend.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
        [buttonSend setTitle:@"ОТПРАВИТЬ" forState:UIControlStateNormal];
        [buttonSend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonSend.titleLabel.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_BOLD size:13];
        [buttonSend addTarget:self action:@selector(buttonSendAction) forControlEvents:UIControlEventTouchUpInside];
        buttonSend.layer.cornerRadius = 37.5f / 2;
        [self addSubview:buttonSend];
        
        
        
        
        
    }
    return self;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Actions

//Метод поднимает вью при вводе сообщения
- (void) startInputText: (NSNotification*) notification {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect selfRect = self.frame;
        selfRect.origin.y -= 75.f;
        self.frame = selfRect;
    }];
}

//Метод опускает вью в стандартное положение после ввода сообщения
- (void) endInputText: (NSNotification*) notification {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect selfRect = self.frame;
        selfRect.origin.y += 75.f;
        self.frame = selfRect;
    }];
}

- (void) buttonSendAction {
    [MessagePopUp showPopUpWithDelay:@"Сообщение отправленно" view:self delay:1.f];
}

@end
