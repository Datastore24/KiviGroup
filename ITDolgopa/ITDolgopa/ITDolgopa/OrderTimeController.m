//
//  OrderTimeController.m
//  ITDolgopa
//
//  Created by Viktor on 20.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "OrderTimeController.h"
#import "TitleClass.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "SWRevealViewController.h"

@implementation OrderTimeController

- (void) viewDidLoad
{
#pragma mark - initialization
    
    self.navigationController.navigationBar.layer.cornerRadius=5;
    self.navigationController.navigationBar.clipsToBounds=YES;
    
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"ЗАБРОНИРОВАТЬ ВРЕМЯ"];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:MAINCOLORBUTTONLOGIN];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    //Отключаем основной цвет----------------------------------
    
    
    //Пареметры кнопки меню------------------------------------
    UIImage *imageBarButton = [UIImage imageNamed:@"menuIcon.png"];
    [_buttonMenu setImage:imageBarButton];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake( 0, 0, 30, 30);
    [button setImage:imageBarButton forState:UIControlStateNormal];
    [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=button;
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.navigationController.navigationBar.hidden = NO; // спрятал navigation bar
    
    self.view.backgroundColor = [UIColor colorWithHexString:MAINBACKGROUNDCOLOR];
}

@end
