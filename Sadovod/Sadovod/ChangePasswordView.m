//
//  ChangePasswordView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 20.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "ChangePasswordView.h"
#import "InputTextView.h"
#import "CustomButton.h"
#import "CustomLabels.h"
#import "Macros.h"
#import "HexColors.h"
#import "UIView+BorderView.h"
#import "SingleTone.h"
#import "AlertClassCustom.h"

@implementation ChangePasswordView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height - 64);
        

            self.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
            
            UIView * viewCentre = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 130.f, self.frame.size.height / 2 - 124.f, 260.f, 160.f)];
            viewCentre.backgroundColor = [UIColor whiteColor];
            [viewCentre.layer setBorderColor:[UIColor colorWithWhite:0.8f alpha:0.6f].CGColor];
            viewCentre.layer.borderWidth = 1.5f;
            viewCentre.layer.cornerRadius = 5.f;
            [self addSubview:viewCentre];

                InputTextView * inputText = [[InputTextView alloc] initInputTextWithView:viewCentre
                                                                                 andRect:CGRectMake(15.f, 50.f, viewCentre.frame.size.width - 30.f, 40) andImage:nil
                                                                      andTextPlaceHolder:@"Email" colorBorder:nil];

                inputText.textFieldInput.keyboardType = UIKeyboardTypeEmailAddress;
                inputText.tag=8000;

                inputText.textFieldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
                inputText.textFieldInput.textColor = [UIColor blackColor];
                inputText.labelPlaceHoldInput.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
                inputText.labelPlaceHoldInput.textColor = [UIColor lightGrayColor];
                [viewCentre addSubview:inputText];
                [UIView borderViewWithHeight:39.f andWight:10.f andView:inputText andColor:@"efeff4" andHieghtBorder:1.f];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(30.f, 10.f, viewCentre.frame.size.width - 30.f, 40)];
        label.numberOfLines = 2.f;
        label.text = @"Укажите Ваш Email для\nвосстановления пароля";
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        [viewCentre addSubview:label];
        
            
            
            UIButton * buttonEntrance = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonEntrance.frame = CGRectMake(15.f, 105.f, viewCentre.frame.size.width - 30.f, 40);
            buttonEntrance.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
            [buttonEntrance setTitle:@"Отправить" forState:UIControlStateNormal];
            [buttonEntrance setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            buttonEntrance.layer.cornerRadius = 3.f;
            buttonEntrance.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:16];
            [buttonEntrance addTarget:self action:@selector(buttonEntranceAction) forControlEvents:UIControlEventTouchUpInside];
            [viewCentre addSubview:buttonEntrance];

        
    }
    return self;
}


#pragma mark - Actions

- (void) buttonEntranceAction {
    
    InputTextView * inputText = [self viewWithTag:8000];
    if(inputText.textFieldInput.text.length == 0){
        [AlertClassCustom createAlertWithMessage:@"Заполните поле Email"];
        
    }else{
        [self.delegate getApiPassword:self andblock:^{
            
            [self.delegate buttonBackActionDelegate:self];
            
        } andEmail:inputText.textFieldInput.text];
        
        NSLog(@"Смена пароля %@",inputText.textFieldInput.text);
        
    }
    
    
}
    

@end


