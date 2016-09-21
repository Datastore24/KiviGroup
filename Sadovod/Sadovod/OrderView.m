//
//  OrderView.m
//  Sadovod
//
//  Created by Виктор Мишустин on 22/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "OrderView.h"
#import "StyledPageControl.h"
#import "HexColors.h"
#import "Macros.h"
#import "UIButton+ButtonImage.h"
#import "CustomLabels.h"
#import "UIView+BorderView.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения
#import "CustomButton.h"
#import "SingleTone.h"

@interface OrderView () <UIScrollViewDelegate>

//Main


@property (strong, nonatomic) NSDictionary * arrayData;
@property (strong, nonatomic) NSArray * arraySizes;
@property (strong, nonatomic) NSArray * detailsArray;
@property (strong, nonatomic) CustomLabels * sizesTitle;

//ScrollImage

@property (strong, nonatomic) StyledPageControl * pageControl;
@property (strong, nonatomic) UIScrollView * scrollImage;
@property (assign, nonatomic) NSInteger counterOrder; //Колличество выбранного товара

//Sizes

@property (strong, nonatomic) UIView * viewSizes;

//AuthrizationView

@property (strong, nonatomic) UIView * viewAuthorization;

//Other

@property (assign, nonatomic) BOOL isBoolAuthorization; //Временная переменная для всплывашки авторизации

@end

@implementation OrderView
#pragma mark - Main

- (instancetype)initWithView: (UIView*) view
                     andData: (NSDictionary*) data {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height);
        self.counterOrder = 0.f;
        self.arrayData = data;
        self.isBoolAuthorization = NO;
       
        NSArray * arrayImage = [data objectForKey:@"images"];
        self.arraySizes = [data objectForKey:@"sizes"];
        self.detailsArray = [data objectForKey:@"opts"];
        
        self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 64.f, self.frame.size.width, self.frame.size.height-64.f)];
        self.mainScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.mainScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.mainScrollView];
        
        //Scroll Image-----
        
        UIView * scrollImageView = [self createScrollImageWithArrayImage:arrayImage andMainView:self.mainScrollView];
        [self.mainScrollView addSubview:scrollImageView];
        
        //BuyButton
        UIButton * buyButton = [UIButton buttonWithType:UIButtonTypeSystem];
        buyButton.frame = CGRectMake(0, self.frame.size.width, self.frame.size.width, 40.f);
        buyButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
        [buyButton addTarget:self action:@selector(buyButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.mainScrollView addSubview:buyButton];
        //--
        CustomLabels * buttonBuyPrice = [[CustomLabels alloc] initLabelTableWithWidht:5.f andHeight:0.f andSizeWidht:70.f andSizeHeight:40.f andColor:@"ffffff" andText:[NSString stringWithFormat:@"%@ руб", [data objectForKey:@"cost"]]];
        buttonBuyPrice.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
        [buyButton addSubview:buttonBuyPrice];
        //--
        CustomLabels * buttonBuyLabel = [[CustomLabels alloc] initLabelTableWithWidht:self.mainScrollView.frame.size.width - 75 andHeight:0.f andSizeWidht:70.f andSizeHeight:40.f andColor:@"ffffff" andText:[NSString stringWithFormat:@"Купить"]];
        buttonBuyLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        [buyButton addSubview:buttonBuyLabel];
        
        //Sizes------
       
        
        self.sizesTitle = [[CustomLabels alloc] initLabelTableWithWidht:10 andHeight:self.frame.size.width + 53.f andSizeWidht:150.f andSizeHeight:40.f andColor:VM_COLOR_900 andText:[NSString stringWithFormat:@"Доступные размеры"]];
        
        self.sizesTitle.font = [UIFont fontWithName:VM_FONT_BOLD size:14];
        self.sizesTitle.textAlignment = NSTextAlignmentLeft;
        [self.mainScrollView addSubview:self.sizesTitle];

        self.viewSizes = [self createViewSizesWithMainView:self.mainScrollView andArraySizes:self.arraySizes];
        
        
        if(self.arraySizes.count == 1){
            if([[[self.arraySizes objectAtIndex:0] objectForKey:@"value"] isEqualToString:@"Без размера"]){
                NSLog(@"БЕЗ РАЗМЕРА НАХ");
                CGRect rectSizes = self.viewSizes.frame;
                rectSizes.size.height = 0.f;
                self.viewSizes.frame = rectSizes;
                self.viewSizes.clipsToBounds = YES;
                
                CGRect rectSizesTitle = self.sizesTitle.frame;
                rectSizesTitle.size.height = 0.f;
                self.sizesTitle.frame = rectSizesTitle;
                self.sizesTitle.clipsToBounds = YES;
            }
        }
        [self.mainScrollView addSubview:self.viewSizes];
        
        //Details-----
        
        CustomLabels * detailsTitle = [[CustomLabels alloc] initLabelTableWithWidht:10 andHeight:self.viewSizes.frame.size.height + self.viewSizes.frame.origin.y + 10 andSizeWidht:150.f andSizeHeight:40.f andColor:VM_COLOR_900 andText:[NSString stringWithFormat:@"Детально"]];
        if(self.arraySizes.count == 1){
            detailsTitle.frame = CGRectMake(10.f, self.viewSizes.frame.size.height + self.viewSizes.frame.origin.y - 40, 150.f, 40);
        }
        detailsTitle.font = [UIFont fontWithName:VM_FONT_BOLD size:14];
        detailsTitle.textAlignment = NSTextAlignmentLeft;
        [self.mainScrollView addSubview:detailsTitle];
        
        UIView * viewDetails = [self createViewDetailsWithView:self.mainScrollView andDetailsArray:nil];
        [self.mainScrollView addSubview:viewDetails];
        
        //Height scroll--------
        if ([[[SingleTone sharedManager] countType] isEqualToString:@"0"]) {
        self.mainScrollView.contentSize = CGSizeMake(0.f, viewDetails.frame.size.height + viewDetails.frame.origin.y + 3.f);
        } else {
            self.mainScrollView.contentSize = CGSizeMake(0.f, viewDetails.frame.size.height + viewDetails.frame.origin.y + 53.f);
        }
    }
    
    
    
    self.viewAuthorization = [self createAuthorizationView];
    self.viewAuthorization.alpha = 0.f;
    [self addSubview:self.viewAuthorization];
    
    return self;
}

#pragma mark - ScrollImage

- (UIView*) createScrollImageWithArrayImage: (NSArray*) arrayImage
                                andMainView: (UIView*) mainView
{
    UIView * viewForScrollImage = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.width)];
    self.scrollImage = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, viewForScrollImage.frame.size.width, viewForScrollImage.frame.size.height)];
    self.scrollImage.pagingEnabled = YES;
    self.scrollImage.backgroundColor = [UIColor whiteColor];
    self.scrollImage.delegate = self;
    self.scrollImage.showsHorizontalScrollIndicator = NO;
    self.scrollImage.contentSize = CGSizeMake(viewForScrollImage.frame.size.width * arrayImage.count, 0.f);
    [viewForScrollImage addSubview:self.scrollImage];
    
    for (int i = 0; i < arrayImage.count; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollImage.frame.size.width * i, 0.f, self.scrollImage.frame.size.width, self.scrollImage.frame.size.height)];
        
        NSURL *imgURL = [NSURL URLWithString:[arrayImage objectAtIndex:i]];
        
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
                                    
                            
                                    
                                }else{
                                    
                                }
                            }];
        
        
        
        
        [self.scrollImage addSubview:imageView];
    }
    
    //Инициализация pageControl-------------------------------------------
    self.pageControl = [[StyledPageControl alloc] init];
    self.pageControl.frame = CGRectMake(5.f, viewForScrollImage.frame.size.height - 20.f, 60.f, 20.f);
    [self.pageControl setPageControlStyle:PageControlStyleStrokedCircle];
    [self.pageControl setNumberOfPages:arrayImage.count];
    [self.pageControl setCurrentPage:0];
    [self.pageControl setDiameter:12];
    self.pageControl.strokeWidth = 1;
    [self.pageControl setCoreSelectedColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_800]];
    [self.pageControl setStrokeSelectedColor:[UIColor lightGrayColor ]];
    [self.pageControl setStrokeNormalColor:[UIColor lightGrayColor]];
    [viewForScrollImage addSubview:self.pageControl];
    
    return viewForScrollImage;
}

#pragma mark - Sizes

- (UIView*) createViewSizesWithMainView: (UIView*) mainView
                          andArraySizes: (NSArray*) arraySizes {
    //Переменные для создания таблицы
    CGFloat line = 0.f; //Строки
    CGFloat column = 0.f; //Столбцы
    
    UIView * viewSizes = [[UIView alloc] init];
    
    for (int i = 0; i < arraySizes.count; i++) {
        
        if([[[arraySizes objectAtIndex:i] objectForKey:@"aviable"] integerValue] == 1){
            NSLog(@"VALUE %@",[[arraySizes objectAtIndex:i] objectForKey:@"value"] );
            
          
            
        
        CustomButton * buttonSize = [CustomButton buttonWithType:UIButtonTypeSystem];
        buttonSize.frame = CGRectMake(10.f + (10.f * column) + (((self.frame.size.width - 46.f) / 3.f) * column), 10.f + 50.f * line, (self.frame.size.width - 46.f) / 3.f, 40.f);
        buttonSize.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_200];
        buttonSize.tag = 50 + i;
        buttonSize.customID=[[arraySizes objectAtIndex:i] objectForKey:@"id"];
        [buttonSize setTitle:[[arraySizes objectAtIndex:i] objectForKey:@"value"] forState:UIControlStateNormal];
        buttonSize.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        [buttonSize addTarget:self action:@selector(buttonSizeAction:) forControlEvents:UIControlEventTouchUpInside];
        [buttonSize setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [viewSizes addSubview:buttonSize];
        
        UIButton * buttonSizeLabel = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonSizeLabel.frame = CGRectMake(((self.frame.size.width - 46.f) / 3.f) - 11.f, - 7.f, 18.f, 18.f);
        buttonSizeLabel.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_900];
        [buttonSizeLabel setTitle:@"0" forState:UIControlStateNormal];
        [buttonSizeLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonSizeLabel.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:10];
        buttonSizeLabel.alpha = 0.f;
        buttonSizeLabel.userInteractionEnabled = NO;
        buttonSizeLabel.tag = 60 + i;
        buttonSizeLabel.layer.cornerRadius = 9.f;
        [buttonSize addSubview:buttonSizeLabel];

        
        if (i < arraySizes.count - 1) {
            column += 1;
            if (column > 2) {
                column = 0;
                line += 1;
            }
        }
        }
    }
    
    viewSizes.frame = CGRectMake(3.f, mainView.frame.size.width + 90.f, mainView.frame.size.width - 6.f, 10.f + 50.f * (line + 1));
    if (arraySizes.count == 1) {
        viewSizes.frame = CGRectMake(3.f, mainView.frame.size.width + 90.f, mainView.frame.size.width - 6.f, 0.f);
    }
    viewSizes.backgroundColor = [UIColor whiteColor];
    
    return viewSizes;
}

#pragma mark - Details
- (UIView*) createViewDetailsWithView: (UIView*) view
                      andDetailsArray: (NSArray*) detailsArray {
    UIView * viewDetail = [[UIView alloc] initWithFrame:CGRectMake(3.f, self.viewSizes.frame.size.height + self.viewSizes.frame.origin.y + 47.f, self.frame.size.width - 6.f, 40.f * (self.detailsArray.count+1))];
    if(self.arraySizes.count == 1){
        viewDetail.frame = CGRectMake(3.f, self.viewSizes.frame.size.height + self.viewSizes.frame.origin.y - 5.f, self.frame.size.width - 6.f, 40.f * (self.detailsArray.count+1));
    }
    viewDetail.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < self.detailsArray.count; i++) {
        NSDictionary * dictDetails = [self.detailsArray objectAtIndex:i];
        CustomLabels * labelTint = [[CustomLabels alloc] initLabelTableWithWidht:10.f andHeight:0.f + 40.f * i andSizeWidht:80.f andSizeHeight:40.f andColor:@"9e9e9e" andText:[dictDetails objectForKey:@"name"]];
        labelTint.font = [UIFont fontWithName:VM_FONT_REGULAR size:14];
        labelTint.textAlignment = NSTextAlignmentLeft;
        [viewDetail addSubview:labelTint];
        
        CustomLabels * labelText = [[CustomLabels alloc] initLabelTableWithWidht:100.f andHeight:0.f + 40.f * i andSizeWidht:120.f andSizeHeight:40.f andColor:@"000000" andText:[dictDetails objectForKey:@"value"]];
        labelText.font = [UIFont fontWithName:VM_FONT_REGULAR size:14];
        labelText.textAlignment = NSTextAlignmentLeft;
        [viewDetail addSubview:labelText];
        if (i < self.detailsArray.count - 1) {
            [UIView borderViewWithHeight:39.f + 40.f * i andWight:0.f andView:viewDetail andColor:@"D8D8D8"];
        }
        
        if(i+1==self.detailsArray.count){
           
            
            CustomLabels * labelTint = [[CustomLabels alloc] initLabelTableWithWidht:10.f andHeight:0.f + 40.f * (i+1) andSizeWidht:80.f andSizeHeight:40.f andColor:@"9e9e9e" andText:@"ID"];
            labelTint.font = [UIFont fontWithName:VM_FONT_REGULAR size:14];
            labelTint.textAlignment = NSTextAlignmentLeft;
            [viewDetail addSubview:labelTint];
            
            CustomLabels * labelText = [[CustomLabels alloc] initLabelTableWithWidht:100.f andHeight:0.f + 40.f * (i+1) andSizeWidht:120.f andSizeHeight:40.f andColor:@"000000" andText:[self.arrayData objectForKey:@"art"]];
            labelText.font = [UIFont fontWithName:VM_FONT_REGULAR size:14];
            labelText.textAlignment = NSTextAlignmentLeft;
            [viewDetail addSubview:labelText];
            if (i < self.detailsArray.count) {
                [UIView borderViewWithHeight:39.f + 40.f * i+1 andWight:0.f andView:viewDetail andColor:@"D8D8D8"];
            }

            
        }
    }
    
    UIView * verticalBorder = [[UIView alloc] initWithFrame:CGRectMake(90.f, 0.f, 1.f, viewDetail.frame.size.height)];
    verticalBorder.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"D8D8D8"];
    [viewDetail addSubview:verticalBorder];
    return viewDetail;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.scrollImage]) {
        CGFloat pageWidth = CGRectGetWidth(self.bounds);
        CGFloat pageFraction = self.scrollImage.contentOffset.x / pageWidth;
        self.pageControl.currentPage = roundf(pageFraction);
    }
}

#pragma mark - Actions

- (void) buttonSizeAction: (CustomButton*) button {
    for (int i = 0; i < self.arraySizes.count; i++) {
        if (button.tag == 50 + i) {
            
            if (!self.isBoolAuthorization) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.viewAuthorization.alpha = 1.f;
                } completion:^(BOOL finished) {
                    self.isBoolAuthorization = YES;
                }];
            }
           
            UIButton * buttonLabelSize = [self viewWithTag:60 + i];
            NSInteger count = [buttonLabelSize.titleLabel.text integerValue];
            count += 1;
            self.counterOrder += 1;
            NSInteger priceCount = [[[SingleTone sharedManager] countType] integerValue];
            priceCount += 1;
            
            [[SingleTone sharedManager] setCountType:[NSString stringWithFormat:@"%d", priceCount]];
            
            
            [self.delegate getApiAddCart:self andProductID:button.customID];
            [self.delegate showBottomBar:self];
            [UIView animateWithDuration:0.3 animations:^{
                [buttonLabelSize setTitle:[NSString stringWithFormat:@"%d", count] forState:UIControlStateNormal];
                buttonLabelSize.alpha = 1.f;
            }];
        }
    }
    
    [self checkMethod];

}

//Действие кнопок авторизации
- (void) buttonQuestienAction: (UIButton*) button {
    if (button.tag == 400) {
        NSLog(@"Авторизация");
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.viewAuthorization.alpha = 0.f;
        }];
    }
}

//Проверка товара
- (void) checkMethod {
    if (self.counterOrder > 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CHECK_COUNT_ORDER object:[NSNumber numberWithInteger:self.counterOrder]];
    }
}

- (void) buyButtonAction {
    [self.delegate pushTuBiyView:self];
}

#pragma mark - ViewAuthorization

- (UIView*) createAuthorizationView {
    
    UIView * fonView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    fonView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"000000" alpha:0.6];
    
    UIView * authorizationView = [[UIView alloc] initWithFrame:CGRectMake(15.f, self.frame.size.height / 2 - 90.f, self.frame.size.width - 30.f, 180)];
    authorizationView.backgroundColor = [UIColor whiteColor];
    authorizationView.layer.cornerRadius = 5.f;
    authorizationView.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"000000" alpha:0.6].CGColor;
    authorizationView.layer.borderWidth = 1.f;
    [fonView addSubview:authorizationView];
    
    CustomLabels * titlLabel = [[CustomLabels alloc] initLabelTableWithWidht:0.f andHeight:20.f andSizeWidht:authorizationView.frame.size.width andSizeHeight:20
                                                                    andColor:VM_COLOR_800 andText:@"Вы забыли авторизоваться?"];
    titlLabel.textAlignment = NSTextAlignmentCenter;
    titlLabel.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
    [authorizationView addSubview:titlLabel];
    
    CustomLabels * textLabel = [[CustomLabels alloc] initLabelTableWithWidht:15.f andHeight:45.f andSizeWidht:authorizationView.frame.size.width andSizeHeight:60
                                                                    andColor:@"000000" andText:@"Если у Вас уже есть аккаунт мы советуем\nВам авторизоваться что бы Вы имели\nдоступ к корзине на всех своих\nустройствах"];
    textLabel.numberOfLines = 4.f;
    textLabel.textAlignment = NSTextAlignmentLeft;
    textLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
    [authorizationView addSubview:textLabel];
    
    NSArray * arrayButtonsName = [NSArray arrayWithObjects:@"Авторизация", @"Скрыть", nil];
    NSArray * arrayImages = [NSArray arrayWithObjects:@"entrance.png", @"imageCancel.png", nil];
    for (int i = 0; i < 2; i++) {
        UIButton * buttonQuestien = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonQuestien.frame = CGRectMake(15.f, 120, self.frame.size.width / 2 - 12.5f, 40);
        if (i == 1) {
            buttonQuestien.frame = CGRectMake(15.f + 160, 120, self.frame.size.width / 2 - 62.5f, 40);
        }
        buttonQuestien.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_300];
        [buttonQuestien setTitle:[arrayButtonsName objectAtIndex:i] forState:UIControlStateNormal];
        [buttonQuestien setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonQuestien.layer.borderColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800].CGColor;
        buttonQuestien.layer.borderWidth = 1.f;
        buttonQuestien.layer.cornerRadius = 3.f;
        buttonQuestien.tag = 400 + i;
        buttonQuestien.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        buttonQuestien.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:13];
        [authorizationView addSubview:buttonQuestien];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 15.f, 15.f)];
        if (i == 1) {
            imageView.frame = CGRectMake(10, 12, 15.f, 15.f);
        }
        imageView.image = [UIImage imageNamed:[arrayImages objectAtIndex:i]];
        [buttonQuestien addTarget:self action:@selector(buttonQuestienAction:) forControlEvents:UIControlEventTouchUpInside];
        [buttonQuestien addSubview:imageView];
    }
    
    return fonView;
}

@end
