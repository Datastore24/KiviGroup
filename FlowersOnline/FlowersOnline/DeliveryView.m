//
//  DeliveryView.m
//  FlowersOnline
//
//  Created by Виктор Мишустин on 10.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "DeliveryView.h"
#import "CustomLabels.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@implementation DeliveryView

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 64, view.frame.size.width, view.frame.size.height - 64);
        
        //Лейбл первого заголовка-------------------------------
        CustomLabels * labelTitleOne = [[CustomLabels alloc] initLabelTableWithWidht:20 andHeight:30 andSizeWidht:self.frame.size.width - 40 andSizeHeight:35 andColor:COLORTEXTGRAY andText:@"Цены на доставку по Москве и Московской Области :"];
        labelTitleOne.numberOfLines = 0;
        labelTitleOne.font = [UIFont fontWithName:FONTBOND size:14];
        labelTitleOne.textAlignment = NSTextAlignmentLeft;
        [self addSubview:labelTitleOne];
        
//        //Основной текст первая часть---------------------------
//        CustomLabels * labelTextOne = [CustomLabels alloc] initLabelTableWithWidht:20 andHeight:80 andSizeWidht:self.frame.size.width - 40 andSizeHeight:<#(CGFloat)#> andColor:<#(NSString *)#> andText:<#(NSString *)#>
        
    }
    return self;
}

@end
