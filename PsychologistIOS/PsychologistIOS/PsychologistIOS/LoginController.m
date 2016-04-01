//
//  LoginController.m
//  PsychologistIOS
//
//  Created by Viktor on 31.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "LoginController.h"
#import "SWRevealViewController.h"
#import "LoginView.h"
#import "Macros.h"
#import "CategoryController.h"

@implementation LoginController

- (void) viewDidLoad
{
    
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = YES;
       
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;

    //Пареметры кнопки меню------------------------------------
    UIImage *imageBarButton = [UIImage imageNamed:@"menuIcon.png"];
    [_buttonMenu setImage:imageBarButton];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 32, 24);
    CGRect rect = button.frame;
    rect.origin.y += 16;
    button.frame = rect;
    [button setImage:imageBarButton forState:UIControlStateNormal];
    [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=button;
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.navigationController.navigationBar.hidden = NO; // спрятал navigation bar
    
#pragma mark - Initialization
    //Основной фон-------------------------------------
    LoginView * backgroundView = [[LoginView alloc] initWithBackgroundView:self.view];
    [self.view addSubview:backgroundView];
    
    //Основные графические элементы--------------------
    LoginView * mainContentView = [[LoginView alloc] initWithContentView:self.view];
    [self.view addSubview:mainContentView];
    
    LoginView * buttonLigin = [[LoginView alloc] initButtonLogin];
    [mainContentView addSubview:buttonLigin];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushWithMainView) name:NOTIFICATION_LOGIN_VIEW_PUSH_MAIN_VIEW object:nil];

}

#pragma mark - action Methods

- (void) pushWithMainView
{
    UITextField * textFildSMS = (UITextField*)[self.view viewWithTag:120];
    
    if (textFildSMS.text.length < 5) {
        NSLog(@"%lu", textFildSMS.text.length);
    } else {
    CategoryController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryController"];
    [self.navigationController pushViewController:detail animated:YES];
}
}
@end
