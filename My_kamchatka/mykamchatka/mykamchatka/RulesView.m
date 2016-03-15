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

@interface RulesView ()

@property (strong, nonatomic) NSMutableArray * viewsArray;

@end

@implementation RulesView
{
    CGRect customRest;
}

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        //Инициализация массива-----------------------------------------------------------
        self.viewsArray = [[NSMutableArray alloc] init];
        
        //Массив имен---------------------------------------------------------------------
        NSArray * nameArray = [NSArray arrayWithObjects:
                               @"Общие положения",
                               @"Цели Фотоконкурса ",
                               @"Оргкомитет Фотоконкурса",
                               @"Проведение Фотоконкурса",
                               @"Требования к фотоработам",
                               @"Критерии оценки работ",
                               @"Организатор обязуется",
                               @"Участник гарантирует", nil];
        
        //Создаем фон из двух частей фонофого затемнения и изображения--------------------
        UIView * secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        secondView.backgroundColor = [UIColor colorWithHexString:@"eceff3"];
        [self addSubview:secondView];
        UIImageView * mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        mainImageView.image = [UIImage imageNamed:@"rulesFon.jpeg"];
        mainImageView.alpha = 0.4f;
        [secondView addSubview:mainImageView];
        
        //Создаем рабочий скрол вью-------------------------------------------------------
        UIScrollView * mainScrolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, mainImageView.frame.size.width, mainImageView.frame.size.height)];
        [mainImageView addSubview:mainScrolView];
        
        for (int i = 0; i < 8; i++) {
            
            //Основной фон----------
            UIView * viewHead = [[UIView alloc] initWithFrame:CGRectMake(40, 100 + 60 * i, self.frame.size.width - 80, 40)];
            viewHead.backgroundColor = [UIColor colorWithHexString:@"4f7694"];
            viewHead.layer.cornerRadius = 5.f;
            [self addSubview:viewHead];
            
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
            UILabel * hidenLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, viewHead.frame.origin.y + viewHead.frame.size.height + 5, self.frame.size.width - 80, 20)];
            hidenLabel.backgroundColor = [UIColor colorWithHexString:@"b3ddf4"];
            hidenLabel.tag = 10 + i;
            [self addSubview: hidenLabel];
            
            
            
            [self.viewsArray addObject:viewHead];
            [self.viewsArray addObject:hidenLabel];
            
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
            
           UILabel * hidenLabelChange = (UILabel*)[self viewWithTag:10 + i];
            
            if (button.change) {
            
                

                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    NSLog(@"%f",customRest.size.height );
                    //Движение доп лейбла----------
                    customRest = hidenLabelChange.frame;
                    customRest.size.height = customRest.size.height + 200;
                    hidenLabelChange.frame = customRest;
                    
                    [button setTransform:CGAffineTransformRotate(button.transform, 4.7)];
                }completion:^(BOOL finished){
                    if (finished) {
                    }
                }];
                button.change = NO;
            } else {
                
                
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    
                    NSLog(@"%f",customRest.size.height );
                    //Движение доп лейбла-----------
                    customRest.size.height = customRest.size.height - 200;
                    hidenLabelChange.frame = customRest;
                    
                    
                    [button setTransform:CGAffineTransformRotate(button.transform, -4.7)];
                }completion:^(BOOL finished){
                    if (finished) {
                    }
                }];
                button.change = YES;
            }
        }
    }
}

@end
