//
//  PriceView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 09/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "PriceView.h"
#import "InputTextView.h"
#import "CustomButton.h"
#import "CustomLabels.h"
#import "Macros.h"
#import "HexColors.h"
#import "UIView+BorderView.h"
#import "SingleTone.h"

@interface PriceView ()

@property (strong, nonatomic) UIScrollView * mainScrollView;

@end

@implementation PriceView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height);
        self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        [self addSubview:self.mainScrollView];
        if ([[[SingleTone sharedManager] countType] isEqualToString:@"0"]) {
            self.mainScrollView.contentSize = CGSizeMake(0, 0);
        } else {
            self.mainScrollView.contentSize = CGSizeMake(0, self.frame.size.height - 20);
        }
        
        UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.f, 15.f, self.frame.size.width - 30, 130)];
        textLabel.textColor = [UIColor blackColor];
        textLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
        textLabel.numberOfLines = 0;
        textLabel.attributedText = [self atributeWithString:@"Минимальная сумма заказа 1990 рублей.\nСбор заказа начинается после 100% предоплаты и длится от 1 до 7 рабочих дней, отправки заказов происходят каждый день.\nПри самовывозе предоплата так же 100%!\nПосле оплаты заказа для более скорейшего начала сборки сообщайте ответным письмом на счет к заказу что Вы оплатили и с какого счета." andBoldText:@"1990 рублей" andBoldTwo: @"от 1 до 7 рабочих дней"];
        [self.mainScrollView addSubview:textLabel];
        
        
        CustomLabels * labelTitl = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:145.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:40 andColor:@"000000"
                                                                         andText:@"Мы принимаем несколько видов оплаты:"];
        labelTitl.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        labelTitl.numberOfLines = 2;
        labelTitl.textAlignment = NSTextAlignmentLeft;
        [self.mainScrollView addSubview:labelTitl];
        
        NSArray * arrayNames = [NSArray arrayWithObjects:@"С карты на карту Сбербанка", @"WebMoney", @"Qiwi", @"Яндекс.Деньги", @"Квитанция Сбербанка", @"Оплата на расчетный счет", nil];
        for (int i = 0; i < 6; i++) {
            CustomLabels * labelPrice = [[CustomLabels alloc] initLabelTableWithWidht:40.f andHeight:180.f + 20 * i andSizeWidht:self.frame.size.width - 30 andSizeHeight:20 andColor:@"000000"
                                                                             andText:[arrayNames objectAtIndex:i]];
            labelPrice.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
            labelPrice.numberOfLines = 1;
            labelPrice.textAlignment = NSTextAlignmentLeft;
            [self.mainScrollView addSubview:labelPrice];
            
            UIView * viewRound = [[UIView alloc] init];
            viewRound.frame = CGRectMake(20.f, 186.5f + 20.f * i, 6.f, 6.f);
            viewRound.backgroundColor = [UIColor blackColor];
            viewRound.layer.cornerRadius = 3.f;
            [self.mainScrollView addSubview:viewRound];
        }
        
        
        UILabel * textOther = [[UILabel alloc] initWithFrame:CGRectMake(15.f, 290.f, self.frame.size.width - 30, 80)];
        textOther.textColor = [UIColor blackColor];
        textOther.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
        textOther.numberOfLines = 0;
        textOther.text = @"Если у Вас еще остались какие-либо вопросы, ознакомьтесь со страницей популярных вопросов и ответов.";
        [self.mainScrollView addSubview:textOther];
        
        CustomLabels * labelGood = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:350.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:40 andColor:@"000000"
                                                                         andText:@"Приятных Вам покупок!"];
        labelGood.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        labelGood.numberOfLines = 2;
        labelGood.textAlignment = NSTextAlignmentLeft;
        [self.mainScrollView addSubview:labelGood];
        
        NSArray * arrayButtonsName = [NSArray arrayWithObjects:@"Задать вопрос", @"Частые вопросы", nil];
        NSArray * arrayImages = [NSArray arrayWithObjects:@"imageQuestion.png", @"seeQuestion.png", nil];
        for (int i = 0; i < 2; i++) {
            UIButton * buttonQuestien = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonQuestien.frame = CGRectMake(15.f + (self.frame.size.width / 2 - 7.5) * i, 390, self.frame.size.width / 2 - 22.5f, 40);
            buttonQuestien.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_300];
            [buttonQuestien setTitle:[arrayButtonsName objectAtIndex:i] forState:UIControlStateNormal];
            [buttonQuestien setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            buttonQuestien.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800].CGColor;
            buttonQuestien.layer.borderWidth = 1.f;
            buttonQuestien.layer.cornerRadius = 3.f;
            buttonQuestien.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
            buttonQuestien.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
            buttonQuestien.tag = 1000 + i;
            [buttonQuestien addTarget:self action:@selector(buttonQuestienAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.mainScrollView addSubview:buttonQuestien];
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 15.f, 15.f)];
            if (i == 1) {
                imageView.frame = CGRectMake(10, 12, 15.f, 15.f);
            }
            imageView.image = [UIImage imageNamed:[arrayImages objectAtIndex:i]];
            [buttonQuestien addSubview:imageView];
        }
        
        UIButton * buttonMain = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonMain.frame = CGRectMake(15.f, 440, self.frame.size.width - 30.f, 40);
        buttonMain.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_300];
        [buttonMain setTitle:@"Вернуться на главную" forState:UIControlStateNormal];
        [buttonMain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonMain.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800].CGColor;
        buttonMain.layer.borderWidth = 1.f;
        buttonMain.layer.cornerRadius = 3.f;
        buttonMain.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        buttonMain.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
        [buttonMain addTarget:self action:@selector(buttonMainAction) forControlEvents:UIControlEventTouchUpInside];
        [self.mainScrollView addSubview:buttonMain];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 12, 15.f, 15.f)];
        imageView.image = [UIImage imageNamed:@"imageHous.png"];
        [buttonMain addSubview:imageView];
        
        
        
    }
    return self;
}

#pragma mark - Actions

- (void) buttonQuestienAction: (UIButton*) button {
    if (button.tag == 1000) {
        [self.delegate pushToQuestion:self];
    } else {
        [self.delegate pushToFAQ:self];
    }
}

- (void) buttonMainAction {
    [self.delegate backToMain:self];
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
