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
#import "APIGetClass.h"
#import "SingleTone.h"
#import "Macros.h"
#import "BasketController.h"
#import "FormalizationController.h"

@interface CatalogListController () <CatalogListViewDelegate, BottomBasketViewDelegate>

@property (strong, nonatomic) NSArray * arrayCatalog;
@property (strong, nonatomic) CatalogListView * mainView;
@property (strong, nonatomic) BottomBasketView * basketView;


@end

@implementation CatalogListController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    CGRect rectView = self.mainView.frame;
    rectView.origin.y = 0.f;
    if ([[[SingleTone sharedManager] countType] integerValue] != 0) {
        rectView.size.height = self.view.frame.size.height - 50;
    } else {
        rectView.size.height = self.view.frame.size.height;
    }
    self.mainView.frame = rectView;
    self.mainView.tableCatalog.frame = rectView;
    
    


}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:self.catName andBarButtonAlpha: YES andButtonBasket: NO]; //Ввод заголовка
    //    [self.navigationController setNavigationBarHidden:NO];
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    

#pragma mark - View

    [self getApiCatalog:^{
        self.mainView = [[CatalogListView alloc] initWithView:self.view andData:self.arrayCatalog];
        self.mainView.delegate = self;
        [self.view addSubview:self.mainView];
        
        self.basketView = [[BottomBasketView alloc] initBottomBasketViewWithPrice:@"700" andCount:[[SingleTone sharedManager] countType] andView:self.view];
        self.basketView.delegate = self;
        if ([[[SingleTone sharedManager] countType] integerValue] != 0) {
            self.basketView.alpha = 1.f;
        }
        [self.view addSubview:self.basketView];
        

    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkOrder:) name:NOTIFICATION_CHECK_COUNT_ORDER object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showBasketView:) name:NOTIFICATION_SHOW_BASKET_VIEW object:nil];
    
    //Параметры кнопки корзины
    self.buttonBasket.alpha = 0.4;
    self.buttonBasket.userInteractionEnabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showBasketView: (NSNotification*) notification {
    self.basketView.labelButtonBasket.text = [NSString stringWithFormat:@"Итого %@ шт на %@ руб", [[SingleTone sharedManager] countType], @"700"];
    self.basketView.alpha = 1.f;
    
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Actions
- (void)buttonBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) checkOrder: (NSNotification*) notification {
    //Параметры кнопки корзины
    self.buttonBasket.alpha = 1.;
    self.buttonBasket.userInteractionEnabled = YES;
}


#pragma mark - API

-(void) getApiCatalog: (void (^)(void))block
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             self.catID,@"cat",
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",nil];
    
    
    [api getDataFromServerWithParams:params method:@"get_tree_by_catalog" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            self.arrayCatalog = [respDict objectForKey:@"tree"];
            
        
            block();
            
            
        }
        
    }];
    
}

#pragma mark - CatalogListViewDelegate

- (void) pushToCatalogDetail: (CatalogListView*) catalogListView andCatId:(NSString *) catID
                                                        andCatName:(NSString *) catName{
    CatalogDetailController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogDetailController"];
    detail.catID=catID;
    detail.catName=catName;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - BottomBasketViewDelegate

- (void) actionBasket: (BottomBasketView*) bottomBasketView {
    BasketController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"BasketController"];
    [self.navigationController pushViewController:detail animated:YES];
}
- (void) actionFormalization: (BottomBasketView*) bottomBasketView {
    FormalizationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"FormalizationController"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
