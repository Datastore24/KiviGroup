//
//  RulesView.m
//  mykamchatka
//
//  Created by Viktor on 15.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "RulesView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "CustomButton.h"

@interface RulesView () <UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray * viewsArray;

@end

@implementation RulesView
{
    UIScrollView * mainScrolView;
    CGFloat floatSizeScroll;
    CGFloat floatSize;
}

- (instancetype)initWithView: (UIView*) view
                andArrayName: (NSArray*) arrayName
                andArrayData: (NSArray*) arrayData
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        floatSizeScroll = 0;
        //Инициализация массива-----------------------------------------------------------
        self.viewsArray = [[NSMutableArray alloc] init];
        
        //Массив имен---------------------------------------------------------------------
        NSArray * nameArray = arrayName;
        
        //Массив данных-------------------------------------------------------------------
        NSArray * nameData = arrayData;
        
        //Создаем фон из двух частей фонофого затемнения и изображения--------------------
        UIView * secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        secondView.backgroundColor = [UIColor colorWithHexString:@"eceff3"];
        [self addSubview:secondView];
        UIImageView * mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        mainImageView.image = [UIImage imageNamed:@"rulesFon.jpeg"];
        mainImageView.alpha = 0.4f;
        [secondView addSubview:mainImageView];
        
        //Создаем рабочий скрол вью-------------------------------------------------------
        mainScrolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, mainImageView.frame.size.width, mainImageView.frame.size.height)];
        mainScrolView.delegate = self;
        [self addSubview:mainScrolView];
        
        for (int i = 0; i < 8; i++) {
            
            //Основной фон----------
            UIView * viewHead = [[UIView alloc] initWithFrame:CGRectMake(40, 100 + 60 * i, self.frame.size.width - 80, 40)];
            viewHead.backgroundColor = [UIColor colorWithHexString:@"4f7694"];
            viewHead.layer.cornerRadius = 5.f;
            viewHead.tag = 20 + i;
            [mainScrolView addSubview:viewHead];
            
            //Текст заголовка---------
            UILabel * labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, viewHead.frame.size.width - 80, 40)];
            labelTitle.text = [nameArray objectAtIndex:i];
            labelTitle.textColor = [UIColor whiteColor];
            labelTitle.font = [UIFont fontWithName:FONTREGULAR size:18];
            [viewHead addSubview:labelTitle];
            
            //Кнопка раскрытия темы----
            CustomButton * buttonConfirm = [CustomButton buttonWithType:UIButtonTypeCustom];
            buttonConfirm.frame = CGRectMake(viewHead.frame.size.width - 60, 5, 30, 30);
            UIImage * buttonConfirmImage = [UIImage imageNamed:@"buttonConfirm.png"];
            [buttonConfirm setImage:buttonConfirmImage forState:UIControlStateNormal];
            buttonConfirm.tag = i;
            buttonConfirm.change = YES;
            [buttonConfirm addTarget:self action:@selector(buttonConfirmAction:) forControlEvents:UIControlEventTouchUpInside];
            [viewHead addSubview:buttonConfirm];
            
            //Раскрывающейся лейбл------
            UIView * hidenView = [[UIView alloc] initWithFrame:CGRectMake(40, viewHead.frame.origin.y + viewHead.frame.size.height + 5, self.frame.size.width - 80, 0)];
            hidenView.backgroundColor = [UIColor colorWithHexString:@"4f7694"];
            hidenView.tag = 10 + i;
            [mainScrolView addSubview: hidenView];
            
            UILabel * labelData = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, hidenView.frame.size.width - 40, 0)];
            labelData.numberOfLines = 0;
            labelData.text = [nameData objectAtIndex:i];
            labelData.tag = 100 + i;
            labelData.textColor = [UIColor whiteColor];
            labelData.font = [UIFont fontWithName:FONTLITE size:16];
            [labelData sizeToFit];
            [hidenView addSubview:labelData];

            
            [self.viewsArray addObject:viewHead];
            [self.viewsArray addObject:hidenView];

            
        }

        
    }
    return self;
}

#pragma mark - Buttons Methods

//Действие кнопок заголовков-----------------
- (void) buttonConfirmAction: (CustomButton*) button
{
    
    for (int i = 0; i < 8; i++) {
        if (button.tag == i) {
           UIView * hidenViewChange = (UIView*)[self viewWithTag:10 + i];
            
            floatSize = 200;
            
            if (button.change) {
            
                floatSizeScroll = floatSizeScroll + floatSize;
                

                [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    //Движение доп лейбла----------
                    CGRect customRest = hidenViewChange.frame;
                    customRest.size.height = customRest.size.height + floatSize;
                    hidenViewChange.frame = customRest;
                    
                    
                    //Вращение кнопки-------------
                    [button setTransform:CGAffineTransformRotate(button.transform, 4.7)];
                    
                    for (NSInteger j = (button.tag + 1) * 2; j < self.viewsArray.count; j++) {
                        
                        UIView * testView = [self.viewsArray objectAtIndex:j];
                        CGRect rectMove = testView.frame;
                        rectMove.origin.y += floatSize;
                        testView.frame = rectMove;
                    }
                    
                }completion:^(BOOL finished){
                    if (finished) {
                        mainScrolView.contentSize = CGSizeMake(0, mainScrolView.frame.size.height + floatSizeScroll);
                    }
                }];
                button.change = NO;

            } else {
                
                floatSizeScroll = floatSizeScroll - floatSize;
                
                [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    //Движение доп лейбла-----------
                    CGRect customRest2 = hidenViewChange.frame;
                    customRest2.size.height = customRest2.size.height - floatSize;
                    hidenViewChange.frame = customRest2;
                    //Вращение кнопки-------------
                    [button setTransform:CGAffineTransformRotate(button.transform, -4.7)];
                    
                    for (NSInteger j = (button.tag + 1) * 2; j < self.viewsArray.count; j++) {
                        
                        UIView * testView = [self.viewsArray objectAtIndex:j];
                        CGRect rectMove = testView.frame;
                        rectMove.origin.y -= floatSize;
                        testView.frame = rectMove;
                        
                    }
                    
                }completion:^(BOOL finished){
                    if (finished) {
                        mainScrolView.contentSize = CGSizeMake(0, mainScrolView.frame.size.height + floatSizeScroll);
                    }
                }];
                button.change = YES;
            }
        }
    }
    
}

@end
