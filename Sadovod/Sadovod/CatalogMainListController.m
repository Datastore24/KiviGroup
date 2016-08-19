//
//  CatalogMainListController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 19/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "CatalogMainListController.h"
#import "CatalogMainListView.h"
#import "CatalogListController.h"

@interface CatalogMainListController () <CatalogMainListViewDelegate>

@property (strong, nonatomic) NSMutableArray * arrayData;

@end

@implementation CatalogMainListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"Категории" andBarButtonAlpha: YES]; //Ввод заголовка
    //    [self.navigationController setNavigationBarHidden:NO];
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
    
#pragma mark - View
    
    self.arrayData = [self getCustomArray];
    CatalogMainListView * mainView = [[CatalogMainListView alloc] initWithView:self.view andData:self.arrayData];
    mainView.delegate = self;
    [self.view addSubview:mainView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions
- (void)buttonBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray*) getCustomArray {
    NSMutableArray * customArray = [NSMutableArray array];
    NSArray * arrayNameItem0 = [NSArray arrayWithObjects:@"Женская одежда", @"Мужская одежда", @"Для девочек", @"Для мальчиков",
                                @"Для малышей", @"Обувь", @"Сумки и Чемоданы", @"Детский спорт", nil];
    NSArray * arrayCountItem0 = [NSArray arrayWithObjects:@"2777", @"538", @"138", @"53", @"1", @"182", @"3", @"2", nil];
    for (int i = 0; i < arrayNameItem0.count; i++) {
        NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:
                               [arrayNameItem0 objectAtIndex:i], @"name",
                               [arrayCountItem0 objectAtIndex:i], @"count", nil];
        
        [customArray addObject:dict];
    }
    return customArray;
}


#pragma mark - CatalogMainListViewDelegate

- (void) pushToCatalogListController: (CatalogMainListView*) catalogMainListView {
    CatalogListController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogListController"];
    [self.navigationController pushViewController:detail animated:YES];
}




@end
