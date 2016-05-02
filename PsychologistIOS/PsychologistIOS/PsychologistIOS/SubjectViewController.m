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
#import "SubjectModel.h"
#import "SingleTone.h"
#import "Macros.h"
#import "OpenSubjectController.h"
#import "APIGetClass.h"

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
        NSArray * mainArray = [NSArray arrayWithArray:[dictResponse objectForKey:@"data"]];
        NSLog(@"%@", mainArray);
        SubjectView * contentView = [[SubjectView alloc] initWithContent:self.view andArray:mainArray];
        [self.view addSubview:contentView];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPushWithOpenSubject:) name:NOTIFICATION_SUBJECT_PUSH_TU_SUBCATEGORY object:nil];
}

- (void) notificationPushWithOpenSubject: (NSNotification*) notification
{
        NSLog(@"Текст");
        OpenSubjectController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"OpenSubjectController"];
        [self.navigationController pushViewController:detail animated:YES];

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

@end
