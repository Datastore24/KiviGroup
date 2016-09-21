//
//  CatalogDetailView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 19/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "CatalogDetailView.h"
#import "UIView+BorderView.h"
#import "HexColors.h"
#import "Macros.h"
#import "UIButton+ButtonImage.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения
#import "CheckDataServer.h"
#import "FilterDbClass.h"
#import "Filter.h"
#import "CustomButton.h"

@interface CatalogDetailView ()

@property (strong, nonatomic) UIView * hideView;
@property (strong, nonatomic) UIButton * buttonSort;
@property (strong, nonatomic) UIButton * buttonColumnOne;
@property (strong, nonatomic) UIButton * buttonColumnTwo;
@property (strong, nonatomic) UIButton * buttonFilter;
@property (strong, nonatomic) NSArray * arrayData;
@property (strong, nonatomic) NSDictionary * dictFilter;
@property (strong, nonatomic) NSString * sort;
@property (assign, nonatomic) BOOL isColumn;
@property (assign, nonatomic) BOOL isEmptyFilter;


//ScrollView
@property (strong, nonatomic) UIView * scrollView;

@end

@implementation CatalogDetailView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
            andisFilterEmpty: (BOOL) isEmptyFilter{
    self = [super init];
    if (self) {
      
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height - 64.f);
        NSLog(@"FILTE %i",isEmptyFilter);
        self.isEmptyFilter = isEmptyFilter;
        self.arrayData = data;
        self.dictFilter = [NSDictionary new];
        self.sort = @"upd-1";
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applyFilter:) name:@"NOTIFICATION_FILTER_APPLY" object:nil];
       
        
#pragma mark - TopBar
        
        UIView * topBarView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, 50.f)];
        [self addSubview:topBarView];
        [UIView borderViewWithHeight:49.f andWight:0.f andView:topBarView andColor:VM_COLOR_900];
        
        self.buttonSort = [UIButton customButtonSystemWithFrame:CGRectMake(0.f, 0.f, 160.f, 50.f) andColor:nil
                                                      andAlphaBGColor:1.f andBorderColor:nil andCornerRadius:0.f andTextName:@"По Новизне"
                                                         andColorText:VM_COLOR_800 andSizeText:13 andBorderWidht:0.f];
        [self.buttonSort addTarget:self action:@selector(buttonSortAction) forControlEvents:UIControlEventTouchUpInside];
        [topBarView addSubview:self.buttonSort];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(140.f, 15.f, 20.f, 20.f)];
        imageView.image = [UIImage imageNamed:@"imageArrowDown.png"];
        [self.buttonSort addSubview:imageView];
        


        self.buttonColumnOne = [UIButton createButtonCustomImageWithImage:@"buttonCollumImageOneNO.png" andRect:CGRectMake(self.frame.size.width / 2.f + 40.f, 15.f, 20.f, 20.f)];
        [self.buttonColumnOne addTarget:self action:@selector(buttonColumnOneAction) forControlEvents:UIControlEventTouchUpInside];
        [topBarView addSubview:self.buttonColumnOne];
        self.buttonColumnTwo = [UIButton createButtonCustomImageWithImage:@"buttonCollumImageYES.png" andRect:CGRectMake((self.frame.size.width / 2.f + 40.f) + 40.f, 15.f, 20.f, 20.f)];
        [self.buttonColumnTwo addTarget:self action:@selector(buttonColumnTwoAction) forControlEvents:UIControlEventTouchUpInside];
        self.buttonColumnTwo.userInteractionEnabled = NO;
        [topBarView addSubview:self.buttonColumnTwo];
        
        self.buttonFilter = [UIButton createButtonCustomImageWithImage:@"imageButtonFilter.png" andRect:CGRectMake((self.frame.size.width / 2.f + 40.f) + 40.f * 2.f, 15.f, 20.f, 20.f)];
        
        if(self.isEmptyFilter){
            NSLog(@"EMPTY YES");
            [self.buttonFilter setImage:[UIImage imageNamed:@"imageButtonFilter.png"] forState:UIControlStateNormal];
           
        }else{
            NSLog(@"EMPTY NO");
            [self.buttonFilter setImage:[UIImage imageNamed:@"imageButtonFilterYES.png"] forState:UIControlStateNormal];
        }
        [self.buttonFilter addTarget:self action:@selector(buttonFilterAction) forControlEvents:UIControlEventTouchUpInside];
        [topBarView addSubview:self.buttonFilter];
        
        //Scroll------------
        self.isColumn=YES;
        self.scrollView = [self createScrollViewWithView:self andData:self.arrayData andColumn:YES];
        [self addSubview:self.scrollView];
        
        //Hide---------
        self.hideView = [self createHideViewVithView];
        [self addSubview:self.hideView];
        
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap:)];
        [self addGestureRecognizer:singleFingerTap];

    }
    return self;
}

#pragma mark - ScrollView

- (UIView*) createScrollViewWithView: (UIView *) view
                             andData: (NSArray*) data andColumn: (BOOL) isColumn {
    
    UIView * mainViewForScroll = [[UIView alloc] initWithFrame:CGRectMake(0.f, 50.f, view.frame.size.width, view.frame.size.height - 50.f)];
    
    
    
    UIScrollView * scrollProduct = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f , mainViewForScroll.frame.size.width, mainViewForScroll.frame.size.height)];
    scrollProduct.backgroundColor = [UIColor groupTableViewBackgroundColor];
    scrollProduct.showsVerticalScrollIndicator = NO;
    [mainViewForScroll addSubview:scrollProduct];
    NSInteger lineProduct = 0; //Идентификатор строк
    NSInteger columnProduct = 0; //Идентификатор столбцов
    for (int i = 0; i < data.count; i++) {
        
        NSDictionary * dictProduct = [data objectAtIndex:i];
        CustomButton * buttonProduct = [CustomButton buttonWithType:UIButtonTypeCustom];
        buttonProduct.customID = [dictProduct objectForKey:@"id"];
        
        buttonProduct.customName = [dictProduct objectForKey:@"name"];
        buttonProduct.customValueTwo =[dictProduct objectForKey:@"cost"];
   
        if (isColumn) {
            buttonProduct.frame = CGRectMake(0.f + ((scrollProduct.frame.size.width / 2.f + 1.5f) * columnProduct),
                                             0.f + ((scrollProduct.frame.size.width / 2.f + 1.5f) * lineProduct),
                                             scrollProduct.frame.size.width / 2.f - 1.5f,
                                             scrollProduct.frame.size.width / 2.f - 1.5f );
            //Расчет таблицы---------------
            columnProduct += 1;
            if (columnProduct > 1) {
                columnProduct = 0;
                lineProduct += 1;
            }
        } else {
            buttonProduct.frame = CGRectMake(0,
                                             0.f + ((scrollProduct.frame.size.width + 1.5f) * i),
                                             scrollProduct.frame.size.width,
                                             scrollProduct.frame.size.width);
        }
        buttonProduct.backgroundColor = [UIColor whiteColor];
        
        buttonProduct.tag = 20 + i;
        [buttonProduct addTarget:self action:@selector(buttonProductAction:) forControlEvents:UIControlEventTouchUpInside];
        
       
        
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, buttonProduct.frame.size.width, buttonProduct.frame.size.height)];
        
        
        NSURL *imgURL = [NSURL URLWithString:[dictProduct objectForKey:@"img_med"]];
        
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
                                    
                                    [scrollProduct addSubview:buttonProduct];
                                    
                                    UILabel * labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(buttonProduct.frame.size.width - 40.f,
                                                                                                     buttonProduct.frame.size.height - 15.f, 40.f, 15.f)];
                                    labelPrice.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"000000" alpha:0.4f];
                                    labelPrice.text = [NSString  stringWithFormat:@"%@ руб.", [dictProduct objectForKey:@"cost"]];
                                    labelPrice.textColor = [UIColor whiteColor];
                                    labelPrice.textAlignment = NSTextAlignmentCenter;
                                    labelPrice.font = [UIFont fontWithName:VM_FONT_REGULAR size:9];
                                    [buttonProduct addSubview:labelPrice];
                                    [scrollProduct addSubview:buttonProduct];
                                    
                                }else{
                                    
                                }
                            }];
        


    }
    if (isColumn) {
        scrollProduct.contentSize = CGSizeMake(0, 10 + (self.frame.size.width / 2.f) * lineProduct);
    } else {
        scrollProduct.contentSize = CGSizeMake(0, 0 + ((self.frame.size.width + 1.5) * self.arrayData.count));
    }
    
    
    return mainViewForScroll;
}

#pragma mark - HideView

- (UIView*) createHideViewVithView {
    UIView * hide = [[UIView alloc] initWithFrame:CGRectMake(10.f, 10.f, 150.f, 120.f)];
    hide.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_300];
    hide.alpha = 0.f;
    [self addSubview:self.hideView];
    
    //Массив имен кнопок---------
    NSArray * arrayNameButtons = [NSArray arrayWithObjects:@"Сортировать",@"По новизне", @"По возрастанию цен",@"По снижению цен", nil];
    
    for (int i = 0; i < 4; i++) {
        UIButton * buttonSortChange = [UIButton customButtonSystemWithFrame:CGRectMake(0.f, 0.f + 30.f * i, 150.f, 30) andColor:nil
                                                            andAlphaBGColor:1.f andBorderColor:nil andCornerRadius:0.f andTextName:[arrayNameButtons objectAtIndex:i]
                                                               andColorText:@"000000" andSizeText:13 andBorderWidht:0.f];
        buttonSortChange.tag = 10 + i;
        [buttonSortChange addTarget:self action:@selector(buttonSortChangeAction:) forControlEvents:UIControlEventTouchUpInside];
        [hide addSubview:buttonSortChange];
    }
    
    return hide;
}



#pragma mark - Actions

- (void) buttonProductAction: (CustomButton*) button {
    for (int i = 0; i < self.arrayData.count; i++) {
        if (button.tag == 20 + i) {
           
            [self.delegate pushToOrderController:self andProductID: button.customID andProductName:button.customName andProductPrice:button.customValueTwo];
         
        }
    }
}

- (void) buttonSortAction {
    [UIView animateWithDuration:0.3f animations:^{
        self.hideView.alpha = 1.f;
    }];
}

- (void) buttonSortChangeAction: (UIButton*) button {
    for (int i = 0; i < 4; i++) {
        if (button.tag == 10 + i) {
            NSString * sort;
            
            if(button.tag == 10){
                sort =@"upd-1";
            }else if(button.tag == 11){
                sort =@"upd-1";
            }else if(button.tag == 12){
                sort =@"cst-0";
            }else if (button.tag == 13){
                sort =@"cst-1";
            }
            self.sort = sort;
            [self.delegate setSort:sort];
            
            
            NSString * filter;
            NSString * cost;
           self.isEmptyFilter = ([self.dictFilter count] == 0);
            if(self.isEmptyFilter){
                FilterDbClass * filterDb = [[FilterDbClass alloc] init];
                
                Filter * filterCore = [filterDb filterCatID:[NSString stringWithFormat:@"%@",[self.delegate catID]] ];
                
                
                if(filterCore.o.length !=0){
                    NSString * costPrice = [NSString stringWithFormat:@"%@-%@",filterCore.min_cost,filterCore.max_cost];
                    cost=costPrice;
                    filter=filterCore.o;
                }

            }else{
                self.isEmptyFilter=NO;
                filter=[self.dictFilter objectForKey:@"string"];
                cost=[self.dictFilter objectForKey:@"cost"];
            }
            
      
            
            [self.buttonSort setTitle:button.titleLabel.text forState:UIControlStateNormal];
            [self.delegate getApiCatalog:self andBlock:^{
            
                
                for (UIView *view in self.scrollView.subviews){
                    if([view isKindOfClass:[UIScrollView class]]){
                        
                        [view removeFromSuperview];
                        
                    }
                }
                
                //Scroll------------
                self.arrayData = [self.delegate arrayData];
                self.scrollView = [self createScrollViewWithView:self andData:[self.delegate arrayData] andColumn:self.isColumn];
                
                [self addSubview:self.scrollView];
                
                for (UIView * view in self.hideView.subviews) {
                    [view removeFromSuperview];
                }
                self.hideView = [self createHideViewVithView];
                [self addSubview:self.hideView];
                [UIView animateWithDuration:0.3f animations:^{
                    [self.buttonColumnOne setImage:[UIImage imageNamed:@"buttonCollumImageOneNO.png"] forState:UIControlStateNormal];
                    [self.buttonColumnTwo setImage:[UIImage imageNamed:@"buttonCollumImageYES.png"] forState:UIControlStateNormal];
                } completion:^(BOOL finished) {
                    self.buttonColumnTwo.userInteractionEnabled = NO;
                    self.buttonColumnOne.userInteractionEnabled = YES;
                }];
                


            } andSort:sort andFilter:filter andCost:cost];
            [UIView animateWithDuration:0.3f animations:^{
                self.hideView.alpha = 0.f;
            }];
        }
    }
}

- (void) buttonColumnOneAction {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.hideView.alpha = 0.f;
    }];
    for (UIView * view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    //Scroll------------
    self.scrollView = [self createScrollViewWithView:self andData:self.arrayData andColumn:NO];
    self.isColumn=NO;
    [self addSubview:self.scrollView];
    
    for (UIView * view in self.hideView.subviews) {
        [view removeFromSuperview];
    }
    self.hideView = [self createHideViewVithView];
    [self addSubview:self.hideView];
    [UIView animateWithDuration:0.3f animations:^{
        [self.buttonColumnOne setImage:[UIImage imageNamed:@"buttonCollumImageOneYES.png"] forState:UIControlStateNormal];
        [self.buttonColumnTwo setImage:[UIImage imageNamed:@"buttonCollumImageNO.png"] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        self.buttonColumnOne.userInteractionEnabled = NO;
        self.buttonColumnTwo.userInteractionEnabled = YES;
    }];
}

- (void) buttonColumnTwoAction {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.hideView.alpha = 0.f;
    }];
    
    for (UIView * view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    //Scroll------------
    self.scrollView = [self createScrollViewWithView:self andData:self.arrayData andColumn:YES];
    self.isColumn=YES;
    [self addSubview:self.scrollView];
    
    for (UIView * view in self.hideView.subviews) {
        [view removeFromSuperview];
    }
    self.hideView = [self createHideViewVithView];
    [self addSubview:self.hideView];
    [UIView animateWithDuration:0.3f animations:^{
        [self.buttonColumnOne setImage:[UIImage imageNamed:@"buttonCollumImageOneNO.png"] forState:UIControlStateNormal];
        [self.buttonColumnTwo setImage:[UIImage imageNamed:@"buttonCollumImageYES.png"] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        self.buttonColumnTwo.userInteractionEnabled = NO;
        self.buttonColumnOne.userInteractionEnabled = YES;
    }];
}

- (void) buttonFilterAction {
    [self.delegate pushToOrderFilters: self andCatID:[self.delegate catID] andCost:[self.dictFilter objectForKey:@"cost"] andFilter:[self.dictFilter objectForKey:@"string"]];
}


- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.hideView.alpha = 0.f;
    }];
    
}


#pragma mark - Other

-(UIImage*)resizeImage:(UIImage *)image imageSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0.f,0.f,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    //here is the scaled image which has been changed to the size specified
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - ApplyFilter

- (void) applyFilter: (NSNotification*) notification {
   self.dictFilter = notification.object;

            [self.delegate getApiCatalog:self andBlock:^{
                
                for (UIView *view in self.scrollView.subviews){
                    if([view isKindOfClass:[UIScrollView class]]){
                        
                        [view removeFromSuperview];
                        
                    }
                }
                
                self.isEmptyFilter=NO;
                
                //Scroll------------
                self.arrayData = [self.delegate arrayData];
                self.scrollView = [self createScrollViewWithView:self andData:[self.delegate arrayData] andColumn:self.isColumn];
                
                //Кнопка
                
                if([[self.dictFilter objectForKey:@"string"] length]==0){
                    NSLog(@"EMPTY YES");
                    self.isEmptyFilter=YES;
                    [self.buttonFilter setImage:[UIImage imageNamed:@"imageButtonFilter.png"] forState:UIControlStateNormal];
                    
                }else{
                    NSLog(@"EMPTY NO");
                    self.isEmptyFilter=NO;
                    [self.buttonFilter setImage:[UIImage imageNamed:@"imageButtonFilterYES.png"] forState:UIControlStateNormal];
                }
                
               
                
                [self addSubview:self.scrollView];
                
                for (UIView * view in self.hideView.subviews) {
                    [view removeFromSuperview];
                }
                self.hideView = [self createHideViewVithView];
                [self addSubview:self.hideView];
                [UIView animateWithDuration:0.3f animations:^{
                    [self.buttonColumnOne setImage:[UIImage imageNamed:@"buttonCollumImageOneNO.png"] forState:UIControlStateNormal];
                    [self.buttonColumnTwo setImage:[UIImage imageNamed:@"buttonCollumImageYES.png"] forState:UIControlStateNormal];
                } completion:^(BOOL finished) {
                    self.buttonColumnTwo.userInteractionEnabled = NO;
                    self.buttonColumnOne.userInteractionEnabled = YES;
                }];

               
                
                
                
            } andSort:self.sort andFilter:[self.dictFilter objectForKey:@"string"] andCost:[self.dictFilter objectForKey:@"cost"]];
            [UIView animateWithDuration:0.3f animations:^{
                self.hideView.alpha = 0.f;
            }];
    
    
}


@end
