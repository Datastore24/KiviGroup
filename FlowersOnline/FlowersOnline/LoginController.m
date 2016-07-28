//
//  LoginController.m
//  FlowersOnline
//
//  Created by Viktor on 29.04.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "LoginController.h"
#import "UIColor+HexColor.h"
#import "TitleClass.h"
#import "ButtonMenu.h"
#import "LoginView.h"
#import "Macros.h"
#import "BouquetsController.h"

@implementation LoginController

- (void) viewDidLoad
{
    
#pragma mark - Header 
    
    //Рабочие нотификации-------------------------------------
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushBouquetsController) name:NOTIFICATION_LOGIN_VIEW_PUSH_BOUQUETS_CONTROLLER object:nil];
    
    self.navigationController.navigationBarHidden = YES;    
    //Пареметры кнопки меню------------------------------------
    UIButton * buttonMenu = [ButtonMenu createButtonMenu];
    [buttonMenu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=buttonMenu;
    //Заголовок--------------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"БУКЕТЫ"];
    self.navigationItem.titleView = title;
    
#pragma mark - Initialization
    LoginView * backgroundView = [[LoginView alloc] initBackGroundWithView:self.view];
    [self.view addSubview:backgroundView];
    
    LoginView * contentView = [[LoginView alloc] initContentWithView:self.view];
    [self.view addSubview:contentView];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notification Actions

//Метод нотификации перехода в раздел букетов------------------
- (void) pushBouquetsController
{
    BouquetsController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"BouquetsController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

@end
