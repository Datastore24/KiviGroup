//
//  LoginViewController.m
//  ITDolgopa
//
//  Created by Viktor on 04.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "Macros.h"

@implementation LoginViewController

- (void) viewDidLoad {
    [super viewDidLoad];

#pragma mark - initialization
    
//Добавляем UIЭлементы в приложение через кнтроллер-------------------------
    
    LoginView * loginView = [[LoginView alloc] initWithView:self.view andFont:MAINFONTLOGINVIEW];
    [self.view addSubview:loginView];
    
    
    
    
    
    
//    UILabel * labelTest = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 150, 30)];
//    labelTest.text = @"Телефон";
//    labelTest.textColor = [UIColor whiteColor];
//    [labelTest setFont:[UIFont fontWithName:@"SFUIDisplay-Light" size:20.0f]];
//    labelTest.center = loginView.center;
//    [loginView addSubview:labelTest];
    

    
    
    
    
    
}

@end
