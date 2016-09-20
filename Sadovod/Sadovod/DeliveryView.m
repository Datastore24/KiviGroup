//
//  DeliveryView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 09/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "DeliveryView.h"
#import "InputTextView.h"
#import "CustomButton.h"
#import "CustomLabels.h"
#import "Macros.h"
#import "HexColors.h"
#import "UIView+BorderView.h"
#import "SingleTone.h"

@interface DeliveryView ()

@property (strong, nonatomic) UIScrollView * mainScrollView;

@end

@implementation DeliveryView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height);
        self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        if ([[[SingleTone sharedManager] countType] isEqualToString:@"0"]) {
            self.mainScrollView.contentSize = CGSizeMake(0, 550);
        } else {
            self.mainScrollView.contentSize = CGSizeMake(0, 550 + 40);
        }
        [self addSubview:self.mainScrollView];
        
        CustomLabels * labelTitl = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:15.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:40 andColor:@"000000"
                                                                         andText:@"Доставка товара производится по всем регионам России и СНГ."];
        labelTitl.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
        labelTitl.numberOfLines = 2;
        labelTitl.textAlignment = NSTextAlignmentLeft;
        [self.mainScrollView addSubview:labelTitl];
        
        CustomLabels * labelDeliveryTypes = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:50.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:40 andColor:@"000000"
                                                                         andText:@"Способы доставки:"];
        labelDeliveryTypes.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        labelDeliveryTypes.textAlignment = NSTextAlignmentLeft;
        [self.mainScrollView addSubview:labelDeliveryTypes];
        
        UILabel * labelDelivery = [[UILabel alloc] initWithFrame:CGRectMake(35.f, 75.f, self.frame.size.width - 50.f, 100.f)];\
        labelDelivery.numberOfLines = 0;
        labelDelivery.attributedText = [self atributeWithString:@"Платная доставка курьером по Москве - 450 руб.\nБесплатная доставка до Почты России\nБесплатная доставка до выбранной транспортной компании" andBoldText:nil];
        labelDelivery.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
        [self.mainScrollView addSubview:labelDelivery];
        
        for (int i = 0; i < 3; i++) {
            UIView * viewRound = [[UIView alloc] init];
            viewRound.frame = CGRectMake(20.f, 90.f + 20.f * i, 6.f, 6.f);
            if (i > 0) {
                viewRound.frame = CGRectMake(20.f, 105.f + 16.f * i + 1, 6.f, 6.f);
            }
            viewRound.backgroundColor = [UIColor blackColor];
            viewRound.layer.cornerRadius = 3.f;
            [self.mainScrollView addSubview:viewRound];
        }
        
        CustomLabels * labelDeliveryAll = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:160.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:60 andColor:@"000000"
                                                                                  andText:@"Транспортные компании с которыми мы сотрудничаем"];
        labelDeliveryAll.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        labelDeliveryAll.numberOfLines = 2;
        labelDeliveryAll.textAlignment = NSTextAlignmentLeft;
        [self.mainScrollView addSubview:labelDeliveryAll];
        
        NSArray * arrayDelivery = [NSArray arrayWithObjects:
                                   @"Байкал-Сервис", @"ПЭК", @"Деловын линии",
                                   @"ЖелДорЭкспедиция", @"КИТ", @"Энергия", nil];
        for (int i = 0; i < arrayDelivery.count; i++) {
            UIButton * buttonDelivary = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonDelivary.frame = CGRectMake(35.f, 210 + 20 * i, self.frame.size.width - 50.f, 20.f);
            buttonDelivary.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [buttonDelivary setTitle:[arrayDelivery objectAtIndex:i] forState:UIControlStateNormal];
            [buttonDelivary setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_300] forState:UIControlStateNormal];
            buttonDelivary.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
            [self.mainScrollView addSubview:buttonDelivary];
            
            UIView * viewRound = [[UIView alloc] init];
            viewRound.frame = CGRectMake(20.f, 217.f + 20.f * i, 6.f, 6.f);
            viewRound.backgroundColor = [UIColor blackColor];
            viewRound.layer.cornerRadius = 3.f;
            [self.mainScrollView addSubview:viewRound];
        }
        
        
        UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.f, 320.f, self.frame.size.width - 30, 100)];
        textLabel.textColor = [UIColor blackColor];
        textLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
        textLabel.numberOfLines = 0;
        textLabel.attributedText = [self atributeWithString:@"Отправка посылок происходит каждый день. Ознакомьтесь так же со страницей популярных вопросов, она может дать развернутые ответы на Ваши вопросы." andBoldText:@"каждый день" andBoldTwo: @"популярных вопросов"];
        [self.mainScrollView addSubview:textLabel];
        
        NSArray * arrayButtonsName = [NSArray arrayWithObjects:@"Задать вопрос", @"Частые вопросы", nil];
        NSArray * arrayImages = [NSArray arrayWithObjects:@"imageQuestion.png", @"seeQuestion.png", nil];
        for (int i = 0; i < 2; i++) {
            UIButton * buttonQuestien = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonQuestien.frame = CGRectMake(15.f + (self.frame.size.width / 2 - 7.5) * i, 430, self.frame.size.width / 2 - 22.5f, 40);
            buttonQuestien.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_300];
            [buttonQuestien setTitle:[arrayButtonsName objectAtIndex:i] forState:UIControlStateNormal];
            [buttonQuestien setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            buttonQuestien.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800].CGColor;
            buttonQuestien.layer.borderWidth = 1.f;
            buttonQuestien.layer.cornerRadius = 3.f;
            buttonQuestien.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
            buttonQuestien.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
            [self.mainScrollView addSubview:buttonQuestien];
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 15.f, 15.f)];
            if (i == 1) {
                imageView.frame = CGRectMake(10, 12, 15.f, 15.f);
            }
            imageView.image = [UIImage imageNamed:[arrayImages objectAtIndex:i]];
            [buttonQuestien addSubview:imageView];
        }
        
        UIButton * buttonMain = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonMain.frame = CGRectMake(15.f, 480, self.frame.size.width - 30.f, 40);
        buttonMain.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_300];
        [buttonMain setTitle:@"Вернуться на главную" forState:UIControlStateNormal];
        [buttonMain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonMain.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800].CGColor;
        buttonMain.layer.borderWidth = 1.f;
        buttonMain.layer.cornerRadius = 3.f;
        buttonMain.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        buttonMain.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
        [self.mainScrollView addSubview:buttonMain];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 12, 15.f, 15.f)];
        imageView.image = [UIImage imageNamed:@"imageHous.png"];
        [buttonMain addSubview:imageView];
        

        
        
    }
    return self;
}

#pragma mark - Other


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

- (NSMutableAttributedString*) atributeWithString: (NSString*) text andBoldText: (NSString*) boldText andBoldTwo: (NSString*) boldTwo {
    NSRange range;
    if (boldText != nil) {
        range = [text rangeOfString:boldText];
    } else {
        range = [text rangeOfString:@""];
    }
    
    NSRange rangeTwo;
    if (boldTwo != nil) {
        rangeTwo = [text rangeOfString:boldTwo];
    } else {
        rangeTwo = [text rangeOfString:@""];
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
    
    if (boldTwo != nil) {
        [attrString beginEditing];
        [attrString addAttribute:NSFontAttributeName
                           value:[UIFont fontWithName:@"Helvetica-Bold" size:12.0]
                           range:rangeTwo];
        
        [attrString endEditing];
    }
    return attrString;
}



@end
