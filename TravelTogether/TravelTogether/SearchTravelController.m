//
//  SearchTravelController.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 04/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "SearchTravelController.h"
#import "SearchTravelView.h"
#import "SearchDetailController.h"

@interface SearchTravelController () <SearchTravelViewDelegate>

@end

@implementation SearchTravelController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"ИСКАТЬ ПОПУТЧИКОВ"]; //Ввод заголовка
    [self.navigationController setNavigationBarHidden:NO];
    
    SearchTravelView * mainView = [[SearchTravelView alloc] initMainViewSearchTravelWithView:self.view];
    mainView.delegate = self;
    [self.view addSubview:mainView];
    
}

#pragma mark - SearchTravelViewDelegate

- (void) pushToSearchList: (SearchTravelView*) searchTravelView
{    
    SearchDetailController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchDetailController"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
