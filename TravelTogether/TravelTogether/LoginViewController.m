//
//  LoginViewController.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 02/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "UIView+BorderView.h"
#import "MyTravelController.h"

@interface LoginViewController () <LoginViewDelegate>

@property (strong, nonatomic) NSArray * arrayData;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"ЛОГИН"]; //Ввод заголовка
    [self.navigationController setNavigationBarHidden:YES];
    
    NSArray * arrayNames = [NSArray arrayWithObjects:@"Имя", @"Email", @"Город", nil];
    NSArray * arrayImages = [NSArray arrayWithObjects:@"nameLogin.png", @"emailLogin.png", @"mapLogin.png", nil];
    NSArray * arrayImagesNetwork = [NSArray arrayWithObjects:@"imageSocNet1.png", @"imageSocNet2.png", @"imageSocNet3.png", @"imageSocNet4.png", nil];
    self.arrayData = [NSArray arrayWithObjects:arrayNames, arrayImages, arrayImagesNetwork, nil];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [UIView backgroundViewWithView:self.view andImageName:@"logoImage.png"]; //Загрузка беграунда
    LoginView * loginView = [[LoginView alloc] initMainViewMethodWithView:self.view andData:self.arrayData]; //Загрузка основного вью
    loginView.delegate = self;
    [self.view addSubview:loginView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LoginViewDelegate
- (void) buttonLoginActionWithLoginView: (LoginView*) loginView {
    MyTravelController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"MyTravelController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) tapOnTermsOfUseWithLoginView: (LoginView*) loginView {
    NSLog(@"Пользовательское соглашение");
    
}
- (void) tapPrivacyPolicyWithLoginView: (LoginView*) loginView {
    NSLog(@"Политики конфиденциальности");
}

@end
