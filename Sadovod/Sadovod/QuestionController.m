//
//  QuestionController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 08/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "QuestionController.h"
#import "CatalogController.h"
#import "QuestionView.h"
#import "SingleTone.h"


@implementation QuestionController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if ([[[SingleTone sharedManager] countType] isEqualToString:@"0"]) {
        self.mainViewOrder.alpha = 0.f;
    } else {
        self.mainViewOrder.alpha = 1.f;
    }
}
- (void) viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"Задать вопрос" andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
#pragma mark - View
    
    QuestionView * mainView = [[QuestionView alloc] initWithView:self.view andData:nil];
    [self.view addSubview:mainView];
    
    [self createMainBasketWithCount:@"4" andPrice:@"5700"];
}

#pragma mark - Actions

- (void) buttonBackAction {
    CatalogController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogController"];
    [self.navigationController pushViewController:detail animated:NO];
}

@end
