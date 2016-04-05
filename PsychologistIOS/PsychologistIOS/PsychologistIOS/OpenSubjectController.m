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

@implementation OpenSubjectController

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
    
    //Основной контент-----------------------------------------
    OpenSubjectView * mainContent = [[OpenSubjectView alloc] initWithView:self.view];
    [self.view addSubview:mainContent];
    

}

@end
