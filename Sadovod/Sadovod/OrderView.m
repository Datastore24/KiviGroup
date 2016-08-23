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

@interface OrderView () <UIScrollViewDelegate>

//Main

@property (strong, nonatomic) UIScrollView * mainScrollView;
@property (strong, nonatomic) NSArray * arrayData;
@property (strong, nonatomic) NSArray * arraySizes;
@property (strong, nonatomic) NSArray * detailsArray;

//ScrollImage

@property (strong, nonatomic) StyledPageControl * pageControl;
@property (strong, nonatomic) UIScrollView * scrollImage;

//Sizes

@property (strong, nonatomic) UIView * viewSizes;

@end

@implementation OrderView

#pragma mark - Main

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height);
        
        self.arrayData = data;
        NSDictionary * dictData = [data objectAtIndex:0];
        NSArray * arrayImage = [dictData objectForKey:@"imageArray"];
        self.arraySizes = [dictData objectForKey:@"sizeArray"];
        self.detailsArray = [dictData objectForKey:@"details"];
        
        self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        self.mainScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.mainScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.mainScrollView];
        
        //Scroll Image-----
        
        UIView * scrollImageView = [self createScrollImageWithArrayImage:arrayImage andMainView:self.mainScrollView];
        [self.mainScrollView addSubview:scrollImageView];
        
        //BuyButton
        UIButton * buyButton = [UIButton buttonWithType:UIButtonTypeSystem];
        buyButton.frame = CGRectMake(0, self.frame.size.width + 3.f, self.frame.size.width, 40.f);
        buyButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
        [self.mainScrollView addSubview:buyButton];
        //--
        CustomLabels * buttonBuyPrice = [[CustomLabels alloc] initLabelTableWithWidht:5.f andHeight:0.f andSizeWidht:70.f andSizeHeight:40.f andColor:@"ffffff" andText:[NSString stringWithFormat:@"%@ руб", [dictData objectForKey:@"price"]]];
        buttonBuyPrice.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
        [buyButton addSubview:buttonBuyPrice];
        //--
        CustomLabels * buttonBuyLabel = [[CustomLabels alloc] initLabelTableWithWidht:self.mainScrollView.frame.size.width - 75 andHeight:0.f andSizeWidht:70.f andSizeHeight:40.f andColor:@"ffffff" andText:[NSString stringWithFormat:@"Купить"]];
        buttonBuyLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        [buyButton addSubview:buttonBuyLabel];
        
        //Sizes------
        
        CustomLabels * sizesTitle = [[CustomLabels alloc] initLabelTableWithWidht:10 andHeight:self.frame.size.width + 53.f andSizeWidht:150.f andSizeHeight:40.f andColor:VM_COLOR_900 andText:[NSString stringWithFormat:@"Доступные размеры"]];
        sizesTitle.font = [UIFont fontWithName:VM_FONT_BOLD size:14];
        sizesTitle.textAlignment = NSTextAlignmentLeft;
        [self.mainScrollView addSubview:sizesTitle];

        self.viewSizes = [self createViewSizesWithMainView:self.mainScrollView andArraySizes:self.arraySizes];
        [self.mainScrollView addSubview:self.viewSizes];
        
        //Details-----
        
        CustomLabels * detailsTitle = [[CustomLabels alloc] initLabelTableWithWidht:10 andHeight:self.viewSizes.frame.size.height + self.viewSizes.frame.origin.y + 10 andSizeWidht:150.f andSizeHeight:40.f andColor:VM_COLOR_900 andText:[NSString stringWithFormat:@"Детально"]];
        detailsTitle.font = [UIFont fontWithName:VM_FONT_BOLD size:14];
        detailsTitle.textAlignment = NSTextAlignmentLeft;
        [self.mainScrollView addSubview:detailsTitle];
        
        UIView * viewDetails = [self createViewDetailsWithView:self.mainScrollView andDetailsArray:nil];
        [self.mainScrollView addSubview:viewDetails];
        
        //Height scroll--------
        self.mainScrollView.contentSize = CGSizeMake(0.f, viewDetails.frame.size.height + viewDetails.frame.origin.y + 3.f);
    }
    return self;
}

#pragma mark - ScrollImage

- (UIView*) createScrollImageWithArrayImage: (NSArray*) arrayImage
                                andMainView: (UIView*) mainView
{
    UIView * viewForScrollImage = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.width)];
    self.scrollImage = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, viewForScrollImage.frame.size.width, viewForScrollImage.frame.size.height)];
    self.scrollImage.pagingEnabled = YES;
    self.scrollImage.delegate = self;
    self.scrollImage.showsHorizontalScrollIndicator = NO;
    self.scrollImage.contentSize = CGSizeMake(viewForScrollImage.frame.size.width * arrayImage.count, 0.f);
    [viewForScrollImage addSubview:self.scrollImage];
    
    for (int i = 0; i < arrayImage.count; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollImage.frame.size.width * i, 0.f, self.scrollImage.frame.size.width, self.scrollImage.frame.size.height)];
        imageView.image = [UIImage imageNamed:[arrayImage objectAtIndex:i]];
        [self.scrollImage addSubview:imageView];
    }
    
    //Инициализация pageControl-------------------------------------------
    self.pageControl = [[StyledPageControl alloc] init];
    self.pageControl.frame = CGRectMake(5.f, viewForScrollImage.frame.size.height - 20.f, 60.f, 20.f);
    [self.pageControl setPageControlStyle:PageControlStyleStrokedCircle];
    [self.pageControl setNumberOfPages:3];
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
        UIButton * buttonSize = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonSize.frame = CGRectMake(10.f + (10.f * column) + (((self.frame.size.width - 46.f) / 3.f) * column), 10.f + 50.f * line, (self.frame.size.width - 46.f) / 3.f, 40.f);
        buttonSize.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_200];
        buttonSize.tag = 50 + i;
        [buttonSize setTitle:[arraySizes objectAtIndex:i] forState:UIControlStateNormal];
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
    UIView * viewDetail = [[UIView alloc] initWithFrame:CGRectMake(3.f, self.viewSizes.frame.size.height + self.viewSizes.frame.origin.y + 47.f, self.frame.size.width - 6.f, 40.f * self.detailsArray.count)];
    viewDetail.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < self.detailsArray.count; i++) {
        NSDictionary * dictDetails = [self.detailsArray objectAtIndex:i];
        CustomLabels * labelTint = [[CustomLabels alloc] initLabelTableWithWidht:10.f andHeight:0.f + 40.f * i andSizeWidht:80.f andSizeHeight:40.f andColor:@"9e9e9e" andText:[dictDetails objectForKey:@"titl"]];
        labelTint.font = [UIFont fontWithName:VM_FONT_REGULAR size:14];
        labelTint.textAlignment = NSTextAlignmentLeft;
        [viewDetail addSubview:labelTint];
        
        CustomLabels * labelText = [[CustomLabels alloc] initLabelTableWithWidht:100.f andHeight:0.f + 40.f * i andSizeWidht:120.f andSizeHeight:40.f andColor:@"000000" andText:[dictDetails objectForKey:@"text"]];
        labelText.font = [UIFont fontWithName:VM_FONT_REGULAR size:14];
        labelText.textAlignment = NSTextAlignmentLeft;
        [viewDetail addSubview:labelText];
        if (i < self.detailsArray.count - 1) {
            [UIView borderViewWithHeight:39.f + 40.f * i andWight:0.f andView:viewDetail andColor:@"D8D8D8"];
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

- (void) buttonSizeAction: (UIButton*) button {
    for (int i = 0; i < self.arraySizes.count; i++) {
        if (button.tag == 50 + i) {
            UIButton * buttonLabelSize = [self viewWithTag:60 + i];
            NSInteger count = [buttonLabelSize.titleLabel.text integerValue];
            count += 1;
            [UIView animateWithDuration:0.3 animations:^{
                [buttonLabelSize setTitle:[NSString stringWithFormat:@"%d", count] forState:UIControlStateNormal];
                buttonLabelSize.alpha = 1.f;
            }];
        }
    }
}

@end
