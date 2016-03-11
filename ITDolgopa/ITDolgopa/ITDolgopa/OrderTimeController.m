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
#import "AlertClass.h"
#import "UnderRepairController.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>
#import <AFNetworking/AFNetworking.h>
#import "NetworkRechabilityMonitor.h"


@interface OrderTimeController ()

@end

@implementation OrderTimeController
{
    UIScrollView * mainScrollView;
    NSDictionary * dictResponse;
    UIButton * buttonConferm;
}

- (void) viewDidLoad
{
#pragma mark - initialization
    //проверка интернет соединения --------------------------
    self.isNoInternet = 0;
    [NetworkRechabilityMonitor startNetworkReachabilityMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %ld", (long)status);
        if(status == 0){
            if(self.isNoInternet == 0){
            [NetworkRechabilityMonitor showNoInternet:self.view andShow:YES];
            self.isNoInternet = 1;
            }
            NSLog(@"НЕТ ИНТЕРНЕТА");
        }else{
            if(self.isNoInternet == 1){
                [self viewDidLoad];
            }
            NSLog(@"ЕСТЬ ИНТЕРНЕТ");
            [NetworkRechabilityMonitor showNoInternet:self.view andShow:NO];
        }
    }];
    //
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
    
    buttonConferm = (UIButton*)[self.view viewWithTag:415];
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
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            [AlertClass showAlertViewWithMessage:[dictResponse objectForKey:@"error_msg"] view:self];
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
           
            SCLAlertView* alert = [[SCLAlertView alloc] init];
            alert.customViewColor = [UIColor colorWithHexString:@"3038a0"];
            [alert addButton:@"Ок" target:self selector:@selector(firstButton)];
            [alert showSuccess:self title:@"Внимание!!!" subTitle:@"Ваша заявка забронированна" closeButtonTitle:nil duration:0.f];
            buttonConferm.userInteractionEnabled = YES;
        }        
    }];
}

#pragma mark - Buttons Methods
- (void) buttonConfermAction
{
    UILabel * labelDataAction = (UILabel*)[self.view viewWithTag:401];
    UILabel * labelTimeAction = (UILabel*)[self.view viewWithTag:410];
    UITextField * textFieldProblem = (UITextField*)[self.view viewWithTag:413];
    
    buttonConferm.userInteractionEnabled = NO;
    
    if (textFieldProblem.text.length != 0) {
        [self pushOrderTimeWithPhone:[[SingleTone sharedManager] phone] andDate:labelDataAction.text andTime:labelTimeAction.text andProblem:textFieldProblem.text];
    } else {
        [AlertClass showAlertViewWithMessage:@"Опишите проблему" view:self];
        buttonConferm.userInteractionEnabled = YES;
    }
    

}

- (void) firstButton
{
    UnderRepairController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"UnderRepair"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
