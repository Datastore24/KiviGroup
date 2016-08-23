//
//  MessegerController.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 20/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "MessegerController.h"
#import "MessegerView.h"

@implementation MessegerController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"СООБЩЕНИЯ"]; //Ввод заголовка
    [self.navigationController setNavigationBarHidden:NO];
    
    
#pragma mark - View
    
    MessegerView * mainView = [[MessegerView alloc] initWithView:self.view andData:nil];
    [self.view addSubview:mainView];
    
}

@end
