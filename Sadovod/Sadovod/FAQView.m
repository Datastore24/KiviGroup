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

@interface FAQView ()

@property (strong, nonatomic) UIScrollView * mainScrollView;

@end

@implementation FAQView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height);
        
        self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        [self addSubview:self.mainScrollView];
        
        CustomLabels * labelTitl = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:20.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:40 andColor:@"5C5C5C"
                                                                         andText:@"Мы подготовили ответы на все Ваши \nсамые популярные вопросы!"];
        labelTitl.numberOfLines = 2;
        labelTitl.textAlignment = NSTextAlignmentLeft;
        labelTitl.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
        [self.mainScrollView addSubview:labelTitl];
        
        NSArray * arrayTheme = [NSArray arrayWithObjects:
                                @"Если пришел брак?", @"Сроки сборки заказа?", @"Стоимость и сроки доставки",
                                @"Когда отправляете товар?", @"Как оплатить товар?", @"Способ доставки ?",
                                @"Как вы работаете в выходные", @"Сколько дней поступает оплата?", nil];
        for (int i = 0; i < 8; i++) {
            UIButton * buttonTheme = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonTheme.frame = CGRectMake(15.f, 70.f + 30 * i, self.frame.size.width - 30.f, 20);
            buttonTheme.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [buttonTheme setTitle:[arrayTheme objectAtIndex:i] forState:UIControlStateNormal];
            [buttonTheme setTitleColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_800] forState:UIControlStateNormal];
            buttonTheme.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
            [self.mainScrollView addSubview:buttonTheme];
        }
    }
    return self;
}

#pragma mark - Other

//Метод создает текстовую структуру с заголовком

- (UIView*) customViewTextWithTitl: (NSString*) titlString andFrame: (CGRect) frame {
    UIView * customView = [[UIView alloc] initWithFrame:frame];
    
    CustomLabels * labelTitl = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:20.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:40 andColor:@"5C5C5C"
                                                                     andText:titlString];
    labelTitl.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
    [customView addSubview:labelTitl];
    
    return customView;
}

@end
