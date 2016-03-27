//
//  ApplicationController.m
//  mykamchatka
//
//  Created by Viktor on 26.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "ApplicationController.h"
#import "SWRevealViewController.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "ApplicationView.h"
#import "TitleClass.h"

@implementation ApplicationController

#pragma mark - Title

- (void) viewDidLoad {
    
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithLiteTitle:@"ЗАЯВКА"];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"b3ddf4"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    //Пареметры кнопки меню------------------------------------
    UIImage *imageBarButton = [UIImage imageNamed:@"menuIcons.png"];
    [_buttonMenu setImage:imageBarButton];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 20, 20);
    [button setImage:imageBarButton forState:UIControlStateNormal];
    [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=button;
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.navigationController.navigationBar.hidden = NO; // спрятал navigation bar  
    
#pragma mark - Initialization
    
    //Подвязываем бэкграунд фон---------------------------------
    ApplicationView * applicationViewWithBackGround = [[ApplicationView alloc] initBackgroundWithView:self.view];
    [self.view addSubview:applicationViewWithBackGround];
    
    //Подвязываем остальные UI элементы------------------------
    ApplicationView * applicationView = [[ApplicationView alloc] initWithView:self.view];
    [self.view addSubview:applicationView];
    
}

@end
