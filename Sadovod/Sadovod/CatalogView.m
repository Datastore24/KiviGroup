//
//  CatalogView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 18/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "CatalogView.h"
#import "UIButton+ButtonImage.h"
#import "Macros.h"
#import "HexColors.h"
#import "CustomLabels.h"

@interface CatalogView () <UIScrollViewDelegate>
//MainView
@property (strong, nonatomic) UIScrollView * catalogScroll;
@property (strong, nonatomic) NSMutableArray * arrayBorderView;
@property (assign, nonatomic) BOOL isBoll;
@property (strong, nonatomic) NSArray * arrayData;

//ScrollProduct
@property (strong, nonatomic) UIScrollView * mainScrolView;
@property (nonatomic, assign) CGFloat lastContentOffset;
@property (assign, nonatomic) NSInteger numberButton;

@end

@implementation CatalogView

- (instancetype)initWithView: (UIView*) view andData: (NSArray*) data
{
    
#pragma mark - MainView
    
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height - 64.f);
        
        self.arrayBorderView = [[NSMutableArray alloc] init];
        self.isBoll = NO;
        self.arrayData = data;
        self.numberButton = 0;
        
        //Лого
        UIView * mainViewLogo = [[UIView alloc] initWithFrame:CGRectMake(10.f, 10.f, self.frame.size.width - 20.f, 40.f)];
        mainViewLogo.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_400];
        mainViewLogo.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_500].CGColor;
        mainViewLogo.layer.borderWidth = 1.f;
        mainViewLogo.layer.cornerRadius = 3.f;
        [self addSubview:mainViewLogo];
        //Текст лого
        CustomLabels * labelLogo = [[CustomLabels alloc] initLabelWithWidht:100.f andHeight:12.f andColor:@"ffffff" andText:@"Каталог товаров" andTextSize:15 andLineSpacing:0.f fontName:VM_FONT_REGULAR];
        [mainViewLogo addSubview:labelLogo];
        //Картинка
        UIImageView * bagImage = [[UIImageView alloc] initWithFrame:CGRectMake(75.f, 10.f, 15.f, 15.f)];
        bagImage.image = [UIImage imageNamed:@"bagImage.png"];
        [mainViewLogo addSubview:bagImage];
        
        //Скрол товаров
        self.catalogScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 60.f, self.frame.size.width, 35.f)];
        self.catalogScroll.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_200];
        self.catalogScroll.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.catalogScroll];
        
        //Массив имен для кнопок
        NSArray * arrayName = [NSArray arrayWithObjects:@"Все", @"Женщинам", @"Мужчинам", @"Девочкам", @"Мальчикам", nil];
        NSInteger widhtCount = 0;
        
        for (int i = 0; i < arrayName.count; i++) {
            UIButton * buttonCategory = [UIButton customButtonSystemWithFrame:CGRectMake(0.f + widhtCount, 0.f, 100.f, 35.f) andColor:nil andAlphaBGColor:0.f andBorderColor:nil andCornerRadius:0.f andTextName:[arrayName objectAtIndex:i] andColorText:@"000000" andSizeText:15 andBorderWidht:0.f];
            if (i == 0) {
                buttonCategory.frame = CGRectMake(0.f, 0.f, 50.f, 35.f);
                buttonCategory.userInteractionEnabled = NO;
            }
            buttonCategory.tag = 10 + i;
            [buttonCategory addTarget:self action:@selector(buttonCategoryAction:) forControlEvents:UIControlEventTouchUpInside];
            widhtCount += buttonCategory.frame.size.width;
            [self.catalogScroll addSubview:buttonCategory];
        }
        self.catalogScroll.contentSize = CGSizeMake(widhtCount, 0.f);
        
        //Создаем два вью выделителя
        UIView * borderViewUp = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 50.f, 2.f)];
        borderViewUp.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
        [self.catalogScroll addSubview:borderViewUp];
        [self.arrayBorderView addObject:borderViewUp];
        UIView * borderViewDown = [[UIView alloc] initWithFrame:CGRectMake(0.f, 33.f, 50.f, 2.f)];
        borderViewDown.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
        [self.catalogScroll addSubview:borderViewDown];
        [self.arrayBorderView addObject:borderViewDown];
        
        
#pragma mark - ScrollProduct
        
        self.mainScrolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 95.f, self.frame.size.width, self.frame.size.height - 95.f)];
        self.mainScrolView.delegate = self;
        [self.mainScrolView setPagingEnabled:YES];
        self.mainScrolView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.mainScrolView];
        self.mainScrolView.contentSize = CGSizeMake(self.frame.size.width * arrayName.count, 0.f);

        for (int j = 0; j < arrayName.count; j++) {

            
            
            UIScrollView * scrollProduct = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f + self.frame.size.width * j, 0.f , self.mainScrolView.frame.size.width, self.mainScrolView.frame.size.height)];
            scrollProduct.backgroundColor = [UIColor groupTableViewBackgroundColor];
            scrollProduct.showsVerticalScrollIndicator = NO;
            [self.mainScrolView addSubview:scrollProduct];
            NSInteger lineProduct = 0; //Идентификатор строк
            NSInteger columnProduct = 0; //Идентификатор столбцов
            for (int i = 0; i < self.arrayData.count; i++) {
                
                NSDictionary * dictProduct = [self.arrayData objectAtIndex:i];
                
                UIButton * buttonProduct = [UIButton buttonWithType:UIButtonTypeCustom];
                buttonProduct.frame = CGRectMake(0.f + ((self.frame.size.width / 2.f + 1.5f) * columnProduct),
                                                 0.f + ((self.frame.size.width / 2.f + 1.5f) * lineProduct),
                                                 self.frame.size.width / 2.f - 1.5f,
                                                 self.frame.size.width / 2.f - 1.5f );
                UIImage * imageProduct = [UIImage imageNamed:[dictProduct objectForKey:@"image"]];
                [buttonProduct setImage:imageProduct forState:UIControlStateNormal];
                [scrollProduct addSubview:buttonProduct];
                
                UILabel * labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(buttonProduct.frame.size.width - 40.f,
                                                                                 buttonProduct.frame.size.height - 15.f, 40.f, 15.f)];
                labelPrice.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"000000" alpha:0.4f];
                labelPrice.text = [NSString  stringWithFormat:@"%@ руб.", [dictProduct objectForKey:@"price"]];
                labelPrice.textColor = [UIColor whiteColor];
                labelPrice.textAlignment = NSTextAlignmentCenter;
                labelPrice.font = [UIFont fontWithName:VM_FONT_REGULAR size:9];
                [buttonProduct addSubview:labelPrice];
                
                
                //Расчет таблицы---------------
                columnProduct += 1;
                if (columnProduct > 1) {
                    columnProduct = 0;
                    lineProduct += 1;
                    
                }
            }
            scrollProduct.contentSize = CGSizeMake(0, 5 + (self.frame.size.width / 2.f) * lineProduct);
        }
    }
    return self;
}


#pragma mark - Action Methos

- (void) buttonCategoryAction: (UIButton*) button {
    for (int i = 0; i < 5; i++) {
        UIButton * otherButton = (UIButton*)[self viewWithTag:10 + i];
        if (button.tag == 10 + i) {
            button.userInteractionEnabled = NO;
            
            for (int j = 0; j < self.arrayBorderView.count; j++) {
                [UIView animateWithDuration:0.5f animations:^{
                    self.mainScrolView.contentOffset = CGPointMake(self.frame.size.width * i, 0);
                }];
                

            }
        } else {
            otherButton.userInteractionEnabled = YES;
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    self.lastContentOffset = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
        CGFloat pageWidth = CGRectGetWidth(self.bounds);
        CGFloat pageFraction = self.mainScrolView.contentOffset.x / pageWidth;
    
    for (int j = 0; j < self.arrayBorderView.count; j++) {
        
        if (pageFraction <= 1) {
            UIView * viewBorder = [self.arrayBorderView objectAtIndex:j];
            CGRect rect = viewBorder.frame;
            rect.origin.x = 50 * pageFraction;
            rect.size.width = 50 + (50 * pageFraction);
            viewBorder.frame = rect;
            self.catalogScroll.contentOffset = CGPointMake(50 * pageFraction * 0.6, 0);
            
        } else {
            UIView * viewBorder = [self.arrayBorderView objectAtIndex:j];
            CGRect rect = viewBorder.frame;
            rect.origin.x = 50 + ((pageFraction - 1) * 100);
            viewBorder.frame = rect;
            if ((self.frame.size.width * pageFraction) < self.catalogScroll.contentSize.width + 199) {
                self.catalogScroll.contentOffset = CGPointMake((50 * 0.6) + ((pageFraction - 1) * 100), 0);
            }
        }
    }

}

@end
