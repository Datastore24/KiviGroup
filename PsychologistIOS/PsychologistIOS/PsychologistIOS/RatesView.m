//
//  RatesView.m
//  PsychologistIOS
//
//  Created by Viktor on 16.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "RatesView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "CustomButton.h"

@implementation RatesView
{
    
}

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 64);
        
        //Основной текст--------------------------------------------------------
        UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake(8, 40, self.frame.size.width - 16, 80)];
        labelText.numberOfLines = 0;
        labelText.text = @"В рамках специальных кампаний пользователю приложения  предоставлена возможность перейти на любой предлагаемый тарифный план через предоставленное меню.\nДля этого необходимо выбрать необходимый тариф, после чего подтвердить действие нажав на кнопку “Подписаться";
//        [labelText sizeToFit];
        labelText.textColor = [UIColor colorWithHexString:@"4c4a4a"];
        labelText.font = [UIFont fontWithName:FONTLITE size:13];
        if (isiPhone6) {
            labelText.frame = CGRectMake(16, 40, self.frame.size.width - 32, 80);
            labelText.font = [UIFont fontWithName:FONTLITE size:12];
        } else if (isiPhone5) {
            labelText.frame = CGRectMake(16, 40, self.frame.size.width - 32, 80);
            labelText.font = [UIFont fontWithName:FONTLITE size:10];
        }
        [self addSubview:labelText];
        
        //Тестовый массив имен-----------
        NSArray * arrayName = [NSArray arrayWithObjects:@"Бесплатная тестовая подписка",
                               @"Тариф 1", @"Тариф 2", @"Тариф 3",nil];
        
        //Кнопки тарифов----------------------------------------------------------
        for (int i = 0; i < 4; i++) {
            
            CustomButton * buttonRates = [CustomButton buttonWithType:UIButtonTypeSystem];
            buttonRates.frame = CGRectMake(100, (labelText.frame.size.height + labelText.frame.origin.y + 88) + 56 * i, 16, 16);
            if (isiPhone6) {
                buttonRates.frame = CGRectMake(80, (labelText.frame.size.height + labelText.frame.origin.y + 88) + 56 * i, 16, 16);
            } else if (isiPhone5) {
                buttonRates.frame = CGRectMake(60, (labelText.frame.size.height + labelText.frame.origin.y + 50) + 56 * i, 10, 10);
            }
            buttonRates.backgroundColor = nil;
            buttonRates.layer.borderColor = [UIColor colorWithHexString:@"949494"].CGColor;
            buttonRates.layer.borderWidth = 0.4;
            buttonRates.layer.cornerRadius = 4;
            buttonRates.tag = i + 20;
            buttonRates.change = YES;
            [buttonRates addTarget:self action:@selector(buttonRatesAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:buttonRates];
            
            //Нужная кнопка----------------
            UIImageView * imageViewRates = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 16, 16)];
            if (isiPhone5) {
                imageViewRates.frame = CGRectMake(0, 0, 10, 10);
            }
            imageViewRates.image = [UIImage imageNamed:@"checkImageButton.png"];
            imageViewRates.tag = i + 10;
            imageViewRates.alpha = 0.f;
            [buttonRates addSubview:imageViewRates];
            
            UILabel * labelTextButton = [[UILabel alloc] initWithFrame:CGRectMake(buttonRates.frame.size.width + buttonRates.frame.origin.x + 32, (labelText.frame.size.height + labelText.frame.origin.y + 88) + 56 * i, 300, 16)];
            labelTextButton.text = [arrayName objectAtIndex:i];
            labelTextButton.textColor = [UIColor colorWithHexString:@"727372"];
            labelTextButton.font = [UIFont fontWithName:FONTREGULAR size:15];
            if (isiPhone5) {
                labelTextButton.frame = CGRectMake(buttonRates.frame.size.width + buttonRates.frame.origin.x + 32, (labelText.frame.size.height + labelText.frame.origin.y + 47) + 56 * i, 300, 16);
                labelTextButton.font = [UIFont fontWithName:FONTREGULAR size:12];
            }
            [self addSubview:labelTextButton];
        }
        
        //Кнопка Подписаться---------------------------------------------------------
        UIButton * buttonSubscribe = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonSubscribe.frame = CGRectMake(self.frame.size.width / 2 - 92, self.frame.size.height - 128, 184, 48);
        buttonSubscribe.backgroundColor = [UIColor colorWithHexString:@"08bb36"];
        buttonSubscribe.layer.cornerRadius = 24;
        [buttonSubscribe setTitle:@"ПОДПИСАТЬСЯ" forState:UIControlStateNormal];
        [buttonSubscribe setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonSubscribe.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:17];
        if (isiPhone5) {
            buttonSubscribe.frame = CGRectMake(self.frame.size.width / 2 - 92, self.frame.size.height - 128, 184, 40);
            buttonSubscribe.layer.cornerRadius = 20;
        }
        [buttonSubscribe addTarget:self action:@selector(buttonSubscribeAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonSubscribe];
        
        //Кнопка соглашение------------
        UIButton * buttonAgreement = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonAgreement.frame = CGRectMake(self.frame.size.width / 2 - 40, buttonSubscribe.frame.size.height + buttonSubscribe.frame.origin.y + 8, 80, 16);
        [buttonAgreement setTitle:@"Соглашение" forState:UIControlStateNormal];
        [buttonAgreement setTitleColor:[UIColor colorWithHexString:@"727372"] forState:UIControlStateNormal];
        buttonAgreement.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:13];
        [buttonAgreement addTarget:self action:@selector(buttonAgreementAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonAgreement];
        
        
    }
    return self;
}

#pragma mark - Action Methods

//Действие кноки выбора тарифа
- (void) buttonRatesAction: (CustomButton*) button
{
    for (int i = 0; i < 4; i++) {
        CustomButton * otherButton  = (CustomButton *) [self viewWithTag:i + 20];
        UIImageView * imgeHol = (UIImageView*) [self viewWithTag:i + 10];
        if (button.tag == i + 20) {
            button.userInteractionEnabled = NO;
            if (button.change) {
                imgeHol.alpha = 1.f;
                button.change = NO;
            }
            
        }else{
            imgeHol.alpha = 0.f;
            otherButton.change = YES;
            otherButton.userInteractionEnabled = YES;
        }
    }
}

//Действие кнопки подписатсья--------------------------------
- (void) buttonSubscribeAction
{
    NSLog(@"Подписаться");
}

//Действие кнопки соглашение---------------------------------
- (void) buttonAgreementAction
{
    NSLog(@"Соглашение");
}


@end
