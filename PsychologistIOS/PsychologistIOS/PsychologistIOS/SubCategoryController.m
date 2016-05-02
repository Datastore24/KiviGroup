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
#import "SubCategoryModel.h"
#import "Macros.h"
#import "SubjectViewController.h"
#import "APIGetClass.h"

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
        NSArray * arrayMainResponce = [NSArray arrayWithArray:[dictResponse objectForKey:@"data"]];
        SubCategoryView * contentView = [[SubCategoryView alloc] initWithContent:self.view andArray:arrayMainResponce];
        [self.view addSubview:contentView];
        
    }];
    
    SubCategoryView * backgroundView = [[SubCategoryView alloc] initWithBackgroundView:self.view];
    [self.view addSubview:backgroundView];
    

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPushWithSubject) name:NOTIFICATION_SUB_CATEGORY_PUSH_TU_SUBCATEGORY object:nil];

}

- (void) notificationPushWithSubject
{
    SubjectViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"SubjectViewController"];
    [self.navigationController pushViewController:detail animated:YES];
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

@end
