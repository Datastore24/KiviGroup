//
//  BasketView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 30/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "BasketView.h"
#import "CustomButton.h"
#import "UIButton+ButtonImage.h"
#import "CustomLabels.h"
#import "UIView+BorderView.h"
#import "HexColors.h"
#import "Macros.h"

@interface BasketView ()

//Main

@property (strong, nonatomic) UIScrollView * mainScrollView;
@property (strong, nonatomic) NSArray * arrayData;
@property (strong, nonatomic) NSMutableArray * arrayView; //Массив отображения всю каждого заказа (для анимации)


@end

@implementation BasketView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height);
        self.arrayData = data;
        
        NSLog(@"%@", self.arrayData);
        
        self.arrayView = [[NSMutableArray alloc] init];
        
        self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.mainScrollView.contentSize = CGSizeMake(0, 180 * self.arrayData.count + 40);
        [self addSubview:self.mainScrollView];
        
        for (int i = 0; i < self.arrayData.count; i++) {
            
            NSDictionary * dictData = [self.arrayData objectAtIndex:i];
            
            UIView * viewOrder = [[UIView alloc] initWithFrame:CGRectMake(0, 0 + 180 * i, self.frame.size.width, 180)];
            [self.mainScrollView addSubview:viewOrder];
            
            [UIView borderViewWithHeight:179 andWight:0 andView:viewOrder andColor:@"B8B8B8"];
            
            UIImageView * imageOrder = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 160, 160)];
            imageOrder.image = [UIImage imageNamed:[dictData objectForKey:@"image"]];
            imageOrder.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            imageOrder.layer.borderWidth = 0.3f;
            imageOrder.layer.cornerRadius = 2.f;
            imageOrder.layer.shadowColor = [[UIColor blackColor] CGColor];
            imageOrder.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
            imageOrder.layer.shadowRadius = 1.0f;
            imageOrder.layer.shadowOpacity = 0.5f;
            [viewOrder addSubview:imageOrder];
            
            
            
            CustomLabels * labelName = [[CustomLabels alloc] initLabelWithWidht:220 andHeight:15 andColor:@"000000"
                                                                        andText:[dictData objectForKey:@"name"] andTextSize:16 andLineSpacing:0.f fontName:VM_FONT_BOLD];
            [viewOrder addSubview:labelName];
            
            CustomLabels * labelPrice = [[CustomLabels alloc] initLabelWithWidht:220 andHeight:35 andColor: VM_COLOR_800
                                                                        andText:[NSString stringWithFormat:@"%@ руб", [dictData objectForKey:@"price"]] andTextSize:16 andLineSpacing:0.f fontName:VM_FONT_BOLD];
            [viewOrder addSubview:labelPrice];
            
            CustomLabels * labelSize = [[CustomLabels alloc] initLabelWithWidht:220 andHeight:60 andColor: @"808080"
                                                                         andText:[NSString stringWithFormat:@"размер %@", [dictData objectForKey:@"size"]] andTextSize:16 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
            [viewOrder addSubview:labelSize];
            
            CustomLabels * labelCount = [[CustomLabels alloc] initLabelWithWidht:220 andHeight:100 andColor: @"666666"
                                                                        andText:@"Кол-во:" andTextSize:13 andLineSpacing:0.f fontName:VM_FONT_BOLD];
            [viewOrder addSubview:labelCount];
            
            UIButton * buttonCount = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonCount.frame = CGRectMake(220.f, 120.f, 40, 40);
            [buttonCount setTitle:[dictData objectForKey:@"count"] forState:UIControlStateNormal];
            [buttonCount setTitleColor:[UIColor hx_colorWithHexRGBAString:@"666666"] forState:UIControlStateNormal];
            buttonCount.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
            buttonCount.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            buttonCount.backgroundColor = [UIColor groupTableViewBackgroundColor];
            buttonCount.layer.borderWidth = 0.5f;
            buttonCount.layer.cornerRadius = 0.f;
            [viewOrder addSubview:buttonCount];
            
            UIButton * buttonBasket = [UIButton createButtonCustomImageWithImage:@"trash.png" andRect:CGRectMake(270, 120, 40, 40)];
            [buttonBasket setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
            buttonBasket.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            buttonBasket.backgroundColor = [UIColor groupTableViewBackgroundColor];
            buttonBasket.layer.borderWidth = 0.5f;
            buttonBasket.layer.cornerRadius = 2.f;
            [viewOrder addSubview:buttonBasket];
            
            
        }
        
        
        
        
        
    }
    return self;
}

@end
