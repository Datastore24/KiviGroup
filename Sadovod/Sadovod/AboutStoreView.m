//
//  AboutStoreView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 09/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "AboutStoreView.h"
#import "InputTextView.h"
#import "CustomButton.h"
#import "CustomLabels.h"
#import "Macros.h"
#import "HexColors.h"
#import "UIView+BorderView.h"
#import "SingleTone.h"

@interface AboutStoreView ()

@property (strong, nonatomic) UIScrollView * mainScrollView;

@end

@implementation AboutStoreView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height);
        self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        if (isiPhone6) {
            self.mainScrollView.frame = CGRectMake(0.f, - 25.f, self.frame.size.width, self.frame.size.height);
        }
        if ([[[SingleTone sharedManager] countType] isEqualToString:@"0"]) {
            self.mainScrollView.contentSize = CGSizeMake(0.f, 570.f);
        } else {
            self.mainScrollView.contentSize = CGSizeMake(0.f, 570.f + 50);
        }
        [self addSubview:self.mainScrollView];
        
        
        CustomLabels * labelTitl = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:15.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:20 andColor:@"000000"
                                                                         andText:@"Почему мы?"];
        if (isiPhone6) {
            labelTitl.frame = CGRectMake(15.f, 40.f, self.frame.size.width - 30, 20);
        }
        labelTitl.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
        labelTitl.textAlignment = NSTextAlignmentLeft;
        labelTitl.numberOfLines = 0;
        [self.mainScrollView addSubview:labelTitl];
        
        NSArray * arrayNames = [NSArray arrayWithObjects:
                                @"1. Работаем с розницей, мелким оптом, крупным оптом;",
                                @"2. Продаем без размерных рядов",
                                @"3. Минимальный заказ всего 990 рублей;",
                                @"4. Регулярное пополнение ассортимента;",
                                @"5. Бесплатная доставка до Почты России и ТК;",
                                @"6. Вы сразу видите конечную цену за товар, нет никаких орг. способов и тп.;",
                                @"7. Собираем и отправляем посылки каждый день;",
                                @"8. Возможен самовывоз в Москве (предоплата заказа 100\%);",
                                @"9. Очень быстрая регистрация", nil];
        
        CGFloat floatHeight = 0.f;
        for (int i = 0; i < arrayNames.count; i++) {
            UILabel * labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(15.f, 40.f + floatHeight, self.frame.size.width - 30, 20)];
            if (isiPhone6) {
                if (i == 5 || i == 7) {
                    labelPrice.frame = CGRectMake(15.f, 75.f + floatHeight, self.frame.size.width - 30, 40);
                    labelPrice.numberOfLines = 2;
                    floatHeight += 40;
                } else {
                    labelPrice.frame = CGRectMake(15.f, 75.f + floatHeight, self.frame.size.width - 30, 20);
                    floatHeight += 20;
                    labelPrice.numberOfLines = 1;
                }
            } else {
                if (i == 0 || i == 5 || i == 6 || i == 7) {
                    labelPrice.frame = CGRectMake(15.f, 40.f + floatHeight, self.frame.size.width - 30, 40);
                    labelPrice.numberOfLines = 2;
                    floatHeight += 40;
                } else {
                    floatHeight += 20;
                    labelPrice.numberOfLines = 1;
                }
            }
            labelPrice.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
            labelPrice.textColor = [UIColor blackColor];
            labelPrice.textAlignment = NSTextAlignmentLeft;
            labelPrice.attributedText = [self atributeWithString:[arrayNames objectAtIndex:i] andBoldText:@"без размерных рядов"];
            [self.mainScrollView addSubview:labelPrice];
        }
        
        CustomLabels * labelCooperation = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:310.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:20 andColor:@"000000"
                                                                         andText:@"Условия сотрудничества"];
        labelCooperation.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
        labelCooperation.textAlignment = NSTextAlignmentLeft;
        labelCooperation.numberOfLines = 1;
        [self.mainScrollView addSubview:labelCooperation];
        
        NSArray * arrayCooperation = [NSArray arrayWithObjects:
                                      @"Условия как с физ. лицами так и юр. лицами;",
                                      @"100\% предоплата заказа;",
                                      @"Предоставляем документы к заказу.", nil];
        for (int i = 0; i < 3; i++) {
            CustomLabels * labelPrice = [[CustomLabels alloc] initLabelTableWithWidht:30.f andHeight:340.f + 20 * i andSizeWidht:self.frame.size.width - 30 andSizeHeight:20 andColor:@"000000"
                                                                              andText:[arrayCooperation objectAtIndex:i]];
            labelPrice.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
            labelPrice.numberOfLines = 0;
            labelPrice.textAlignment = NSTextAlignmentLeft;
            [self.mainScrollView addSubview:labelPrice];
            
            UIView * viewRound = [[UIView alloc] init];
            viewRound.frame = CGRectMake(15.f, 346.5f + 20.f * i, 6.f, 6.f);
            viewRound.backgroundColor = [UIColor blackColor];
            viewRound.layer.cornerRadius = 3.f;
            [self.mainScrollView addSubview:viewRound];
        }
        
        CustomLabels * labelPriceTitl = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:410.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:20 andColor:@"000000"
                                                                                andText:@"Способы оплаты"];
        labelPriceTitl.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
        labelPriceTitl.textAlignment = NSTextAlignmentLeft;
        labelPriceTitl.numberOfLines = 1;
        [self.mainScrollView addSubview:labelPriceTitl];
        
        NSArray * arrayPrice = [NSArray arrayWithObjects:
                                        @"1. С карты на карту;",
                                        @"2. Квитанция сбербанка;",
                                        @"3. Банковский перевод;",
                                        @"4. WebMoney;",
                                        @"5. Яндекс.Деньги;",
                                        @"6. Qiwi.",nil];
        for (int i = 0; i < 6; i++) {
            CustomLabels * labelPrice = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:440.f + 20 * i andSizeWidht:self.frame.size.width - 30 andSizeHeight:20 andColor:@"000000"
                                                                              andText:[arrayPrice objectAtIndex:i]];
            labelPrice.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
            labelPrice.textAlignment = NSTextAlignmentLeft;
            [self.mainScrollView addSubview:labelPrice];

        }
        
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
@end
