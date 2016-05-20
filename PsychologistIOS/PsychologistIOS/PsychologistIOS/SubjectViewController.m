//
//  SubjectViewController.m
//  PsychologistIOS
//
//  Created by Viktor on 05.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "SubjectViewController.h"
#import "SWRevealViewController.h"
#import "TitleClass.h"
#import "SubCategoryView.h"
#import "SubjectView.h"
#import "UIColor+HexColor.h"
#import "SingleTone.h"
#import "Macros.h"
#import "OpenSubjectController.h"
#import "APIGetClass.h"
#import "ViewNotification.h"
#import "NotificationController.h"
#import "AlertClass.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>
#import "BookmarksController.h"

@implementation SubjectViewController
{
    NSDictionary * dictResponse;
}

- (void) viewDidLoad
{
#pragma mark - Header
    
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:[[[SingleTone sharedManager] titleSubCategory] uppercaseString]];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"d46559"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
#pragma mark - Initilization
    
    SubCategoryView * backgroundView = [[SubCategoryView alloc] initWithBackgroundView:self.view];
    [self.view addSubview:backgroundView];
    
    [self getAPIWithBlock:^{
        
        if ([[dictResponse objectForKey:@"data"] isKindOfClass:[NSArray class]])
        {
            NSArray * mainArray = [NSArray arrayWithArray:[dictResponse objectForKey:@"data"]];
            SubjectView * contentView = [[SubjectView alloc] initWithContent:self.view andArray:mainArray];
            [self.view addSubview:contentView];
        } else {
            NSLog(@"Не массив");
        }
        
        NSString * stringText = @"У вас 5 новых уведомлений в разделе";
        NSString * stringTitle = @"\"Женские секреты\"";
        
        ViewNotification * viewNotification = [[ViewNotification alloc] initWithView:self.view andIDDel:self andTitleLabel:stringTitle andText:stringText];
        [self.view addSubview:viewNotification];
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPushWithOpenSubject:) name:NOTIFICATION_SUBJECT_PUSH_TU_SUBCATEGORY object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendBookMark:) name:NOTIFICATION_SEND_BOOKMARK_SUBJECT object:nil];
}

- (void) notificationPushWithOpenSubject: (NSNotification*) notification
{
        NSLog(@"Текст");
        OpenSubjectController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"OpenSubjectController"];
        [self.navigationController pushViewController:detail animated:YES];

}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - API

- (void) getAPIWithBlock: (void (^)(void))block
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:[[SingleTone sharedManager] identifierSubCategory], @"id_category", nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"list_post" complitionBlock:^(id response) {
        
        dictResponse = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            block();
        }
    }];

}

- (void) sendBookMark: (NSNotification*) notification
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:[notification.userInfo objectForKey:@"id"], @"id_type", [[SingleTone sharedManager] userID], @"id_user", @"post", @"type", nil];
    
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
                [alert showSuccess:self title:@"Внимание" subTitle:@"Данная тема уже есть в избранном" closeButtonTitle:nil duration:0.0f];
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
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:[notification.userInfo objectForKey:@"id"], @"id_type", [[SingleTone sharedManager] userID], @"id_user", @"post", @"type", nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"add_fav" complitionBlock:^(id response) {
        
        dictResponse = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            NSLog(@"response %@", response);
            [AlertClass showAlertViewWithMessage:@"Тема добавлена в избранное"];
        }
    }];
}

- (void) pushNotificationWithNotification
{
    NotificationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationController"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
