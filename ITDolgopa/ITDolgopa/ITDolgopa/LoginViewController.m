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
    
    LoginView * loginView = [[LoginView alloc] initWithView:self.view];
    [self.view addSubview:loginView];
    
    
    
    
    
    
    UILabel * labelTest = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 90, 30)];
    labelTest.text = @"Телефон";
    labelTest.textColor = [UIColor whiteColor];
    [labelTest setFont:[UIFont fontWithName:@"SFUIText Light" size:25.0f]];
    labelTest.center = loginView.center;
    [loginView addSubview:labelTest];
    

    
    
    
    
    
}

@end
