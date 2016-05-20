//
//  CategoryController.m
//  PsychologistIOS
//
//  Created by Viktor on 31.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "CategoryController.h"
#import "SWRevealViewController.h"
#import "UIColor+HexColor.h"
#import "CategoryView.h"
#import "TitleClass.h"
#import "Macros.h"
#import "SubCategoryController.h"
#import "RatesController.h"
#import "FemaleKnowledgeController.h"
#import "APIGetClass.h"
#import "Macros.h"
#import "ViewNotification.h"
#import "NotificationController.h"
#import "SingleTone.h"

@implementation CategoryController
{
    NSDictionary * dictResponse;

}



- (void) viewDidLoad {
    
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = NO;
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"РАЗДЕЛ"];
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
    
#pragma mark - Initilization
    
    self.view.userInteractionEnabled = YES;
    
    [self getAPIWithBlock:^{
        
        NSArray * mainArrayAPI = [NSArray arrayWithArray:[dictResponse objectForKey:@"data"]];
        CategoryView * contentView = [[CategoryView alloc] initWithContent:self.view andArray:mainArrayAPI];
        [self.view addSubview:contentView];
        
        NSString * stringText = @"У вас 5 новых уведомлений в разделе";
        NSString * stringTitle = @"\"Женские секреты\"";
        
        ViewNotification * viewNotification = [[ViewNotification alloc] initWithView:self.view andIDDel:self andTitleLabel:stringTitle andText:stringText];
        [self.view addSubview:viewNotification];        
    }];
    
    CategoryView * backgroundView = [[CategoryView alloc] initWithBackgroundView:self.view];
    [self.view addSubview:backgroundView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPushWithSubCategory) name:NOTIFICATION_CATEGORY_PUSH_TU_SUBCATEGORY object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPushWithRates) name:NOTIFICATION_PUSH_BUY_CATEGORY object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushCustom) name:@"customNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendBookmarkCategory:) name:NOTIFICATION_SEND_BOOKMARK_CATEGORY object:nil];
    
    
}


- (void) pushViewController
{
    NotificationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Action Methods

- (void) notificationPushWithSubCategory
{
    SubCategoryController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"SubCategoryController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) notificationPushWithRates
{
    RatesController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"RatesController"];
    [self.navigationController pushViewController:detail animated:YES];
}

//Кладовая женских знаний---------------
- (void) pushCustom
{
    FemaleKnowledgeController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"FemaleKnowledgeController"];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - API

- (void) getAPIWithBlock: (void (^)(void))block
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"show_tree", nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"show_category" complitionBlock:^(id response) {
        
        dictResponse = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            block();
        }
    }];
}

- (void) sendBookmarkCategory: (NSNotification*) notification
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:[notification.userInfo objectForKey:@"id"], @"id_type", [[SingleTone sharedManager] userID], @"id_user", @"category", @"type", nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"add_fav" complitionBlock:^(id response) {
        
        dictResponse = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            NSLog(@"response %@", response);
            NSLog(@"Добавленно");
        }
    }];
}

- (void) pushNotificationWithNotification
{
    NotificationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationController"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
