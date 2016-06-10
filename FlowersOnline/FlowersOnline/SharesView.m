//
//  SharesView.m
//  FlowersOnline
//
//  Created by Виктор Мишустин on 10.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "SharesView.h"
#import "CustomLabels.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@implementation SharesView
{
    UIScrollView * mainScrollView;
    NSInteger countShares;
}

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 64, view.frame.size.width, view.frame.size.height - 64);
        
        //Создаем два тестовых массива изображения и заголовки--------------------------
        NSArray * arrayNames = [NSArray arrayWithObjects:
                                @"Букет 1", @"Букет 2", @"Букет 3",
                                @"Букет 4", @"Букет 5", @"Букет 6",
                                @"Букет 1", @"Букет 2", @"Букет 3",
                                @"Букет 4", @"Букет 5", @"Букет 6", nil];
        NSArray * arrayImages = [NSArray arrayWithObjects:
                                 @"bouquets1.png", @"bouquets2.png", @"bouquets3.png",
                                 @"bouquets4.png", @"bouquets5.png", @"bouquets6.png",
                                 @"bouquets1.png", @"bouquets2.png", @"bouquets3.png",
                                 @"bouquets4.png", @"bouquets5.png", @"bouquets6.png", nil];
        
        countShares = 0;
        
        //Лейбл Заголовка-----------------
        CustomLabels * labelTitle = [[CustomLabels alloc] initLabelTableWithWidht:20 andHeight:20 andSizeWidht:self.frame.size.width - 40 andSizeHeight:40 andColor:COLORTEXTGRAY andText:@"Для товаров в этой категории действуют специальные скидки"];
        labelTitle.numberOfLines = 0;
        labelTitle.font = [UIFont fontWithName:FONTREGULAR size:13];
        labelTitle.textAlignment = NSTextAlignmentLeft;
        [self addSubview:labelTitle];
        
        //Создаем скролл вью акций--------
        mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, self.frame.size.width, self.frame.size.height - 70)];
        mainScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:mainScrollView];
        
        //Создаем акции------------------
        for (int i = 0; i < arrayNames.count; i++) {
            if (i % 2 == 0) {
                UIImageView * imageViewShares = [[UIImageView alloc] initWithFrame:CGRectMake(70, 50 + 150 * countShares, 100, 100)];
                if (isiPhone5 || isiPhone4s) {
                    imageViewShares.frame = CGRectMake(40, 50 + 150 * countShares, 100, 100);
                }
                imageViewShares.image = [UIImage imageNamed:[arrayImages objectAtIndex:i]];
                [mainScrollView addSubview:imageViewShares];
                
                CustomLabels * labelShares = [[CustomLabels alloc] initLabelTableWithWidht:70 andHeight:150 + 150 * countShares andSizeWidht:100 andSizeHeight:20 andColor:COLORTEXTGRAY andText:[arrayNames objectAtIndex:i]];
                if (isiPhone5 || isiPhone4s) {
                    labelShares.frame = CGRectMake(40, 150 + 150 * countShares, 100, 20);
                }
                labelShares.font = [UIFont fontWithName:FONTREGULAR size:13];
                [mainScrollView addSubview:labelShares];
                
                
            } else {
                UIImageView * imageViewShares = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 170, 50 + 150 * countShares, 100, 100)];
                if (isiPhone5 || isiPhone4s) {
                    imageViewShares.frame = CGRectMake(self.frame.size.width - 140, 50 + 150 * countShares, 100, 100);
                }
                imageViewShares.image = [UIImage imageNamed:[arrayImages objectAtIndex:i]];
                [mainScrollView addSubview:imageViewShares];
                
                CustomLabels * labelShares = [[CustomLabels alloc] initLabelTableWithWidht:self.frame.size.width - 170 andHeight:150 + 150 * countShares andSizeWidht:100 andSizeHeight:20 andColor:COLORTEXTGRAY andText:[arrayNames objectAtIndex:i]];
                if (isiPhone5 || isiPhone4s) {
                    labelShares.frame = CGRectMake(self.frame.size.width - 140, 150 + 150 * countShares, 100, 20);
                }
                labelShares.font = [UIFont fontWithName:FONTREGULAR size:13];
                [mainScrollView addSubview:labelShares];
                countShares += 1;
            }
        }
        
        mainScrollView.contentSize = CGSizeMake(0, 150 * countShares + 40);

    }
    return self;
}

@end
