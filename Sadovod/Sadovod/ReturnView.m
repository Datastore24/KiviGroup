//
//  ReturnView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 09/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "ReturnView.h"
#import "InputTextView.h"
#import "CustomButton.h"
#import "CustomLabels.h"
#import "Macros.h"
#import "HexColors.h"
#import "UIView+BorderView.h"

@interface ReturnView ()

@property (strong, nonatomic) UIScrollView * mainScrollView;

@end

@implementation ReturnView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height);
        self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        self.mainScrollView.contentSize = CGSizeMake(0, 570);
        [self addSubview:self.mainScrollView];
        
        NSString * textString = @"Наш магазин несет ответственность за реализуемую продукцию и свою работу. Поскольку каждый покупатель должен быть уверен в качестве товара, то при покупке мы предоставляем возможность проверить изделия на отсутствие дефектов и правильность комплектации. В противном случае клиент вправе вернуть некачественный товар.\n\nПретензии принимаются в течени 6 дней с момента получения заказа через почту info@tk-sad.ru. Обработка претензий может составить 3-5 рабочих дней, не считая дня подачи претензии. Присылайте полное описание проблемы вместе с фото, если имеется. При недовложении указывайте так же номер заказ, артикул, и стоимость не вложенных вещей. По недовложению фото можно взять с сайта либо указать ссылки на товар. При несоответствии размера, фото делайте с сантиметровой лентой.";
        
        UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake(15.f, 15.f, self.frame.size.width - 30, 350)];
        labelText.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
        labelText.textColor = [UIColor blackColor];
        labelText.numberOfLines = 0;
        labelText.textAlignment = NSTextAlignmentLeft;
        labelText.attributedText = [self atributeWithString:textString andBoldText:@"клиент вправе вернуть некачественный товар"];
        [self.mainScrollView addSubview:labelText];
        
        CustomLabels * labelTitl = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:370.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:20 andColor:@"000000"
                                                                                andText:@"Обратите внимание:"];
        labelTitl.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
        labelTitl.textAlignment = NSTextAlignmentLeft;
        labelTitl.numberOfLines = 1;
        [self.mainScrollView addSubview:labelTitl];
        
        NSArray * arrayText = [NSArray arrayWithObjects:
                               @"Обмен товара либо возврат денег делаем в двух случаях: брак либо пересорт товара.",
                               @"Товар должен быть возвращен нам с оригинальными ярлыками и этикетами и в оригинальной упаковке, так же должны присутствовать QR-коды;",
                               @"При возврате товара в ненадлежащем качестве, товар будет отправлен обратно покупателю.", nil];
        for (int i = 0; i < 3; i++) {
            UILabel * labelAttention = [[UILabel alloc] initWithFrame:CGRectMake(30.f, 380.f, self.frame.size.width - 45, 60)];
            if (i == 1) {
                labelAttention.frame = CGRectMake(30.f, 430.f, self.frame.size.width - 45, 80);
            }
            if (i == 2) {
                labelAttention.frame = CGRectMake(30.f, 505, self.frame.size.width - 45, 40);
            }
            labelAttention.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
            labelAttention.textColor = [UIColor blackColor];
            labelAttention.numberOfLines = 0;
            labelAttention.textAlignment = NSTextAlignmentLeft;
            labelAttention.attributedText = [self atributeWithString:[arrayText objectAtIndex:i] andBoldText:@"оригинальными ярлыками и этикетами и в оригинальной упаковке, так же должны присутствовать QR-коды" andBoldTwo: @"Обмен товара либо возврат денег делаем в двух случаях: брак либо пересорт товара"];
            [self.mainScrollView addSubview:labelAttention];
            
            UIView * viewRound = [[UIView alloc] init];
            viewRound.frame = CGRectMake(15.f, 399, 6.f, 6.f);
            if (i == 1) {
                viewRound.frame = CGRectMake(15.f, 440, 6.f, 6.f);
            }
            if (i == 2) {
                viewRound.frame = CGRectMake(15.f, 513, 6.f, 6.f);
            }
            viewRound.backgroundColor = [UIColor blackColor];
            viewRound.layer.cornerRadius = 3.f;
            [self.mainScrollView addSubview:viewRound];
        }
        
        UIView * bordView = [[UIView alloc] initWithFrame:CGRectMake(118.f, 424.f, 165.f, 1.f)];
        bordView.backgroundColor = [UIColor blackColor];
        [self.mainScrollView addSubview:bordView];
        
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
