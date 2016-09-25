//
//  FAQView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 08/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "FAQView.h"
#import "InputTextView.h"
#import "CustomButton.h"
#import "CustomLabels.h"
#import "Macros.h"
#import "HexColors.h"
#import "UIView+BorderView.h"
#import "ArrayTextForFAQ.h"
#import "SingleTone.h"

@interface FAQView ()

@property (strong, nonatomic) UIScrollView * mainScrollView;
@property (strong, nonatomic) NSArray * arrayText; //Массив текстовый данных
@property (strong, nonatomic) NSMutableArray * arrayOffset; //Массив хранит высоты каждого раздела

@property (assign, nonatomic) NSInteger counter;

@end

@implementation FAQView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height);
        self.arrayText = [ArrayTextForFAQ createArrayText];
        self.arrayOffset = [[NSMutableArray alloc] init];
        self.counter = 0.f;
        
        self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        if ([[[SingleTone sharedManager] countType] isEqualToString:@"0"]) {
            if (isiPhone6) {
                self.mainScrollView.contentSize = CGSizeMake(0.f, 1920.f);
            } else {
                self.mainScrollView.contentSize = CGSizeMake(0.f, 2040.f);
            }
        } else {
            if (isiPhone6) {
                self.mainScrollView.contentSize = CGSizeMake(0.f, 1920.f + 50);
            } else {
                self.mainScrollView.contentSize = CGSizeMake(0.f, 2040.f + 50);
            }
        }
        [self addSubview:self.mainScrollView];
        
        CustomLabels * labelTitl = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:20.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:40 andColor:@"5C5C5C"
                                                                         andText:@"Мы подготовили ответы на все Ваши \nсамые популярные вопросы!"];
        labelTitl.numberOfLines = 2;
        labelTitl.textAlignment = NSTextAlignmentLeft;
        labelTitl.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
        [self.mainScrollView addSubview:labelTitl];
        
        NSArray * arrayTheme = [NSArray arrayWithObjects:
                                @"Если пришел брак?", @"Сроки сборки заказа?", @"Стоимость и сроки доставки",
                                @"Когда отправляете товар?", @"Как оплатить товар?", @"Способ доставки?",
                                @"Как вы работаете в выходные?", @"Сколько дней поступает оплата?", nil];
        for (int i = 0; i < 8; i++) {
            UIButton * buttonTheme = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonTheme.frame = CGRectMake(15.f, 70.f + 30 * i, self.frame.size.width - 30.f, 20.f);
            buttonTheme.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [buttonTheme setTitle:[arrayTheme objectAtIndex:i] forState:UIControlStateNormal];
            buttonTheme.tag = 10 + i;
            [buttonTheme addTarget:self action:@selector(buttonThemeAction:) forControlEvents:UIControlEventTouchUpInside];
            [buttonTheme setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_800] forState:UIControlStateNormal];
            buttonTheme.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
            [self.mainScrollView addSubview:buttonTheme];
        }
        
        
        
        //Если пришел брак?
        UIView * viewMarriage = [self customViewTextWithTitl:@"Если пришел брак?" andFrame:CGRectMake(0.f, 300.f, self.frame.size.width, 200.f) andText: [self.arrayText objectAtIndex:0] andBoldText: @"рабочих"];
        [self.mainScrollView addSubview:viewMarriage];
        [self.arrayOffset addObject:[NSNumber numberWithFloat:300.f]];
        
        //Сроки сборки заказа?
        UIView * viewTerms = [self customViewTextWithTitl:@"Сроки сборки заказа?" andFrame:CGRectMake(0.f, viewMarriage.frame.size.height + viewMarriage.frame.origin.y + 30, self.frame.size.width, 170.f) andText: [self.arrayText objectAtIndex:1] andBoldText: @"от 1 до 7 рабочих дней"];
        if (isiPhone6) {
            viewTerms.frame = CGRectMake(0.f, viewMarriage.frame.size.height + viewMarriage.frame.origin.y + 10, self.frame.size.width, 170.f);
        }
        [self.mainScrollView addSubview:viewTerms];
        
        if (isiPhone6) {
            [self.arrayOffset addObject:[NSNumber numberWithFloat:viewMarriage.frame.size.height + viewMarriage.frame.origin.y + 10]];
        } else {
            [self.arrayOffset addObject:[NSNumber numberWithFloat:viewMarriage.frame.size.height + viewMarriage.frame.origin.y + 30]];
        }
        
        //Стоимость и сроки доставки
        UIView * viewDelivery = [self customViewTextWithTitl:@"Стоимость и сроки доставки" andFrame:CGRectMake(0.f, viewTerms.frame.size.height + viewTerms.frame.origin.y + 25, self.frame.size.width, 177.f) andText: [self.arrayText objectAtIndex:2] andBoldText: nil];
        if (isiPhone6) {
            viewDelivery.frame = CGRectMake(0.f, viewTerms.frame.size.height + viewTerms.frame.origin.y, self.frame.size.width, 177.f);
        }
        [self.mainScrollView addSubview:viewDelivery];
        if (isiPhone6) {
            [self.arrayOffset addObject:[NSNumber numberWithFloat:viewTerms.frame.size.height + viewTerms.frame.origin.y - 5]];
        } else {
            [self.arrayOffset addObject:[NSNumber numberWithFloat:viewTerms.frame.size.height + viewTerms.frame.origin.y + 25]];
        }
        
        
        NSArray * arrayDelivery = [NSArray arrayWithObjects:
                                @"Байкал-Сервис", @"ПЭК", @"Деловын линии",
                                @"ЖелДорЭкспедиция", @"КИТ", @"Энергия", nil];
        for (int i = 0; i < arrayDelivery.count; i++) {
            UIButton * buttonDelivary = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonDelivary.frame = CGRectMake(15.f, (viewDelivery.frame.size.height + viewDelivery.frame.origin.y + 50) + 20 * i, self.frame.size.width - 30.f, 20.f);
            if (isiPhone6) {
                buttonDelivary.frame = CGRectMake(15.f, (viewDelivery.frame.size.height + viewDelivery.frame.origin.y + 20) + 20 * i, self.frame.size.width - 30.f, 20.f);
            }
            buttonDelivary.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [buttonDelivary setTitle:[arrayDelivery objectAtIndex:i] forState:UIControlStateNormal];
            [buttonDelivary setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_300] forState:UIControlStateNormal];
            buttonDelivary.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
            [self.mainScrollView addSubview:buttonDelivary];
        }
        
        
        //Когда отправляете товар?
        UIView * viewPost = [self customViewTextWithTitl:@"Когда отправляете товар?" andFrame:CGRectMake(0.f, viewDelivery.frame.size.height + viewDelivery.frame.origin.y + 170, self.frame.size.width, 65.f) andText: [self.arrayText objectAtIndex:3] andBoldText: nil];
        if (isiPhone6) {
            viewPost.frame = CGRectMake(0.f, viewDelivery.frame.size.height + viewDelivery.frame.origin.y + 140, self.frame.size.width, 65.f);
        }
        [self.mainScrollView addSubview:viewPost];
        if (isiPhone6) {
            [self.arrayOffset addObject:[NSNumber numberWithFloat:viewDelivery.frame.size.height + viewDelivery.frame.origin.y + 140]];
        } else {
            [self.arrayOffset addObject:[NSNumber numberWithFloat:viewDelivery.frame.size.height + viewDelivery.frame.origin.y + 170]];
        }
        
        
        //Как оплатить товар?
        UIView * viewPrice = [self customViewTextWithTitl:@"Как оплатить товар?" andFrame:CGRectMake(0.f, viewPost.frame.size.height + viewPost.frame.origin.y + 30, self.frame.size.width, 160.f) andText: [self.arrayText objectAtIndex:4] andBoldText: nil];
        [self.mainScrollView addSubview:viewPrice];
        [self.arrayOffset addObject:[NSNumber numberWithFloat:viewPost.frame.size.height + viewPost.frame.origin.y + 30]];
        
        //Способ доставки?
        UIView * viewDeliveryTypes = [self customViewTextWithTitl:@"Способ доставки?" andFrame:CGRectMake(0.f, viewPrice.frame.size.height + viewPrice.frame.origin.y + 30, self.frame.size.width, 290.f) andText: [self.arrayText objectAtIndex:5] andBoldText: nil];
        if (isiPhone6) {
            viewDeliveryTypes.frame = CGRectMake(0.f, viewPrice.frame.size.height + viewPrice.frame.origin.y + 40, self.frame.size.width, 290.f);
            
        }
        [self.mainScrollView addSubview:viewDeliveryTypes];
        if (isiPhone6) {
            [self.arrayOffset addObject:[NSNumber numberWithFloat:viewPrice.frame.size.height + viewPrice.frame.origin.y + 40]];
        } else {
            [self.arrayOffset addObject:[NSNumber numberWithFloat:viewPrice.frame.size.height + viewPrice.frame.origin.y + 30]];
        }
        
        
        //Как вы работаете в выходные?
        UIView * viewWeekend = [self customViewTextWithTitl:@"Как вы работаете в выходные?" andFrame:CGRectMake(0.f, viewDeliveryTypes.frame.size.height + viewDeliveryTypes.frame.origin.y + 30, self.frame.size.width, 115.f) andText: [self.arrayText objectAtIndex:6] andBoldText: nil];
        if (isiPhone6) {
            viewWeekend.frame = CGRectMake(0.f, viewDeliveryTypes.frame.size.height + viewDeliveryTypes.frame.origin.y - 25, self.frame.size.width, 115.f);
        }
        [self.mainScrollView addSubview:viewWeekend];
        if ([[[SingleTone sharedManager] countType] isEqualToString:@"0"]) {
            if (isiPhone6) {
                [self.arrayOffset addObject:[NSNumber numberWithFloat:viewDeliveryTypes.frame.size.height + viewDeliveryTypes.frame.origin.y - 265]];
            } else {
                [self.arrayOffset addObject:[NSNumber numberWithFloat:viewDeliveryTypes.frame.size.height + viewDeliveryTypes.frame.origin.y - 115]];
            }
            
        } else {
            if (isiPhone6) {
                [self.arrayOffset addObject:[NSNumber numberWithFloat:viewDeliveryTypes.frame.size.height + viewDeliveryTypes.frame.origin.y - 265 + 50]];
            } else {
                [self.arrayOffset addObject:[NSNumber numberWithFloat:viewDeliveryTypes.frame.size.height + viewDeliveryTypes.frame.origin.y - 115 + 50]];
            }
            
        }
        
        
        //Сколько дней поступает оплата?
        UIView * viewPay = [self customViewTextWithTitl:@"Сколько дней поступает оплата?" andFrame:CGRectMake(0.f, viewWeekend.frame.size.height + viewWeekend.frame.origin.y + 30, self.frame.size.width, 100.f) andText: [self.arrayText objectAtIndex:7] andBoldText: nil];
        [self.mainScrollView addSubview:viewPay];
        if ([[[SingleTone sharedManager] countType] isEqualToString:@"0"]) {
            if (isiPhone6) {
                [self.arrayOffset addObject:[NSNumber numberWithFloat:viewDeliveryTypes.frame.size.height + viewDeliveryTypes.frame.origin.y - 265]];
            } else {
                [self.arrayOffset addObject:[NSNumber numberWithFloat:viewDeliveryTypes.frame.size.height + viewDeliveryTypes.frame.origin.y - 115]];
            }
            
        } else {
            if (isiPhone6) {
                [self.arrayOffset addObject:[NSNumber numberWithFloat:viewDeliveryTypes.frame.size.height + viewDeliveryTypes.frame.origin.y - 265 + 50]];
            } else {
                [self.arrayOffset addObject:[NSNumber numberWithFloat:viewDeliveryTypes.frame.size.height + viewDeliveryTypes.frame.origin.y - 115 + 50]];
            }
            
        }
        
        UIButton * buttonQuestien = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonQuestien.frame = CGRectMake(15.f, viewPay.frame.size.height + viewPay.frame.origin.y + 55, self.frame.size.width - 30.f, 40);
        buttonQuestien.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_300];
        [buttonQuestien setTitle:@"Задать вопрос" forState:UIControlStateNormal];
        [buttonQuestien setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonQuestien.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800].CGColor;
        buttonQuestien.layer.borderWidth = 1.f;
        buttonQuestien.layer.cornerRadius = 3.f;
        buttonQuestien.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:16];
        [buttonQuestien addTarget:self action:@selector(buttonQuestienAction) forControlEvents:UIControlEventTouchUpInside];
        [self.mainScrollView addSubview:buttonQuestien];
    }
    return self;
}

#pragma mark - Actions

- (void) buttonThemeAction: (UIButton*) button {
    for (int i = 0; i < 8; i++) {
        if (button.tag == 10 + i) {
            [self setOffcetWithHeight:[[self.arrayOffset objectAtIndex:i]floatValue] - 60];
        }
    }
}

- (void) buttonQuestienAction {
    [self.delegate pushTuQuestion:self];
}

#pragma mark - Other

//Метод создает текстовую структуру с заголовком

- (UIView*) customViewTextWithTitl: (NSString*) titlString andFrame: (CGRect) frame andText: (NSString*) text andBoldText: (NSString*) boldText {
    UIView * customView = [[UIView alloc] initWithFrame:frame];
    
    CustomLabels * labelTitl = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:5.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:40 andColor:VM_COLOR_800
                                                                     andText:titlString];
    labelTitl.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
    [customView addSubview:labelTitl];
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.f, 40.f, self.frame.size.width - 30, customView.frame.size.height)];
    textLabel.textColor = [UIColor blackColor];
    textLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
    textLabel.numberOfLines = 0;
    textLabel.attributedText = [self atributeWithString:text andBoldText:boldText];
    [customView addSubview:textLabel];
    
    if (isiPhone6 || isiPhone6Plus) {
        CGRect rect = textLabel.frame;
        if (self.counter == 0) {
            rect.size.height -= 20;
        } else if (self.counter == 1) {
            rect.size.height -= 30;
        } else if (self.counter == 2) {
            rect.size.height -= 20;
        } else if (self.counter == 4) {
            rect.size.height += 10;
        } else if (self.counter == 5) {
            rect.size.height -= 60;
        } else if (self.counter == 7) {
            rect.size.height += 5;
        }
        
        textLabel.frame = rect;
        self.counter += 1;
        
        
        
        
        
        
        
    }
    

    
    return customView;
}



- (NSMutableAttributedString*) atributeWithString: (NSString*) text andBoldText: (NSString*) boldText {
    NSRange range;
    if (boldText != nil) {
       range = [text rangeOfString:boldText];
    } else {
        range = [text rangeOfString:@""];
    }
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:3];
    [attrString addAttribute:NSParagraphStyleAttributeName
                       value:style
                       range:NSMakeRange(0, text.length)];
    if (boldText != nil) {
        [attrString beginEditing];
        [attrString addAttribute:NSFontAttributeName
                           value:[UIFont fontWithName:@"Helvetica-Bold" size:12.0]
                           range:range];
        
        [attrString endEditing];
    }
    return attrString;
}

- (void) setOffcetWithHeight: (CGFloat) height {
    self.mainScrollView.contentOffset = CGPointMake(0, height);
}

@end
