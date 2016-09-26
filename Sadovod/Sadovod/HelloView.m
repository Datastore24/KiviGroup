//
//  HelloView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 22.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "HelloView.h"
#import "UIButton+ButtonImage.h"
#import "Macros.h"
#import "HexColors.h"
#import "CustomLabels.h"
#import "UIImage+Resize.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения
#import "CheckDataServer.h"
#import "SingleTone.h"
#import "CustomButton.h"
#import "UIView+BorderView.h"

@implementation HelloView

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height);
        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"000000" alpha:0.6];
        
        UIView * helloView = [[UIView alloc] initWithFrame:CGRectMake(15.f, self.frame.size.height / 2 - 100, self.frame.size.width - 30.f, 300.f)];
        helloView.backgroundColor = [UIColor whiteColor];
        helloView.layer.cornerRadius = 5.f;
        [self addSubview:helloView];
        
        CustomLabels * labelTitl = [[CustomLabels alloc] initLabelTableWithWidht:0.f andHeight:20.f andSizeWidht:helloView.frame.size.width andSizeHeight:20 andColor:VM_COLOR_800 andText:@"Условия Сотрудничества"];
        labelTitl.textAlignment = NSTextAlignmentCenter;
        labelTitl.font = [UIFont fontWithName:VM_FONT_BOLD size:16];
        [helloView addSubview:labelTitl];
        
        CustomLabels * labelSubTitl = [[CustomLabels alloc] initLabelWithWidht:15.f andHeight:50.f andColor:@"000000" andText:@"Здравствуйте!" andTextSize:15.f andLineSpacing:0.f fontName:VM_FONT_BOLD];
        [helloView addSubview:labelSubTitl];
        
        CustomLabels * labelText = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:75.f andSizeWidht:helloView.frame.size.width - 30 andSizeHeight:30
                                                                        andColor:@"5C5C5C" andText:@"Позвольте ознакомить Вас с нашими условиями сотрудничества:"];
        labelText.numberOfLines = 2;
        labelText.textAlignment = NSTextAlignmentLeft;
        labelText.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        [helloView addSubview:labelText];
        
        NSArray * textArray = [NSArray arrayWithObjects:
                               @"- Минимальный заказ 1990 рублей;",
                               @"- Предопдата заказа 100\%;",
                               @"- Доставка в пределах МКАД 450 рублей;",
                               @"- Бесплвтная доставка до ТК и Почты России;",
                               @"- Отправка груза после оплаты от 3 до 7 рабочих дней;", nil];
        CGFloat height = 0.f;
        
        for (int i = 0; i < 5; i++) {
            CustomLabels * labelSubText = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:110.f + height andSizeWidht:helloView.frame.size.width - 30 andSizeHeight:20
                                                                            andColor:@"5C5C5C" andText:[textArray objectAtIndex:i]];
            if (i > 2) {
                labelSubText.frame = CGRectMake(15.f, 110.f + height, helloView.frame.size.width - 30, 35);
                height += 33;
                labelSubText.numberOfLines = 0.f;
            } else {
                height += 20;
                labelSubText.numberOfLines = 1.f;
            }
            labelSubText.textAlignment = NSTextAlignmentLeft;
            labelSubText.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
            [helloView addSubview:labelSubText];
        }
        
        NSArray * arrayButtonsName = [NSArray arrayWithObjects:@"Задать вопрос", @"Ясно", nil];
        NSArray * arrayImages = [NSArray arrayWithObjects:@"imageQuestion.png", @"", nil];
        for (int i = 0; i < 2; i++) {
            UIButton * buttonQuestien = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonQuestien.frame = CGRectMake(15.f, 250, 165, 40);
            if (isiPhone6) {
                buttonQuestien.frame = CGRectMake(15.f, 250, 190, 40);
            } else if (isiPhone6Plus) {
                buttonQuestien.frame = CGRectMake(30.f, 250, 190, 40);
            }
            if (i == 1) {
                buttonQuestien.frame = CGRectMake(190, 250, 80, 40);
                if (isiPhone6) {
                    buttonQuestien.frame = CGRectMake(215, 250, 115, 40);
                }  else if (isiPhone6Plus) {
                    buttonQuestien.frame = CGRectMake(230, 250, 115, 40);
                }
            }
            buttonQuestien.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_300];
            [buttonQuestien setTitle:[arrayButtonsName objectAtIndex:i] forState:UIControlStateNormal];
            [buttonQuestien setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            buttonQuestien.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800].CGColor;
            buttonQuestien.layer.borderWidth = 1.f;
            buttonQuestien.layer.cornerRadius = 3.f;
            if (i == 0) {
                buttonQuestien.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
            }

            buttonQuestien.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
            buttonQuestien.tag = 1300 + i;
            [buttonQuestien addTarget:self action:@selector(buttonQuestienAction:) forControlEvents:UIControlEventTouchUpInside];
            [helloView addSubview:buttonQuestien];
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 15.f, 15.f)];
            if (i == 1) {
                imageView.frame = CGRectMake(10, 12, 15.f, 15.f);
            }
            imageView.image = [UIImage imageNamed:[arrayImages objectAtIndex:i]];
            [buttonQuestien addSubview:imageView];
        }
        
        
    }
    return self;
}

#pragma mark - Actions

- (void) buttonQuestienAction: (UIButton*) button {
    if (button.tag == 1300) {
            [self.delegate pushToQuestion:self];
        [self performSelector:@selector(hideView) withObject:nil afterDelay:1.];
    } else {
        self.alpha = 0.f;
    }
}

- (void) hideView {
    self.alpha = 0.f;
}

@end
