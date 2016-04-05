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

@implementation SubCategoryController

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
    
    SubCategoryView * backgroundView = [[SubCategoryView alloc] initWithBackgroundView:self.view];
    [self.view addSubview:backgroundView];
    
    SubCategoryView * contentView = [[SubCategoryView alloc] initWithContent:self.view andArray:[SubCategoryModel setArraySubCategory]];
    [self.view addSubview:contentView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPushWithSubject) name:NOTIFICATION_SUB_CATEGORY_PUSH_TU_SUBCATEGORY object:nil];

}

- (void) notificationPushWithSubject
{
    SubjectViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"SubjectViewController"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
