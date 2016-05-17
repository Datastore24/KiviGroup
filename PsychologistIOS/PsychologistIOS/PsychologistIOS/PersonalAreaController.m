//
//  PersonalAreaController.m
//  PsychologistIOS
//
//  Created by Viktor on 14.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "PersonalAreaController.h"
#import "SWRevealViewController.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "TitleClass.h"
#import "SubCategoryView.h"
#import "PersonalAreaView.h"
#import "ArrayCitys.h"
#import "SubscriptionController.h"
#import "APIGetClass.h"
#import "SingleTone.h"

@implementation PersonalAreaController{
    NSDictionary * dictResponse;
}

- (void) viewDidLoad {
    
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = NO;
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"ЛИЧНЫЙ КАБИНЕТ"];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"d46559"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    //Пареметры кнопки меню------------------------------------
    UIImage *imageBarButton = [UIImage imageNamed:@"menuIcon.png"];
    [_buttonMenu setImage:imageBarButton];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 32, 24);
    CGRect rect = button.frame;
    rect.origin.y += 16;
    button.frame = rect;
    [button setImage:imageBarButton forState:UIControlStateNormal];
    [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=button;
    //    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
#pragma mark - Initiliztion
    
    //Бэкграунд------------------
    SubCategoryView * backgroundView = [[SubCategoryView alloc] initWithBackgroundView:self.view];
    [self.view addSubview:backgroundView];
    
    //Основной контент------------
    [self getAPIWithBlock:^{
        
        PersonalAreaView * contentView = [[PersonalAreaView alloc] initWithView:self.view andDictionary:[dictResponse objectForKey:@"data"]];
        [self.view addSubview:contentView];
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPushSubscription) name:NOTIFICATION_PUSH_SUBSCRIPTION object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendAction:) name:NOTIFICATION_SAVE_PROFILE object:nil];

}

#pragma mark - DEALLOC
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Action Methods
- (void) notificationPushSubscription
{
    SubscriptionController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"SubscriptionController"];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - API

- (void) getAPIWithBlock: (void (^)(void))block
{
    NSLog(@"%@",[[SingleTone sharedManager] userId]);
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
    [[SingleTone sharedManager] userId],@"id", nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"show_user_id" complitionBlock:^(id response) {
        
        dictResponse = (NSDictionary*) response;
   
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            NSLog(@"LOG %@",dictResponse);
            block();
        }
    }];
}

-(void)sendAction: (NSNotification*) notification{
    
    NSDictionary * dictSend = notification.object;
    [self saveProfile:dictSend];
    
}

- (void) saveProfile: (NSDictionary *) dict
{


                               
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [dict objectForKey:@"id"],@"id",
                            [dict objectForKey:@"name"],@"name",
                            [dict objectForKey:@"family"],@"family",
                            [dict objectForKey:@"email"],@"email",
                            [dict objectForKey:@"phone"],@"phone",
                            [dict objectForKey:@"city"],@"city",
                            [dict objectForKey:@"bdate"],@"bdate",

                             
                             nil];
    
    NSLog(@"%@",params);
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"edit_user" complitionBlock:^(id response) {
        
        dictResponse = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
          NSLog(@"%@", dictResponse);
        }
    }];
}

@end
