//
//  ConnectWithUsController.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 29/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "ConnectWithUsController.h"
#import "ConnectWithUsView.h"

@interface ConnectWithUsController ()

@property (strong, nonatomic) NSArray * arrayData;

@end

@implementation ConnectWithUsController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"СВЯЗАТЬСЯ С НАМИ"]; //Ввод заголовка
    self.arrayData = [self setTravelArray];
    
    if (self.navigationController.viewControllers.count > 1) {
        //Кнопка Назад---------------------------------------------
        UIButton * buttonBack = [UIButton createButtonBack];
        [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
        self.navigationItem.leftBarButtonItem = mailbuttonBack;
    }
    
#pragma mark - View
    
    ConnectWithUsView * mainView = [[ConnectWithUsView alloc] initWithView:self.view andData:self.arrayData];
    [self.view addSubview:mainView];
    
}

#pragma mark - Custom Array
//создадим тестовый массив-----------
- (NSMutableArray *) setTravelArray
{
    NSMutableArray * mainArray = [[NSMutableArray alloc] init];

    return mainArray;
}

- (void) buttonBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
