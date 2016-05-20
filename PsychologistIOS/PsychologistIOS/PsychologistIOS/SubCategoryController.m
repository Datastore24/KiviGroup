//
//  SubCategoryController.m
//  PsychologistIOS
//
//  Created by Viktor on 04.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "SubCategoryController.h"
#import "SWRevealViewController.h"
#import "TitleClass.h"
#import "UIColor+HexColor.h"
#import "SingleTone.h"
#import "SubCategoryView.h"
#import "Macros.h"
#import "SubjectViewController.h"
#import "APIGetClass.h"
#import "ViewNotification.h"
#import "NotificationController.h"
#import "AlertClass.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>
#import "BookmarksController.h"

@implementation SubCategoryController
{
    NSDictionary * dictResponse;
}

- (void) viewDidLoad
{
#pragma mark - Header
    
    //Заголовок-----------------------------------------------    
    TitleClass * title = [[TitleClass alloc]initWithTitle:[[[SingleTone sharedManager] titleCategory] uppercaseString]];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"d46559"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
        
#pragma mark - Initilization
    
    [self getAPIWithBlock:^{
        
        if ([[dictResponse objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
            NSArray * arrayMainResponce = [NSArray arrayWithArray:[dictResponse objectForKey:@"data"]];
            SubCategoryView * contentView = [[SubCategoryView alloc] initWithContent:self.view andArray:arrayMainResponce];
            [self.view addSubview:contentView];
        } else {
            NSLog(@"Не массив");
        }
        
        NSString * stringText = @"У вас 5 новых уведомлений в разделе";
        NSString * stringTitle = @"\"Женские секреты\"";
        
        ViewNotification * viewNotification = [[ViewNotification alloc] initWithView:self.view andIDDel:self andTitleLabel:stringTitle andText:stringText];
        [self.view addSubview:viewNotification];

        
    }];
    
    SubCategoryView * backgroundView = [[SubCategoryView alloc] initWithBackgroundView:self.view];
    [self.view addSubview:backgroundView];
    

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPushWithSubject) name:NOTIFICATION_SUB_CATEGORY_PUSH_TU_SUBCATEGORY object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addBookmark:) name:NOTIFICATION_SEND_BOOKMARK_SUB_CATEGORY object:nil];

}

- (void) notificationPushWithSubject
{
    SubjectViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"SubjectViewController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - API

- (void) getAPIWithBlock: (void (^)(void))block
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"show_tree", [[SingleTone sharedManager] identifierCategory], @"id_parent",  nil];
    
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

- (void) addBookmark: (NSNotification*) notification
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:[notification.userInfo objectForKey:@"id"], @"id_type", [[SingleTone sharedManager] userID], @"id_user", @"subcategory", @"type", nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"check_fav" complitionBlock:^(id response) {
        
        dictResponse = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            NSLog(@"response %@", response);
            if ([[response objectForKey:@"favorite_count"] integerValue] == 0) {
                NSLog(@"Нет в закладках");
                [self sendeBookmarkCategory:notification];
            } else if ([[response objectForKey:@"favorite_count"] integerValue] == 1) {
                NSLog(@"Есть в закладках");
                SCLAlertView *alert = [[SCLAlertView alloc] init];
                //Using Selector
                [alert addButton:@"Ок" target:self selector:@selector(firstButton)];
                [alert showSuccess:self title:@"Внимание" subTitle:@"Данная категория уже есть в избранном" closeButtonTitle:nil duration:0.0f];
            }
        }
    }];
}

- (void) firstButton
{
    BookmarksController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"BookmarksController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) sendeBookmarkCategory: (NSNotification*) notification
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:[notification.userInfo objectForKey:@"id"], @"id_type", [[SingleTone sharedManager] userID], @"id_user", @"subcategory", @"type", nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"add_fav" complitionBlock:^(id response) {
        
        dictResponse = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            NSLog(@"response %@", response);
            [AlertClass showAlertViewWithMessage:@"Категория добавлена в избранное"];
        }
    }];
}

- (void) pushNotificationWithNotification
{
    NotificationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationController"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
