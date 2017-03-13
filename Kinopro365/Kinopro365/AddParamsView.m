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
#import "CustomButton.h"
#import "HexColors.h"
#import "AdditionalTable.h"

@interface AddParamsView ()

@property (strong, nonatomic) NSArray * arrayForPicker;
@property (strong, nonatomic) CustomButton * buttonLangue;
@property (strong, nonatomic) UIImageView * imageViewArrow;


@end

@implementation AddParamsView

- (instancetype)initWithFrame: (CGRect) frame andTitle:(NSString *) title andType: (NSString *) type
            andPlaceholder: (NSString *) placeholder
               andId: (NSString *) fieldID
             andDefValueIndex: (NSString *) defValueIndex
                    andArrayData: (NSArray*) arrayData
            andIsSearch: (BOOL) isSearch
{
    self = [super init];
    if (self) {
        
        
        self.frame = frame;
        
       
                
                UILabel * labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(28.f, 0.f, 120.f, 30.f)];
                labelTitle.text = title;
                labelTitle.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:14];
                [self addSubview:labelTitle];
        
        
                CGRect frameObject = CGRectMake(152.f, 0, 142.f, 30.f);
        
        
        
                if ([type isEqualToString:@"String"]) {
                    UITextField * textFild = [[UITextField alloc] initWithFrame:frameObject];
                    textFild.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:14];
                    textFild.placeholder = placeholder;
                    textFild.textAlignment = NSTextAlignmentCenter;
                    self.mainObject = textFild;
                    self.mainDict = @{
                                      @"title": title,
                                      @"id": fieldID,
                                      @"type": @"String"
                                      };
                    [self addSubview:textFild];
                    
                } else if ([type isEqualToString:@"Picker"]) {
                    CustomButton * buttonPicker = [CustomButton buttonWithType:UIButtonTypeSystem];
                    buttonPicker.frame = frameObject;
                    buttonPicker.customArray = arrayData;
                    buttonPicker.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"4682AC"];
                    [buttonPicker setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    buttonPicker.titleLabel.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:14];
                    [buttonPicker addTarget:self action:@selector(actionButtonPicker:) forControlEvents:UIControlEventTouchUpInside];
                    [self addSubview:buttonPicker];
                    
                    UIImageView * imageViewArrow = [[UIImageView alloc] initWithFrame:CGRectMake(123.f, 12.f, 11.f, 6.f)];
                    imageViewArrow.image = [UIImage imageNamed:@"left_arrow"];
                    [buttonPicker addSubview:imageViewArrow];
                    
                    self.mainObject = buttonPicker;
                    self.mainDict = @{
                                      @"title": title,
                                      @"id": fieldID,
                                      @"type": @"Picker"
                                      };
                    
                    NSPredicate *pred = [NSPredicate predicateWithFormat:@"additionalID = %@",
                                         fieldID];
                    
                    if(isSearch){
                        buttonPicker.customName = defValueIndex;
                        [buttonPicker setTitle:@"Выбрать" forState:UIControlStateNormal];

                        
                    }else{
                        //Грузим данные из базы
                        RLMResults *outletTableDataArray = [AdditionalTable objectsWithPredicate:pred];
                        if(outletTableDataArray.count>0){
                            for(int i=0; i<outletTableDataArray.count; i++){
                                AdditionalTable * addTable = [outletTableDataArray objectAtIndex:i];
                                buttonPicker.customName = addTable.additionalNameValue;
                                buttonPicker.customID = addTable.additionalValue;
                                [buttonPicker setTitle:addTable.additionalNameValue forState:UIControlStateNormal];
                            }
                        }else{
                            
                            buttonPicker.customName = defValueIndex;
                            [buttonPicker setTitle:@"Выбрать" forState:UIControlStateNormal];
                        }
                    }
                    
                    
                } else if ([type isEqualToString:@"Switch"]) {
                    labelTitle.frame = CGRectMake(28.f, 0.f, 160.f, 30.f);
                    UISwitch * swith = [[UISwitch alloc] initWithFrame:CGRectMake(245.f, 0.f, 49.f, 31.f)];
                    swith.onTintColor = [UIColor hx_colorWithHexRGBAString:@"5581A8"];
                    [self addSubview:swith];
                    self.mainObject = swith;
                    self.mainDict = @{
                                      @"title": title,
                                      @"id": fieldID,
                                      @"type": @"Switch"
                                      };
                    NSPredicate *pred = [NSPredicate predicateWithFormat:@"additionalID = %@",
                                         fieldID];
                    
                    if(isSearch){
                        [swith setOn:NO];
                    }else{
                        //Грузим данные из базы
                        RLMResults *outletTableDataArray = [AdditionalTable objectsWithPredicate:pred];
                        if(outletTableDataArray.count>0){
                            [swith setOn:YES];
                        }else{
                            
                            [swith setOn:NO];
                        }
                    }
                    

                    
                    
                    
                } else if ([type isEqualToString:@"MultiList"]) {
                    self.buttonLangue = [CustomButton buttonWithType:UIButtonTypeSystem];
                    self.buttonLangue.frame = frameObject;
                    self.buttonLangue.tag = 999;
                    self.buttonLangue.customArray = arrayData;
                    self.buttonLangue.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"4682AC"];
                    [self.buttonLangue setTitle:@"Выбрать" forState:UIControlStateNormal];
                    [self.buttonLangue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    self.buttonLangue.titleLabel.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:14];
                    [self.buttonLangue addTarget:self action:@selector(actionbuttonLangue:) forControlEvents:UIControlEventTouchUpInside];
                    [self addSubview:self.buttonLangue];
                    
                    self.imageViewArrow = [[UIImageView alloc] initWithFrame:CGRectMake(123.f, 12.f, 11.f, 6.f)];
                    self.imageViewArrow.image = [UIImage imageNamed:@"left_arrow"];
                    [self.buttonLangue addSubview:self.imageViewArrow];
                    
                    self.mainObject = self.buttonLangue;
                    self.mainDict = @{
                                      @"title": title,
                                      @"id": fieldID,
                                      @"type": @"MultiList"
                                      };
                
                    if(!isSearch){
                        
                        NSPredicate *pred = [NSPredicate predicateWithFormat:@"additionalID BEGINSWITH %@",
                                             @"ex_languages"];
                        
                        RLMResults *outletTableDataArray = [AdditionalTable objectsWithPredicate:pred];
                        NSMutableString * resultString = [NSMutableString new];
                        if(outletTableDataArray.count>0){
                            for(int i=0; i<outletTableDataArray.count; i++){
                                AdditionalTable * addTable = [outletTableDataArray objectAtIndex:i];
                                if ([resultString isEqualToString:@""]) {
                                    [resultString appendString:addTable.additionalName];
                                } else {
                                    [resultString appendString:[NSString stringWithFormat:@", %@", addTable.additionalName]];
                                }
                                if(i==2){
                                    [resultString appendString:@"..."];
                                    break;
                                }
                            }
                            [self ChekButtonWithText:resultString andBool:YES];
                        }
                    }
                    
                    
                }
            
        }
        

    
    return self;
}

#pragma mark - Actions

- (void) actionButtonPicker: (CustomButton*) button {
    [self.deleagte actionButtonOn:self andButton:button andArrayViewPicker:button.customArray];
}

- (void) actionbuttonLangue: (CustomButton*) button {
    [self.deleagte actionLangue:self andButton:button andArrayViewPicker:button.customArray];
}

#pragma mark - Other

- (void) ChekButtonWithText: (NSString*) buttonText andBool: (BOOL) isbool {
    
    if (isbool) {
        
        self.buttonLangue.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.buttonLangue.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.buttonLangue setTitle: buttonText forState: UIControlStateNormal];
        self.buttonLangue.frame = CGRectMake(152.f, 0, 142.f, 40.f);
//        
        self.buttonLangue.backgroundColor = [UIColor clearColor];
        [self.buttonLangue setTitleColor:[UIColor hx_colorWithHexRGBAString:@"3D7FB4"] forState:UIControlStateNormal];
        self.imageViewArrow.alpha = 0.f;
    } else {
        self.buttonLangue.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"4682AC"];
        [self.buttonLangue setTitle:@"Выбрать" forState:UIControlStateNormal];
        [self.buttonLangue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.imageViewArrow.alpha = 1.f;
    }
    
}

@end
