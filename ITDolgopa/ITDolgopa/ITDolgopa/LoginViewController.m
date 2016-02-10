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
    

    
    
    
    
    
}

@end
