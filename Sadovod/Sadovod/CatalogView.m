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
#import "SingleTone.h"
#import "CustomButton.h"
#import "UIView+BorderView.h"


@interface CatalogView () <UIScrollViewDelegate>
//MainView
@property (strong, nonatomic) UIScrollView * catalogScroll;
@property (strong, nonatomic) NSMutableArray * arrayBorderView;
@property (assign, nonatomic) BOOL isBoll;
@property (strong, nonatomic) NSArray * arrayData;
@property (strong, nonatomic) NSArray * arrayName;
@property (assign, nonatomic) NSInteger pageX;
@property (strong, nonatomic) NSString * countPage;
@property (assign, nonatomic) BOOL isLoadMore;

//ScrollProduct
@property (strong, nonatomic) UIScrollView * mainScrolView;
//@property (strong, nonatomic) UIScrollView * productScrollView;
@property (nonatomic, assign) CGFloat lastContentOffset;
@property (assign, nonatomic) NSInteger numberButton;
@property (strong, nonatomic) UIActivityIndicatorView * spinner;

//PhoneView
@property (strong, nonatomic) UIView * viewPhone;

@property (assign, nonatomic) NSInteger lineProduct;
@property (assign, nonatomic) NSInteger columnProduct;

@end

@implementation CatalogView

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithView: (UIView*) view andData: (NSArray*) data andName:(NSArray*) arrayName
{
    
    
#pragma mark - MainView
    
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height - 64.f);
        self.pageX = 0;
        self.arrayBorderView = [[NSMutableArray alloc] init];
        self.isBoll = NO;
        self.isLoadMore = NO;
        self.arrayData = data;
        self.arrayName = arrayName;
        self.numberButton = 0;
        self.countPage=@"1";
        
        
        self.lineProduct = 0; //Идентификатор строк
        self.columnProduct = 0; //Идентификатор столбцов

        
     
        
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
        

//            int j=0;
        //Реализация скролов
        
        for (int j = 0; j < self.arrayName.count; j++) {
            UIScrollView * productScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f + self.frame.size.width * j, 0.f , self.mainScrolView.frame.size.width, self.mainScrolView.frame.size.height)];
            productScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            productScrollView.showsVerticalScrollIndicator = NO;
//            productScrollView.delegate = self;

            
            
            [self.mainScrolView addSubview:productScrollView];
            
            
            
            [CheckDataServer checkDataServerWithBlock:self.arrayData andMessage:@"В данной категории нет товаров" view:productScrollView complitionBlock:^{
            
                
                
                
                
                for (int i = 0; i < self.arrayData.count; i++) {
                    
                    
                    
                    NSDictionary * dictProduct = [self.arrayData objectAtIndex:i];
                    
                    
                    
                    CustomButton * buttonProduct = [CustomButton buttonWithType:UIButtonTypeCustom];
                    buttonProduct.frame = CGRectMake(0.f + ((self.frame.size.width / 2.f + 1.5f) * self.columnProduct),
                                                     0.f + ((self.frame.size.width / 2.f + 1.5f) * self.lineProduct),
                                                     self.frame.size.width / 2.f - 1.5f,
                                                     self.frame.size.width / 2.f - 1.5f );
                    buttonProduct.backgroundColor = [UIColor whiteColor];
                    buttonProduct.customID = [dictProduct objectForKey:@"id"];
                    buttonProduct.customName = [dictProduct objectForKey:@"name"];
                    buttonProduct.customValueTwo =[dictProduct objectForKey:@"cost"];
                    buttonProduct.tag = 30 + i;
                    [buttonProduct addTarget:self action:@selector(buttonProductAction:) forControlEvents:UIControlEventTouchUpInside];
                    
                    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, buttonProduct.frame.size.width, buttonProduct.frame.size.height)];
                    imageView.backgroundColor = [UIColor whiteColor];
                    
                    
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
                                                
                                                
                                                
                                                [imageView setClipsToBounds:YES];
                                                
                                                
                                                imageView.contentMode = UIViewContentModeScaleAspectFit;
                                                imageView.clipsToBounds =YES;
                                                
                                                
                                                
                                                
                                                imageView.image = image;
                                                
                                                [buttonProduct addSubview:imageView];
                                                
                                                [productScrollView addSubview:buttonProduct];
                                                self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                                                
                                                [productScrollView addSubview:self.spinner];
                                                
                                                UILabel * labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(buttonProduct.frame.size.width - 40.f,
                                                                                                                 buttonProduct.frame.size.height - 15.f, 40.f, 15.f)];
                                                labelPrice.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"000000" alpha:0.4f];
                                                labelPrice.text = [NSString  stringWithFormat:@"%@ руб.", [dictProduct objectForKey:@"cost"]];
                                                labelPrice.textColor = [UIColor whiteColor];
                                                labelPrice.textAlignment = NSTextAlignmentCenter;
                                                labelPrice.font = [UIFont fontWithName:VM_FONT_REGULAR size:9];
                                                if (isiPhone6 || isiPhone6Plus) {
                                                    labelPrice.frame = CGRectMake(buttonProduct.frame.size.width - 50.f,
                                                                                  buttonProduct.frame.size.height - 20.f, 50.f, 20.f);
                                                    labelPrice.font = [UIFont fontWithName:VM_FONT_REGULAR size:11];
                                                }
                                                [buttonProduct addSubview:labelPrice];
                                                
                                                UILabel * statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 30, 15)];
                                                if (isiPhone6 || isiPhone6Plus) {
                                                    statusLabel.frame = CGRectMake(0.f, 0.f, 38, 20);
                                                    statusLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:11];
                                                }
                                                //Случайный выбор параметра-----------
                                                NSString * stringStatus;
                                                if([[dictProduct objectForKey:@"mark"] integerValue] ==1)
                                                {
                                                    stringStatus = @"NEW";
                                                    statusLabel.textColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
                                                    statusLabel.backgroundColor = [UIColor clearColor];
                                                }else if([[dictProduct objectForKey:@"mark"] integerValue] ==2){
                                                    stringStatus = @"OLD";
                                                    statusLabel.backgroundColor = [UIColor lightGrayColor];
                                                    statusLabel.textColor = [UIColor whiteColor];
                                                    
                                                }else if([[dictProduct objectForKey:@"mark"] integerValue] ==0){
                                                    statusLabel.alpha = 0.f;
                                                }
                                                
                                                
                                                statusLabel.text = stringStatus;
                                                statusLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:9];
                                                statusLabel.textAlignment = NSTextAlignmentCenter;
                                                [buttonProduct addSubview:statusLabel];
                                                
                                                
                                                
                                            }else{
                                                
                                            }
                                        }];
                    //Расчет таблицы---------------
                    if (i < self.arrayData.count - 1) {
                        self.columnProduct += 1;
                        if (self.columnProduct > 1) {
                            self.columnProduct = 0;
                            self.lineProduct += 1;
                            
                        }
                    }
                }
                
                self.columnProduct = 0;
                self.lineProduct = 0;
                
            }];
            
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 200, 40)];
            label.text = @"Привет";

        
            
            
            productScrollView.contentSize = CGSizeMake(0, 20 + (self.frame.size.width / 2.f) * (self.lineProduct + 1));
        }

        
        

      
        
    }
    
    
    
    self.viewPhone = [self createPhoneView];
    if (![[SingleTone sharedManager] boolPhone]) {
        self.viewPhone.alpha = 0.f;
    } else {
       self.viewPhone.alpha = 1.f;
    }
    
 
    
    [self addSubview:self.viewPhone];
   
    
    
    return self;
}

#pragma mark - PhoneView

- (UIView*) createPhoneView {
    UIView * fonView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
    fonView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"000000" alpha:0.6];
    
    UIView * whiteView = [[UIView alloc] initWithFrame:CGRectMake(10.f, self.frame.size.height / 2 - 100, self.frame.size.width - 20.f, 180)];
    whiteView.layer.cornerRadius = 5.f;
    whiteView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [fonView addSubview:whiteView];
    
    UIView * phoneView = [[UIView alloc] initWithFrame:CGRectMake(10.f, 5, whiteView.frame.size.width - 20, whiteView.frame.size.height - 10)];
    phoneView.backgroundColor = [UIColor whiteColor];
    phoneView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    phoneView.layer.borderWidth = 0.5f;
    phoneView.layer.cornerRadius = 5.f;
    phoneView.clipsToBounds = NO;
    phoneView.layer.shadowColor = [[UIColor blackColor] CGColor];
    phoneView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    phoneView.layer.shadowRadius = 2.0f;
    phoneView.layer.shadowOpacity = 0.5f;
    [whiteView addSubview:phoneView];
    
    CustomLabels * labelTipe = [[CustomLabels alloc] initLabelWithWidht:20.f andHeight:20 andColor:VM_COLOR_800 andText:@"Номер телефона" andTextSize:20 andLineSpacing:0.f fontName:VM_FONT_BOLD];
    [phoneView addSubview:labelTipe];
    
    [UIView borderViewWithHeight:60 andWight:0.f andView:phoneView andColor:VM_COLOR_800 andHieghtBorder:2.f];
    
    CustomLabels * labelPhone = [[CustomLabels alloc] initLabelWithWidht:20.f andHeight:80 andColor:@"000000" andText:@"+74957687838" andTextSize:20 andLineSpacing:0.f fontName:VM_FONT_BOLD];
    [phoneView addSubview:labelPhone];
    
    NSArray * arrayName = [NSArray arrayWithObjects:@"Закрыть", @"Позвонить", nil];
    for (int i = 0; i < 2; i++) {
        UIButton * buttonPhone = [UIButton buttonWithType:UIButtonTypeSystem];
        if (i == 0) {
            buttonPhone.frame = CGRectMake(0, 120, 100, 50.);
            if (isiPhone6) {
                 buttonPhone.frame = CGRectMake(0, 120, 130, 50.);
            } else if (isiPhone6Plus) {
                buttonPhone.frame = CGRectMake(0, 120, 150, 50.);
            }
        } else {
            buttonPhone.frame = CGRectMake(99, 120, 181, 50.);
            if (isiPhone6) {
                buttonPhone.frame = CGRectMake(129, 120, 206, 50.);
            } else if (isiPhone6Plus) {
                buttonPhone.frame = CGRectMake(149, 120, 225, 50.);
        }
        }
        buttonPhone.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        buttonPhone.layer.borderWidth = 1.f;
        [buttonPhone setTitle:[arrayName objectAtIndex:i] forState:UIControlStateNormal];
        [buttonPhone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        buttonPhone.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        buttonPhone.tag = 1300 + i;
        [buttonPhone addTarget:self action:@selector(buttonPhoneAction:) forControlEvents:UIControlEventTouchUpInside];
        [phoneView addSubview:buttonPhone];
    }
    
    
    return fonView;
}


#pragma mark - Action Methos

- (void) buttonPhoneAction: (UIButton*) button {
    if (button.tag == 1300) {
        [UIView animateWithDuration:0.3 animations:^{
            self.viewPhone.alpha = 0.f;
        }];
    } else {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:+74957687838"]];
        
    }
}

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

- (void) buttonProductAction: (CustomButton*) button {
    for (int i = 0; i < self.arrayData.count; i++) {
        if (button.tag == 30 + i) {
            
            [self.delegate pushToBuyView:self andProductID:button.customID andProductPrice:button.customValueTwo andProductName:button.customName];
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
        NSInteger num = (NSInteger) pageFraction;
    
    for (int j = 0; j <  self.arrayBorderView.count; j++) {
        
        
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
            if (isiPhone5) {
                if ((self.frame.size.width * pageFraction) < self.catalogScroll.contentSize.width + 1082.f) {
                    self.catalogScroll.contentOffset = CGPointMake((50.f * 0.6f) + ((pageFraction - 1.f) * 100.f), 0.f);
                }
            } else if (isiPhone6 || isiPhone6Plus) {
                if ((self.frame.size.width * pageFraction) < self.catalogScroll.contentSize.width + 1210.f) {
                    self.catalogScroll.contentOffset = CGPointMake((50.f * 0.6f) + ((pageFraction - 1.f) * 100.f), 0.f);
                }
            }
            
        }
    }
    
//    if(self.pageX!=num){
//      
//        self.columnProduct=0;
//        self.lineProduct=0;
//        self.countPage=0;
//        for (UIView *view in self.mainScrolView.subviews){
//            if([view isKindOfClass:[UIScrollView class]]){
//                
//                [view removeFromSuperview];
//                
//            }
//        }
    
        
//        [self.delegate getApiTabProducts:[[self.arrayName objectAtIndex:num] objectForKey:@"cat"] andPage:self.countPage andBlock:^{
//            NSArray * productArray =[self.delegate arrayProduct];
//            
//            int j=(int)num;
//
////            self.productScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f + self.frame.size.width * j, 0.f , self.mainScrolView.frame.size.width, self.mainScrolView.frame.size.height)];
////            self.productScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
////            self.productScrollView.showsVerticalScrollIndicator = NO;
////            self.productScrollView.delegate=self;
////            
////            [self.mainScrolView addSubview:self.productScrollView];
//            
//          
//            
//            
//            [CheckDataServer checkDataServerWithBlock:productArray andMessage:@"В данной категории нет товаров" view:self.productScrollView complitionBlock:^{
//            
//            
//            if(productArray.count>0){
//
//                
//                for (int i = 0; i < productArray.count; i++) {
//                    
//                    
//                    NSDictionary * dictProduct = [productArray objectAtIndex:i];
//                    
//                    CustomButton * buttonProduct = [CustomButton buttonWithType:UIButtonTypeCustom];
//                    buttonProduct.frame = CGRectMake(0.f + ((self.frame.size.width / 2.f + 1.5f) * self.columnProduct),
//                                                     0.f + ((self.frame.size.width / 2.f + 1.5f) * self.lineProduct),
//                                                     self.frame.size.width / 2.f - 1.5f,
//                                                     self.frame.size.width / 2.f - 1.5f );
//                    buttonProduct.backgroundColor =[UIColor whiteColor];
//                    buttonProduct.customID = [dictProduct objectForKey:@"id"];
//                    buttonProduct.customName = [dictProduct objectForKey:@"name"];
//                    buttonProduct.customValueTwo =[dictProduct objectForKey:@"cost"];
//                    buttonProduct.tag = 30+i;
//                    [buttonProduct addTarget:self action:@selector(buttonProductAction:) forControlEvents:UIControlEventTouchUpInside];
//                    
//                    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, buttonProduct.frame.size.width, buttonProduct.frame.size.height)];
//                    
//                    
//                    NSURL *imgURL = [NSURL URLWithString:[dictProduct objectForKey:@"img"]];
//                    
//                    
//                    //SingleTone с ресайз изображения
//                    SDWebImageManager *manager = [SDWebImageManager sharedManager];
//                    [manager downloadImageWithURL:imgURL
//                                          options:0
//                                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                                             // progression tracking code
//                                         }
//                                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                                            
//                                            if(image){
//                                                [imageView setClipsToBounds:YES];
//                                                imageView.contentMode = UIViewContentModeScaleAspectFit;
//                                                imageView.clipsToBounds =YES;
//                                                imageView.image = image;
//                                                [buttonProduct addSubview:imageView];
//                                                
//                                                [self.productScrollView addSubview:buttonProduct];
//                                                self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//                                                
//                                                [self.productScrollView addSubview:self.spinner];
//                                                
//                                                UILabel * labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(buttonProduct.frame.size.width - 40.f,
//                                                                                                                 buttonProduct.frame.size.height - 15.f, 40.f, 15.f)];
//                                                labelPrice.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"000000" alpha:0.4f];
//                                                labelPrice.text = [NSString  stringWithFormat:@"%@ руб.", [dictProduct objectForKey:@"cost"]];
//                                                labelPrice.textColor = [UIColor whiteColor];
//                                                labelPrice.textAlignment = NSTextAlignmentCenter;
//                                                labelPrice.font = [UIFont fontWithName:VM_FONT_REGULAR size:9];
//                                                if (isiPhone6 || isiPhone6Plus) {
//                                                    labelPrice.frame = CGRectMake(buttonProduct.frame.size.width - 50.f,
//                                                                                  buttonProduct.frame.size.height - 20.f, 50.f, 20.f);
//                                                    labelPrice.font = [UIFont fontWithName:VM_FONT_REGULAR size:11];
//                                                }
//                                                [buttonProduct addSubview:labelPrice];
//                                                
//                                                UILabel * statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 30, 15)];
//                                                if (isiPhone6 || isiPhone6Plus) {
//                                                    statusLabel.frame = CGRectMake(0.f, 0.f, 38, 20);
//                                                    statusLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:11];
//                                                }
//                                                //Случайный выбор параметра-----------
//                                                NSString * stringStatus;
//                                                if (arc4random() % 2) {
//                                                    stringStatus = @"NEW";
//                                                    statusLabel.textColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
//                                                    statusLabel.backgroundColor = [UIColor clearColor];
//                                                    
//                                                } else {
//                                                    stringStatus = @"OLD";
//                                                    statusLabel.backgroundColor = [UIColor lightGrayColor];
//                                                    statusLabel.textColor = [UIColor whiteColor];
//                                                }
//                                                statusLabel.text = stringStatus;
//                                                statusLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:9];
//                                                statusLabel.textAlignment = NSTextAlignmentCenter;
//                                                [buttonProduct addSubview:statusLabel];
//                                                
//                                            }else{
//                                                
//                                            }
//                                        }];
//                    
//                    
//                   
//                    
//                    //Расчет таблицы---------------
//                    if (i < productArray.count - 1) {
//                        self.columnProduct += 1;
//                        if (self.columnProduct > 1) {
//                            self.columnProduct = 0;
//                            self.lineProduct += 1;
//                            
//                        }
//                    }
//                    }
//                }
//            }];
//                
//                self.productScrollView.contentSize = CGSizeMake(0, 20 + (self.frame.size.width / 2.f) * (self.lineProduct + 1));
//
//        }];

//        self.pageX=num;
//    }else if(self.pageX==num){
//        // Get the current size of the refresh controller
//        CGRect refreshBounds = self.productScrollView.bounds;
//        
//        // Distance the table has been pulled >= 0
//        CGFloat pullDistance = MAX(0.0, -self.productScrollView.frame.origin.y);
//        
//        
//        
//        
//        // Set the encompassing view's frames
//        refreshBounds.size.height = pullDistance;
//        
//        
//        
//        CGPoint offset = self.productScrollView.contentOffset; // текущее положение
//        CGRect bounds = self.productScrollView.bounds; // контент на экране
//        CGSize size = self.productScrollView.contentSize; //весь контент
//        UIEdgeInsets inset = self.productScrollView.contentInset; //положение на экране верх и низ
//        float y = offset.y + bounds.size.height - inset.bottom; //высота текущего положения
//        float h = size.height; // высота всего
//        
//        float reload_distance = 10; // Дистанция, которая срабатывает для дозагрузки
//        
//        NSLog(@"position y %f h %f",y,h);
//        
//        if((y > h + reload_distance) && !self.isLoadMore) {
//            
//            self.spinner.frame = CGRectMake(self.productScrollView.frame.size.width/2-10, h + reload_distance/2-54, 24, 24);
//            
//            [self.spinner startAnimating];
//            
//            
//            NSLog(@"load more rows h %f",h);
//            [self loadMore];
//            
//            
//        }
//    }
  
    
  
    
    
    
}

//-(void) loadMore{
// 
//    
//    [self.spinner stopAnimating];
//    self.isLoadMore=YES;
//    NSInteger newIntCountPage = [self.countPage integerValue]+1;
//    NSString * newStrCountPage = [NSString stringWithFormat:@"%ld",(long)newIntCountPage];
//    self.countPage =newStrCountPage;
//   
//    NSLog(@"COUNT %@",self.countPage);
//    
//    CGFloat pageWidth = CGRectGetWidth(self.bounds);
//    CGFloat pageFraction = self.mainScrolView.contentOffset.x / pageWidth;
//    NSInteger num = (NSInteger) pageFraction;
//    
//
//        
//        
//        [self.delegate getApiTabProducts:[[self.arrayName objectAtIndex:num] objectForKey:@"cat"] andPage:newStrCountPage andBlock:^{
//            NSArray * productArray =[self.delegate arrayProduct];
//            
//            NSLog(@"COLUM %ld LINE %ld",(long)self.columnProduct,(long)self.lineProduct);
//                self.columnProduct += 1;
//                if (self.columnProduct > 1) {
//                    self.columnProduct = 0;
//                    self.lineProduct += 1;
//                    
//                }
//            
//            
//            
//            [CheckDataServer checkDataServerWithBlock:productArray andMessage:@"В данной категории нет товаров" view:self.productScrollView complitionBlock:^{
//                
//                
//                if(productArray.count>0){
//                    
//                    
//                    for (int i = 0; i < productArray.count; i++) {
//                        
//                        
//                        NSDictionary * dictProduct = [productArray objectAtIndex:i];
//                        
//                        CustomButton * buttonProduct = [CustomButton buttonWithType:UIButtonTypeCustom];
//                        buttonProduct.frame = CGRectMake(0.f + ((self.frame.size.width / 2.f + 1.5f) * self.columnProduct),
//                                                         0.f + ((self.frame.size.width / 2.f + 1.5f) * self.lineProduct),
//                                                         self.frame.size.width / 2.f - 1.5f,
//                                                         self.frame.size.width / 2.f - 1.5f );
//                        buttonProduct.backgroundColor =[UIColor whiteColor];
//                        buttonProduct.customID = [dictProduct objectForKey:@"id"];
//                        buttonProduct.customName = [dictProduct objectForKey:@"name"];
//                        buttonProduct.customValueTwo =[dictProduct objectForKey:@"cost"];
//                        buttonProduct.tag = 30+i;
//                        [buttonProduct addTarget:self action:@selector(buttonProductAction:) forControlEvents:UIControlEventTouchUpInside];
//                        
//                        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, buttonProduct.frame.size.width, buttonProduct.frame.size.height)];
//                        
//                        
//                        NSURL *imgURL = [NSURL URLWithString:[dictProduct objectForKey:@"img"]];
//                        
//                        
//                        //SingleTone с ресайз изображения
//                        SDWebImageManager *manager = [SDWebImageManager sharedManager];
//                        [manager downloadImageWithURL:imgURL
//                                              options:0
//                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                                                 // progression tracking code
//                                             }
//                                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                                                
//                                                if(image){
//                                                    [imageView setClipsToBounds:YES];
//                                                    imageView.contentMode = UIViewContentModeScaleAspectFit;
//                                                    imageView.clipsToBounds =YES;
//                                                    imageView.image = image;
//                                                    [buttonProduct addSubview:imageView];
//                                                    
//                                                    [self.productScrollView addSubview:buttonProduct];
//                                                    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//                                                    
//                                                    [self.productScrollView addSubview:self.spinner];
//                                                    
//                                                    UILabel * labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(buttonProduct.frame.size.width - 40.f,
//                                                                                                                     buttonProduct.frame.size.height - 15.f, 40.f, 15.f)];
//                                                    labelPrice.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"000000" alpha:0.4f];
//                                                    labelPrice.text = [NSString  stringWithFormat:@"%@ руб.", [dictProduct objectForKey:@"cost"]];
//                                                    labelPrice.textColor = [UIColor whiteColor];
//                                                    labelPrice.textAlignment = NSTextAlignmentCenter;
//                                                    labelPrice.font = [UIFont fontWithName:VM_FONT_REGULAR size:9];
//                                                    if (isiPhone6 || isiPhone6Plus) {
//                                                        labelPrice.frame = CGRectMake(buttonProduct.frame.size.width - 50.f,
//                                                                                      buttonProduct.frame.size.height - 20.f, 50.f, 20.f);
//                                                        labelPrice.font = [UIFont fontWithName:VM_FONT_REGULAR size:11];
//                                                    }
//                                                    [buttonProduct addSubview:labelPrice];
//                                                    
//                                                    UILabel * statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 30, 15)];
//                                                    if (isiPhone6 || isiPhone6Plus) {
//                                                        statusLabel.frame = CGRectMake(0.f, 0.f, 38, 20);
//                                                        statusLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:11];
//                                                    }
//                                                    //Случайный выбор параметра-----------
//                                                    NSString * stringStatus;
//                                                    if (arc4random() % 2) {
//                                                        stringStatus = @"NEW";
//                                                        statusLabel.textColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
//                                                        statusLabel.backgroundColor = [UIColor clearColor];
//                                                        
//                                                    } else {
//                                                        stringStatus = @"OLD";
//                                                        statusLabel.backgroundColor = [UIColor lightGrayColor];
//                                                        statusLabel.textColor = [UIColor whiteColor];
//                                                    }
//                                                    statusLabel.text = stringStatus;
//                                                    statusLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:9];
//                                                    statusLabel.textAlignment = NSTextAlignmentCenter;
//                                                    [buttonProduct addSubview:statusLabel];
//                                                    
//                                                }else{
//                                                    
//                                                }
//                                            }];
//                        
//                        
//                        
//                        
//                        //Расчет таблицы---------------
//                        if (i < productArray.count - 1) {
//                            self.columnProduct += 1;
//                            if (self.columnProduct > 1) {
//                                self.columnProduct = 0;
//                                self.lineProduct += 1;
//                                
//                            }
//                        }
//                    }
//                }
//            }];
//            
//            self.productScrollView.contentSize = CGSizeMake(0, 20 + (self.frame.size.width / 2.f) * (self.lineProduct + 1)+64);
//            self.isLoadMore=NO;
//            
//        }];
//        
//    
//    
//    
//   
//    
//    
//}




#pragma mark - SCROLL DELEGATE

@end
