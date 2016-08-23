//
//  CatalogDetailController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 19/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "CatalogDetailController.h"
#import "CatalogDetailView.h"
#import "OrderController.h"

@interface CatalogDetailController () <CatalogDetailViewDelegate>

@property (strong, nonatomic) NSArray * arrayData;

@end

@implementation CatalogDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"Блузки и кофточки" andBarButtonAlpha: YES]; //Ввод заголовка
    //    [self.navigationController setNavigationBarHidden:NO];
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
    self.arrayData = [self setCustonArray];
    
#pragma mark - View
    CatalogDetailView * mainView = [[CatalogDetailView alloc] initWithView:self.view andData:self.arrayData];
    mainView.delegate = self;
    [self.view addSubview:mainView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void) buttonBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - CatalogDetailViewDelegate

- (void) PushToOrderController: (CatalogDetailView*) catalogDetailView {
    OrderController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (NSMutableArray*) setCustonArray
{
    NSArray * arrayImage = [NSArray arrayWithObjects:
                            @"imageProduct1.jpg", @"imageProduct2.jpg", @"imageProduct3.jpg", @"imageProduct4.jpg",
                            @"imageProduct5.jpg", @"imageProduct6.jpg", @"imageProduct7.jpg", @"imageProduct8.jpg",
                            @"imageProduct9.jpg", @"imageProduct10.jpg", nil];
    NSArray * arrayPrice = [NSArray arrayWithObjects:@"216", @"310", @"525", @"673", @"558", @"138", @"385", @"134", @"245", @"384", nil];
    NSMutableArray * mArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < arrayImage.count; i++) {
        NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[arrayImage objectAtIndex:i], @"image", [arrayPrice objectAtIndex:i], @"price", nil];
        [mArray addObject:dict];
    }
    
    return mArray;
}


@end
