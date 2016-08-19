//
//  CatalogListController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 19/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "CatalogListController.h"
#import "CatalogListView.h"
#import "CatalogDetailController.h"

@interface CatalogListController () <CatalogListViewDelegate>

@property (strong, nonatomic) NSMutableArray * arrayData;

@end

@implementation CatalogListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"Женская одежда" andBarButtonAlpha: YES]; //Ввод заголовка
    //    [self.navigationController setNavigationBarHidden:NO];
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    

#pragma mark - View
    
    self.arrayData = [self getCustomArray];
    
    CatalogListView * mainView = [[CatalogListView alloc] initWithView:self.view andData:self.arrayData];
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
    NSArray * arrayNameItem0 = [NSArray arrayWithObjects: @"Повседневная одежда", @"Белье и купальники", @"Верхняя одежда", @"Одежда для спорта", nil];
    NSArray * arrayCountItem0 = [NSArray arrayWithObjects:@"15", @"645", @"1286", @"3", nil];
    NSArray * array = [[NSArray alloc] init];
    NSArray * arrayCount = [[NSArray alloc] init];
    for (int i = 0; i < arrayNameItem0.count; i++) {
        
        if (i == 0) {
            array = [NSArray arrayWithObjects:
                     @"Блузки и кофточки", @"Платья", @"Футболки и топы", @"Домашняя одежда", @"Брюки", @"Юбки", @"Капри и приджи", @"Костюмы",
                     @"Шорты", @"Пиджаки", @"Джинсы", @"Толстовки", @"Комбинезоны", @"Жилеты", nil];
            arrayCount = [NSArray arrayWithObjects:@"890", @"813", @"330", @"177", @"140", @"132", @"71", @"41",
                          @"33", @"32", @"16", @"7", @"7", @"5", nil];
        } else if (i == 1) {
            array = [NSArray arrayWithObjects:@"Трусы", @"Пляжные платья и парео", nil];
            arrayCount = [NSArray arrayWithObjects:@"56", @"19", nil];
        } else if (i == 2) {
            array = [NSArray arrayWithObjects:@"Куртки", @"Накидки", @"Жилеты", nil];
            arrayCount = [NSArray arrayWithObjects:@"26", @"26", @"1", nil];
        } else if (i == 3) {
            array = [NSArray arrayWithObjects:@"Спортивные костюмы", nil];
            arrayCount = [NSArray arrayWithObjects:@"5", nil];
        }
        
        NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:
                               [arrayNameItem0 objectAtIndex:i], @"name",
                               [arrayCountItem0 objectAtIndex:i], @"count",
                               array, @"array", arrayCount, @"arrayCount", nil];
        
        [customArray addObject:dict];
    }
    
    return customArray;
    
}

#pragma mark - CatalogListViewDelegate

- (void) pushToCatalogDetail: (CatalogListView*) catalogListView {
    CatalogDetailController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogDetailController"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
