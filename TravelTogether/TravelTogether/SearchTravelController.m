//
//  SearchTravelController.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 04/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "SearchTravelController.h"
#import "SearchTravelView.h"

@implementation SearchTravelController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"ИСКАТЬ ПОПУТЧИКОВ"]; //Ввод заголовка
    [self.navigationController setNavigationBarHidden:NO];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];    
    
    SearchTravelView * mainView = [[SearchTravelView alloc] initMainViewSearchTravelWithView:self.view];
    [self.view addSubview:mainView];
    
}

@end
