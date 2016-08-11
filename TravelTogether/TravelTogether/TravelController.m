//
//  TravelController.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 07/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "TravelController.h"

@implementation TravelController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    //Пареметры кнопки меню------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * backButton =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = backButton;
    
    
    [self setCustomTitle:@"ПОПУТЧИКИ/РЕЙС RTX 5456"]; //Ввод заголовка
    [self.navigationController setNavigationBarHidden:NO];
    
}

- (void) backAction: (UIButton*) button {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
