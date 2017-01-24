//
//  AddParamsView.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 24.01.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "AddParamsView.h"
#import "Macros.h"
#import "HexColors.h"
#import "AddParamsModel.h"

@interface AddParamsView ()

@property (strong, nonatomic) NSArray * arrayForPicker;

@end

@implementation AddParamsView

- (instancetype)initWithFrame: (CGRect) frame endTetleText: (NSString*) titleText andIdString: (NSString*) idString andType: (NSString*) type endArrayData: (NSArray*) arrayData
{
    self = [super init];
    if (self) {
        
        self.arrayForPicker = [AddParamsModel setTestArray];
        
        self.frame = frame;
        
        UILabel * labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(28.f, 0.f, 76.f, 30.f)];
        labelTitle.text = titleText;
        labelTitle.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:14];
        [self addSubview:labelTitle];
        
        self.idString = idString;
        
        CGRect frameObject = CGRectMake(122.f, 0, 172.f, 30.f);
        
        if ([type isEqualToString:@"String"]) {
            UITextField * textFild = [[UITextField alloc] initWithFrame:frameObject];
            textFild.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:14];
            textFild.placeholder = @"Введите рост";
            textFild.textAlignment = NSTextAlignmentCenter;
            [self addSubview:textFild];
            self.mainObject = textFild;
        } else if ([type isEqualToString:@"Picker"]) {
            UIButton * buttonPicker = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonPicker.frame = frameObject;
            buttonPicker.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"4682AC"];
            [buttonPicker setTitle:@"Выбрать" forState:UIControlStateNormal];
            [buttonPicker setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            buttonPicker.titleLabel.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:14];
            [buttonPicker addTarget:self action:@selector(actionButtonPicker:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:buttonPicker];
            self.mainObject = buttonPicker;
        } else if ([type isEqualToString:@"Switch"]) {
            UISwitch * swith = [[UISwitch alloc] initWithFrame:CGRectMake(245.f, 0.f, 49.f, 31.f)];
            [self addSubview:swith];
            self.mainObject = swith;
        }
    }
    
    return self;
}

#pragma mark - Actions

- (void) actionButtonPicker: (UIButton*) button {
    [self.deleagte actionButtonOn:self andButton:button andArrayViewPicker:self.arrayForPicker];
}

@end
