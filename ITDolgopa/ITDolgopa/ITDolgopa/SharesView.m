//
//  SharesView.m
//  ITDolgopa
//
//  Created by Viktor on 05.03.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "SharesView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения
#import "UIImage+Resize.h"//Ресайз изображения
#import "ViewSectionTable.h"

@interface SharesView () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UIButton *startButton;

@property (strong, nonatomic) UITextField * addName;

@end

@implementation SharesView

- (instancetype)initWithView : (UIView*) view andArray: (NSArray*) array
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        self.backgroundColor = [UIColor colorWithHexString:MAINBACKGROUNDCOLOR];
        
                //Инициализация scrollView-----------------------------------------
                _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
                [_scrollView setDelegate:self];
                [_scrollView setPagingEnabled:YES];
                [_scrollView setContentSize:CGSizeMake(self.frame.size.width*array.count, self.scrollView.frame.size.height)]; // задаем количество слайдов
                _scrollView.showsHorizontalScrollIndicator = NO;
                [_scrollView setBackgroundColor:[UIColor colorWithHexString:MAINBACKGROUNDCOLOR]]; // цвет фона скролвью
                [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
       
        if (array.count == 0) {
            
            
            NSLog(@"Ноль");
            
            UILabel * labelNoShares = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
            labelNoShares.center = self.center;
            labelNoShares.text = @"В данный момент акции отсутвтвуют";
            labelNoShares.textColor = [UIColor whiteColor];
            labelNoShares.font = [UIFont fontWithName:FONTREGULAR size:16];
            labelNoShares.textAlignment = NSTextAlignmentCenter;
            [self addSubview:labelNoShares];
            
        } else {
                
                //Реализация вью-----------------
                for (int i = 0; i < array.count; i++) {
                    
                    NSDictionary * dictArray = [array objectAtIndex:i];
                      UIView * viewScroll = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height)];
                    viewScroll.backgroundColor = [UIColor colorWithHexString:MAINBACKGROUNDCOLOR];
                    [_scrollView addSubview:viewScroll];
                    //Текст акции----------------
                    UILabel * labelTextView = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, view.frame.size.width - 40, 50)];
                    labelTextView.numberOfLines = 0;
                    labelTextView.backgroundColor = [UIColor clearColor];
                    labelTextView.text = [dictArray objectForKey:@"promo_text"];
                    labelTextView.textColor = [UIColor whiteColor];
                    labelTextView.font = [UIFont fontWithName:FONTREGULAR size:14];
                    labelTextView.textAlignment = NSTextAlignmentCenter;
                    [viewScroll addSubview:labelTextView];
                    
                    //Картинка акции-------------
                    ViewSectionTable * imageShares = [[ViewSectionTable alloc] initSharesWithImageURL:[dictArray objectForKey:@"promo_file"] andView:viewScroll];
                    imageShares.frame = CGRectMake
                    ((viewScroll.frame.size.width / 2) - (250 / 2),
                     (viewScroll.frame.size.height / 2) - (250 / 2), 250, 250);
                    [viewScroll addSubview:imageShares];
                    //Дата акции-----------------
                    UILabel * labelData = [[UILabel alloc] initWithFrame:
                    CGRectMake(0, viewScroll.frame.size.height - 60, viewScroll.frame.size.width, 20)];
                    labelData.text = [dictArray objectForKey:@"promo_created"];
                    labelData.font = [UIFont fontWithName:FONTREGULAR size:14];
                    labelData.textColor = [UIColor whiteColor];
                    labelData.textAlignment = NSTextAlignmentCenter;
                    [viewScroll addSubview:labelData];
                    
   
                    }
         [self addSubview:_scrollView];
        //Инициализация pageControl-------------------------------------------
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
        CGPoint pointCentr = self.center;
        pointCentr.y = self.frame.size.height - 20;
        _pageControl.center = pointCentr;
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor lightGrayColor]]; //цвет "точек" при пролистывании экрана приветствия
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        [_pageControl setNumberOfPages:array.count]; // задаем количетсво слайдов приветствия
        [self addSubview:_pageControl];
            }
    }
            return self;
        }
        
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
            
            CGFloat pageWidth = CGRectGetWidth(self.bounds);
            CGFloat pageFraction = self.scrollView.contentOffset.x / pageWidth;
            self.pageControl.currentPage = roundf(pageFraction);
            
}


@end
