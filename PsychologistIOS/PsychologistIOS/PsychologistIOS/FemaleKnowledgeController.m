//
//  FemaleKnowledgeController.m
//  PsychologistIOS
//
//  Created by Viktor on 16.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "FemaleKnowledgeController.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "TitleClass.h"
#import "FemaleKnowledgeView.h"
#import "SubCategoryView.h"
#import "ModelFemale.h"
#import "ChatController.h"

@implementation FemaleKnowledgeController

- (void) viewDidLoad
{
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = NO;
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"КЛАДОВАЯ ЖЕНСКИХ ЗНАНИЙ"];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"d46559"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
#pragma mark - Initialization
    
    //Бэкганд-----------------------------------------------
    SubCategoryView * backgroundView = [[SubCategoryView alloc] initWithBackgroundView:self.view];
    [self.view addSubview:backgroundView];
    
    //Основной контент----------------------------------------
    FemaleKnowledgeView * viewContent = [[FemaleKnowledgeView alloc] initWithView:self.view andArray:[ModelFemale setArrayNotification]];
    [self.view addSubview:viewContent];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPushWithChat) name:NOTIFICATION_PUSH_FAMELE_WITH_CHAT object:nil];
    
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Action Methods

- (void) notificationPushWithChat
{
    ChatController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatController"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
