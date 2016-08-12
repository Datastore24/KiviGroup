//
//  CatalogController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 12/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "CatalogController.h"

@interface CatalogController ()

@end

@implementation CatalogController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"Южные Ворота"]; //Ввод заголовка
//    [self.navigationController setNavigationBarHidden:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
