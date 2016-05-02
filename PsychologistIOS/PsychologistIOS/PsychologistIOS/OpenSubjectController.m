//
//  OpenSubjectController.m
//  PsychologistIOS
//
//  Created by Viktor on 05.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "OpenSubjectController.h"
#import "SWRevealViewController.h"
#import "TitleClass.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "SingleTone.h"
#import "OpenSubjectView.h"
#import "OpenSubjectModel.h"
#import "DiscussionsController.h"
#import "APIGetClass.h"

@implementation OpenSubjectController
{
    NSDictionary * dictResponse;
}

- (void) viewDidLoad
{
#pragma mark - Header
    
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:[[[SingleTone sharedManager] titleSubject] uppercaseString]];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"d46559"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
#pragma mark - Initialization
    
    [self getAPIWithBlock:^{
        NSDictionary * mainDict = [dictResponse objectForKey:@"data"];
        //Основной контент-----------------------------------------
        OpenSubjectView * mainContent = [[OpenSubjectView alloc] initWithView:self.view andDict:mainDict];
        [self.view addSubview:mainContent];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPushWithDiscussions) name:NOTIFICATION_OPEN_SUBJECT_PUSH_TU_DISCUSSIONS object:nil];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - ACTION METHODS

- (void) notificationPushWithDiscussions
{
    DiscussionsController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"DiscussionsController"];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - API

- (void) getAPIWithBlock: (void (^)(void))block
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:[[SingleTone sharedManager] identifierSubjectModel], @"id",  nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"show_post" complitionBlock:^(id response) {
        
        dictResponse = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            block();
        }
    }];
}

@end
