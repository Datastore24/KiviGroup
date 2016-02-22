//
//  OrderTimeController.m
//  ITDolgopa
//
//  Created by Viktor on 20.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "OrderTimeController.h"
#import "TitleClass.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "SWRevealViewController.h"
#import "OrderTimeView.h"
#import "APIGetClass.h"
#import "SingleTone.h"

@interface OrderTimeController ()

@end

@implementation OrderTimeController
{
    UIScrollView * mainScrollView;
    NSDictionary * dictResponse;
}

- (void) viewDidLoad
{
#pragma mark - initialization

    self.navigationController.navigationBar.layer.cornerRadius=5;
    self.navigationController.navigationBar.clipsToBounds=YES;
    
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"ЗАБРОНИРОВАТЬ ВРЕМЯ"];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:MAINCOLORBUTTONLOGIN];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;

    //Пареметры кнопки меню------------------------------------
    UIImage *imageBarButton = [UIImage imageNamed:@"menuIcon.png"];
    [_buttonMenu setImage:imageBarButton];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake( 0, 0, 30, 30);
    [button setImage:imageBarButton forState:UIControlStateNormal];
    [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=button;
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.navigationController.navigationBar.hidden = NO; // спрятал navigation bar
    
    //Параметры UIScrollView------------------------------------
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mainScrollView.backgroundColor = [UIColor colorWithHexString:MAINBACKGROUNDCOLOR];
    [self.view addSubview:mainScrollView];
    
    //Инициализация основного вью-------------------------------
    OrderTimeView * orderTimeView = [[OrderTimeView alloc] initWithView:mainScrollView];
    [mainScrollView addSubview:orderTimeView];
    
    UIButton * buttonConferm = (UIButton*)[self.view viewWithTag:415];
    [buttonConferm addTarget:self action:@selector(buttonConfermAction) forControlEvents:UIControlEventTouchUpInside];   
}

#pragma mark - API

- (void) pushOrderTimeWithPhone: (NSString*) phone
                        andDate: (NSString*) date
                        andTime: (NSString*) time
                     andProblem: (NSString*) problem
{
    APIGetClass * orderTimeGetClass = [APIGetClass new];
    NSDictionary * dictParams = [NSDictionary dictionaryWithObjectsAndKeys:
                                 phone, @"phone",
                                 date, @"wdate",
                                 time, @"wtime",
                                 problem, @"wproblem", nil];
    [orderTimeGetClass getDataFromServerWithParams:dictParams method:@"wait_client" complitionBlock:^(id response) {
   
        dictResponse = (NSDictionary*) response;
        NSLog(@"ERROR %li",[[dictResponse objectForKey:@"error"] integerValue] );
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
           NSLog(@"%@", response);
        }        
    }];
}

#pragma mark - Buttons Methods
- (void) buttonConfermAction
{
    UILabel * labelDataAction = (UILabel*)[self.view viewWithTag:401];
    UILabel * labelTimeAction = (UILabel*)[self.view viewWithTag:410];
    UITextField * textFieldProblem = (UITextField*)[self.view viewWithTag:413];
    [self pushOrderTimeWithPhone:[[SingleTone sharedManager] phone] andDate:labelDataAction.text andTime:labelTimeAction.text andProblem:textFieldProblem.text];
}

@end
