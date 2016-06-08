//
//  BouquetsView.m
//  FlowersOnline
//
//  Created by Виктор Мишустин on 05.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "BouquetsView.h"
#import "UIColor+HexColor.h"
#import "CustomButton.h"

@implementation BouquetsView

{
    UIScrollView * mainScrollView;
    NSArray * arrayName;
    NSMutableArray * arrayScroll;
    NSMutableArray * arrayControl;
    NSMutableArray * buttonsArray;
}

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        arrayName = [NSArray arrayWithObjects:@"букет1", @"букет2", @"букет3", @"букет4", @"букет5", nil];
        arrayScroll = [NSMutableArray new];
        arrayControl = [NSMutableArray new];
        buttonsArray = [NSMutableArray new];
        
        //Наносим основной скрол вью
        mainScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        mainScrollView.contentSize = CGSizeMake(0, self.frame.size.width * arrayName.count);
        [self addSubview:mainScrollView];
        
        //Создаем циклБукетов
        for (int i = 0; i < arrayName.count; i++) {
            //Инициализация scrollView-----------------------------------------
            UIScrollView * scrollImages = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.frame.size.width * i, self.frame.size.width, self.frame.size.width)];
            [scrollImages setDelegate:self];
            [scrollImages setPagingEnabled:YES];
            [scrollImages setContentSize:CGSizeMake(self.frame.size.width*3, self.frame.size.width)]; // задаем количество слайдов
            scrollImages.showsHorizontalScrollIndicator = NO;
            [scrollImages setBackgroundColor:[UIColor whiteColor]]; // цвет фона скролвью
            [arrayScroll addObject:scrollImages];
            [mainScrollView addSubview:scrollImages];
            
            //Инициализация pageControl-------------------------------------------
            UIPageControl * pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 30, scrollImages.frame.size.height-20 + self.frame.size.width * i, 60, 10)];
            [pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithHexString:@"303f9f"]]; //цвет "точек" при пролистывании экрана приветствия
            pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
            [pageControl setNumberOfPages:3]; // задаем количетсво слайдов приветствия
            [arrayControl addObject:pageControl];
            [mainScrollView addSubview:pageControl];
            
            UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
            view1.backgroundColor = [UIColor redColor];
            [scrollImages addSubview:view1];
            
            UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.width)];
            view2.backgroundColor = [UIColor greenColor];
            [scrollImages addSubview:view2];
            
            UIView * view3 = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, self.frame.size.width)];
            view3.backgroundColor = [UIColor yellowColor];
            [scrollImages addSubview:view3];
            
            //Создаем кнопку увеличения scrollView
            CustomButton * buttonScroll = [CustomButton buttonWithType:UIButtonTypeSystem];
            buttonScroll.frame = CGRectMake(0, 0, self.frame.size.width * 3, self.frame.size.width);
            buttonScroll.isBool = YES;
            [buttonScroll addTarget:self action:@selector(buttonScrollAction:) forControlEvents:UIControlEventTouchUpInside];
            [buttonsArray addObject:buttonScroll];
            [scrollImages addSubview:buttonScroll];
            
  
        }
        
        
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
        for (int i = 0; i < arrayName.count; i++) {
            if ([scrollView isEqual:[arrayScroll objectAtIndex:i]]) {
                CGFloat pageWidth = CGRectGetWidth(self.bounds);
                UIScrollView * scrol = [arrayScroll objectAtIndex:i];
                UIPageControl * control = [arrayControl objectAtIndex:i];
                CGFloat pageFraction = scrol.contentOffset.x / pageWidth;
                control.currentPage = roundf(pageFraction);
            }
        }
}

- (void) buttonScrollAction: (CustomButton*) button
{
    for (int i = 0; i < arrayName.count; i++) {
        if ([button isEqual:[buttonsArray objectAtIndex:i]]) {
            if (button.isBool) {
                NSLog(@"Да");
                button.isBool = NO;
            } else {
                NSLog(@"Нет");
                button.isBool = YES;
            }
        }
    }
}

@end
