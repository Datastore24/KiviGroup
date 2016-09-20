//
//  SizesController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 13.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "SizesController.h"
#import "CatalogController.h"
#import "SizesView.h"
#import "SingleTone.h"

@implementation SizesController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

}

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"Таблица размеров" andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
#pragma mark - View
    
    SizesView * mainView = [[SizesView alloc] initWithView:self.view andData:nil];
    [self.view addSubview:mainView];
    

    
}

#pragma mark - Actions

- (void) buttonBackAction {
    CatalogController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogController"];
    [self.navigationController pushViewController:detail animated:NO];
}


@end
