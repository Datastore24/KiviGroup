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
#import "UIImage+Resize.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения
#import "CheckDataServer.h"

@interface CatalogView () <UIScrollViewDelegate>
//MainView
@property (strong, nonatomic) UIScrollView * catalogScroll;
@property (strong, nonatomic) NSMutableArray * arrayBorderView;
@property (assign, nonatomic) BOOL isBoll;
@property (strong, nonatomic) NSArray * arrayData;
@property (strong, nonatomic) NSArray * arrayName;
@property (assign, nonatomic) NSInteger pageX;

//ScrollProduct
@property (strong, nonatomic) UIScrollView * mainScrolView;
@property (nonatomic, assign) CGFloat lastContentOffset;
@property (assign, nonatomic) NSInteger numberButton;

@end

@implementation CatalogView

- (instancetype)initWithView: (UIView*) view andData: (NSArray*) data andName:(NSArray*) arrayName
{
    
    
#pragma mark - MainView
    
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height - 64.f);
        self.pageX = 0;
        self.arrayBorderView = [[NSMutableArray alloc] init];
        self.isBoll = NO;
        self.arrayData = data;
        self.arrayName = arrayName;
        self.numberButton = 0;
        
        //Лого
        UIButton * buttonCategory = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonCategory.frame = CGRectMake(10.f, 10.f, self.frame.size.width - 20.f, 40.f);
        buttonCategory.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_400];
        buttonCategory.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_500].CGColor;
        buttonCategory.layer.borderWidth = 1.f;
        buttonCategory.layer.cornerRadius = 3.f;
        [buttonCategory setTitle:@"Каталог товаров" forState:UIControlStateNormal];
        [buttonCategory setTitleColor:[UIColor hx_colorWithHexRGBAString:@"ffffff"] forState:UIControlStateNormal];
        buttonCategory.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        UIImage * image = [UIImage imageNamed:@"bagImage.png"];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(55.f, 8.f, 20.f, 20.f)];
        imageView.image = image;
        [buttonCategory addTarget:self action:@selector(buttonCategoryAction) forControlEvents:UIControlEventTouchUpInside];
        [buttonCategory addSubview:imageView];
        
        
        [self addSubview:buttonCategory];

        
        //Скрол товаров
        self.catalogScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 60.f, self.frame.size.width, 35.f)];
        self.catalogScroll.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_200];
        self.catalogScroll.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.catalogScroll];
        
        //Массив имен для кнопок
       
      
        NSInteger widhtCount = 0;
           
        for (int i = 0; i < self.arrayName.count; i++) {
            UIButton * buttonCategory = [UIButton customButtonSystemWithFrame:CGRectMake(0.f + widhtCount, 0.f, 100.f, 35.f) andColor:nil andAlphaBGColor:0.f andBorderColor:nil andCornerRadius:0.f andTextName:[[self.arrayName objectAtIndex:i] objectForKey:@"title"] andColorText:@"000000" andSizeText:15 andBorderWidht:0.f];
            if (i == 0) {
                buttonCategory.frame = CGRectMake(0.f + widhtCount, 0.f, 50.f, 35.f);
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
        self.mainScrolView.contentSize = CGSizeMake(self.frame.size.width * self.arrayName.count, 0.f);
        

            int j=0;

        
            
            UIScrollView * scrollProduct = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f + self.frame.size.width * j, 0.f , self.mainScrolView.frame.size.width, self.mainScrolView.frame.size.height)];
            scrollProduct.backgroundColor = [UIColor groupTableViewBackgroundColor];
            scrollProduct.showsVerticalScrollIndicator = NO;
            [self.mainScrolView addSubview:scrollProduct];
            __block NSInteger lineProduct = 0; //Идентификатор строк
            __block NSInteger columnProduct = 0; //Идентификатор столбцов
            
            [CheckDataServer checkDataServerWithBlock:self.arrayData andMessage:@"В данной категории нет товаров" view:scrollProduct complitionBlock:^{
                
                
                
                
                
                            for (int i = 0; i < self.arrayData.count; i++) {
                
                
                
                                NSDictionary * dictProduct = [self.arrayData objectAtIndex:i];
                
                              
                
                                UIButton * buttonProduct = [UIButton buttonWithType:UIButtonTypeCustom];
                                buttonProduct.frame = CGRectMake(0.f + ((self.frame.size.width / 2.f + 1.5f) * columnProduct),
                                                                 0.f + ((self.frame.size.width / 2.f + 1.5f) * lineProduct),
                                                                 self.frame.size.width / 2.f - 1.5f,
                                                                 self.frame.size.width / 2.f - 1.5f );
               
                                UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, buttonProduct.frame.size.width, buttonProduct.frame.size.height)];
                                
                                
                                NSURL *imgURL = [NSURL URLWithString:[dictProduct objectForKey:@"img"]];
                                
                                
                                //SingleTone с ресайз изображения
                                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                                [manager downloadImageWithURL:imgURL
                                                      options:0
                                                     progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                         // progression tracking code
                                                     }
                                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                        
                                                        if(image){
                                                           
                                                            
                                                            imageView.contentMode = UIViewContentModeScaleAspectFill; // Растягивает, но режет ноги
                                                            //_viewOne.contentMode = UIViewContentModeScaleAspectFit; // Пропорционально на весь экран
                                                            
                                                            [imageView setClipsToBounds:YES];
                                                            
                                                            
                                                                imageView.contentMode = UIViewContentModeScaleAspectFill;
                                                                imageView.clipsToBounds =YES;
                                                            
                                                            
                                                            
                                                            
                                                            imageView.image = image;
                                                            
                                                            [buttonProduct addSubview:imageView];
                                                            
                                                        }else{
                                                            
                                                        }
                                                    }];
                                
                                
    
                                [scrollProduct addSubview:buttonProduct];
                
                                UILabel * labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(buttonProduct.frame.size.width - 40.f,
                                                                                                 buttonProduct.frame.size.height - 15.f, 40.f, 15.f)];
                                labelPrice.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"000000" alpha:0.4f];
                                labelPrice.text = [NSString  stringWithFormat:@"%@ руб.", [dictProduct objectForKey:@"cost"]];
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

                
            
                }];
            
            scrollProduct.contentSize = CGSizeMake(0, 5 + (self.frame.size.width / 2.f) * lineProduct);
        
    }
    return self;
}


#pragma mark - Action Methos

- (void) buttonCategoryAction: (UIButton*) button {
    
    
    for (int i = 0; i < self.arrayName.count; i++) {
       
        if (button.tag == 10 + i) {
            
            
            
            for (int j = 0; j < self.arrayBorderView.count; j++) {
                [UIView animateWithDuration:0.5f animations:^{
                    self.mainScrolView.contentOffset = CGPointMake(self.frame.size.width * i, 0.f);
                }];
            }
        }
    }
}

- (void) buttonCategoryAction {
    [self.delegate getCatalog:self];
}



#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    self.lastContentOffset = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
        CGFloat pageWidth = CGRectGetWidth(self.bounds);
        CGFloat pageFraction = self.mainScrolView.contentOffset.x / pageWidth;
    NSInteger num = (NSInteger) pageFraction;
    
    if(self.pageX!=num){
        
        for (UIView *view in self.mainScrolView.subviews){
            if([view isKindOfClass:[UIScrollView class]]){
                
                [view removeFromSuperview];
                
            }
        }
        
        
        [self.delegate getApiTabProducts:[[self.arrayName objectAtIndex:num] objectForKey:@"cat"] andPage:@"1" andBlock:^{
            NSArray * productArray =[self.delegate arrayProduct];
            
            int j=(int)num;

            UIScrollView * scrollProduct = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f + self.frame.size.width * j, 0.f , self.mainScrolView.frame.size.width, self.mainScrolView.frame.size.height)];
            scrollProduct.backgroundColor = [UIColor groupTableViewBackgroundColor];
            scrollProduct.showsVerticalScrollIndicator = NO;
            [self.mainScrolView addSubview:scrollProduct];
           __block NSInteger lineProduct = 0; //Идентификатор строк
           __block NSInteger columnProduct = 0; //Идентификатор столбцов
            
            
            [CheckDataServer checkDataServerWithBlock:productArray andMessage:@"В данной категории нет товаров" view:scrollProduct complitionBlock:^{
            
            
            if(productArray.count>0){

                
                for (int i = 0; i < productArray.count; i++) {
                    
                    
                    NSDictionary * dictProduct = [productArray objectAtIndex:i];
                    
                    UIButton * buttonProduct = [UIButton buttonWithType:UIButtonTypeCustom];
                    buttonProduct.frame = CGRectMake(0.f + ((self.frame.size.width / 2.f + 1.5f) * columnProduct),
                                                     0.f + ((self.frame.size.width / 2.f + 1.5f) * lineProduct),
                                                     self.frame.size.width / 2.f - 1.5f,
                                                     self.frame.size.width / 2.f - 1.5f );
                    
                    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, buttonProduct.frame.size.width, buttonProduct.frame.size.height)];
                    
                    
                    NSURL *imgURL = [NSURL URLWithString:[dictProduct objectForKey:@"img"]];
                    
                    
                    //SingleTone с ресайз изображения
                    SDWebImageManager *manager = [SDWebImageManager sharedManager];
                    [manager downloadImageWithURL:imgURL
                                          options:0
                                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                             // progression tracking code
                                         }
                                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                            
                                            if(image){
                                                
                                                
                                                imageView.contentMode = UIViewContentModeScaleAspectFill; // Растягивает, но режет ноги
                                                //_viewOne.contentMode = UIViewContentModeScaleAspectFit; // Пропорционально на весь экран
                                                
                                                [imageView setClipsToBounds:YES];
                                                
                                                
                                                imageView.contentMode = UIViewContentModeScaleAspectFill;
                                                imageView.clipsToBounds =YES;
                                                
                                                
                                                
                                                
                                                imageView.image = image;
                                                
                                                [buttonProduct addSubview:imageView];
                                                
                                            }else{
                                                
                                            }
                                        }];
                    
                    
                    
                    [scrollProduct addSubview:buttonProduct];
                    
                    UILabel * labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(buttonProduct.frame.size.width - 40.f,
                                                                                     buttonProduct.frame.size.height - 15.f, 40.f, 15.f)];
                    labelPrice.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"000000" alpha:0.4f];
                    labelPrice.text = [NSString  stringWithFormat:@"%@ руб.", [dictProduct objectForKey:@"cost"]];
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
                
                
            }
                
            }];
            
            scrollProduct.contentSize = CGSizeMake(0, 5 + (self.frame.size.width / 2.f) * lineProduct);
        }];

        self.pageX=num;
    }
  
    
    for (int j = 0; j < self.arrayBorderView.count; j++) {
       
        
        if (pageFraction <= 1) {
            UIView * viewBorder = [self.arrayBorderView objectAtIndex:j];
            CGRect rect = viewBorder.frame;
            rect.origin.x = 50.f * pageFraction;
            rect.size.width = 50.f + (50.f * pageFraction);
            viewBorder.frame = rect;
            self.catalogScroll.contentOffset = CGPointMake(50.f * pageFraction * 0.6f, 0.f);
            
        } else {
            UIView * viewBorder = [self.arrayBorderView objectAtIndex:j];
            CGRect rect = viewBorder.frame;
            rect.origin.x = 50.f + ((pageFraction - 1.f) * 100.f);
            rect.size.width = 50.f + (50.f * (pageFraction - (pageFraction - 1.f)));
            viewBorder.frame = rect;
            if ((self.frame.size.width * pageFraction) < self.catalogScroll.contentSize.width + 412.f) {
                self.catalogScroll.contentOffset = CGPointMake((50.f * 0.6f) + ((pageFraction - 1.f) * 100.f), 0.f);
            }
        }
    }
}

@end
