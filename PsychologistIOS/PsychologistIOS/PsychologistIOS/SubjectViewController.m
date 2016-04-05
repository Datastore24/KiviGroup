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

@implementation SubjectViewController

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
    
    SubjectView * contentView = [[SubjectView alloc] initWithContent:self.view andArray:[SubjectModel setArraySubject]];
    [self.view addSubview:contentView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPushWithOpenSubject) name:NOTIFICATION_SUBJECT_PUSH_TU_SUBCATEGORY object:nil];
}

- (void) notificationPushWithOpenSubject
{
    OpenSubjectController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"OpenSubjectController"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
