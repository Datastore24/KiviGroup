//
//  BookmarksController.m
//  PsychologistIOS
//
//  Created by Viktor on 12.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "BookmarksController.h"
#import "SWRevealViewController.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "TitleClass.h"
#import "BookmarksView.h"
#import "BoolmarksModel.h"
#import "OpenSubjectController.h"
#import "MeditationController.h"
#import "ViewNotification.h"
#import "NotificationController.h"


@implementation BookmarksController

- (void) viewDidLoad {
    
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = NO;
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"ЗАКЛАДКИ"];
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
    
    BookmarksView * backgroundView = [[BookmarksView alloc] initWithBackgroundView:self.view];
    [self.view addSubview:backgroundView];
    
    BookmarksView * viewContent = [[BookmarksView alloc] initWithContent:self.view andArray:[BoolmarksModel setArrayJuri]];
    [self.view addSubview:viewContent];
    
    NSString * stringText = @"У вас 5 новых уведомлений в разделе";
    NSString * stringTitle = @"\"Женские секреты\"";
    
    ViewNotification * viewNotification = [[ViewNotification alloc] initWithView:self.view andIDDel:self andTitleLabel:stringTitle andText:stringText];
    [self.view addSubview:viewNotification];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:NOTIFICATION_PUSH_BOOKMARKS_WITH_OPENSUBJECT object:nil];
    
    
    
    
    
}

#pragma mark - DEALLOC
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Action Methods

- (void) notificationAction: (NSNotification*) notification
{
    if ([notification.object isEqualToString:@"Медитации"]) {
        MeditationController * detail = [self.storyboard
                                         instantiateViewControllerWithIdentifier:@"MeditationController"];
        [self.navigationController pushViewController:detail animated:YES];
        
    } else {
    
    OpenSubjectController * detail = [self.storyboard
                                      instantiateViewControllerWithIdentifier:@"OpenSubjectController"];
    [self.navigationController pushViewController:detail animated:YES];
        
    }
}

- (void) pushNotificationWithNotification
{
    NotificationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationController"];
    [self.navigationController pushViewController:detail animated:YES];
}


@end
