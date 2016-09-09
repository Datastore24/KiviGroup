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
        [self addSubview:self.mainScrollView];
        
        CustomLabels * labelTitl = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:20.f andSizeWidht:self.frame.size.width - 30 andSizeHeight:40 andColor:@"000000"
                                                                         andText:@"Доставка товара производится по всем регионам России и СНГ."];
        labelTitl.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        labelTitl.numberOfLines = 2;
        labelTitl.textAlignment = NSTextAlignmentLeft;
        [self.mainScrollView addSubview:labelTitl];
    }
    return self;
}

@end
