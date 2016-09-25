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
#import "APIGetClass.h"
#import "SingleTone.h"
#import "Macros.h"
#import "BasketController.h"
#import "FormalizationController.h"
#import "AlertClassCustom.h"
#import "PopAnimator.h"
#import "PushAnimator.h"


@interface CatalogMainListController () <CatalogMainListViewDelegate, BottomBasketViewDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSArray * arrayCatalog;
@property (strong, nonatomic) CatalogMainListView * mainView;
@property (strong, nonatomic) BottomBasketView * basketView;

@end

@implementation CatalogMainListController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.delegate = self;
    CGRect rectView = self.mainView.frame;
    rectView.origin.y = 0.f;
    if ([[[SingleTone sharedManager] countType] integerValue] != 0) {
        rectView.size.height = self.view.frame.size.height - 50;
    } else {
        rectView.size.height = self.view.frame.size.height;
    }
    self.mainView.frame = rectView;
    self.mainView.tableCatalog.frame = rectView;
    
    self.basketView.labelButtonBasket.text = [NSString stringWithFormat:@"Итого %@ шт на %@ руб", [[SingleTone sharedManager] countType], [[SingleTone sharedManager] priceType]];
    if ([[[SingleTone sharedManager] countType] integerValue] != 0) {
        self.basketView.alpha = 1.f;
        self.buttonBasket.alpha = 1.f;
        self.buttonBasket.userInteractionEnabled = YES;
    }  else {
        self.basketView.alpha = 0.f;
        self.buttonBasket.alpha = 0.4;
        self.buttonBasket.userInteractionEnabled = NO;
    }

  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"Категории" andBarButtonAlpha: YES andButtonBasket: NO]; //Ввод заголовка
    //    [self.navigationController setNavigationBarHidden:NO];
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
    
#pragma mark - View
    
    [self getApiCatalog:^{
        self.mainView = [[CatalogMainListView alloc] initWithView:self.view andData:self.arrayCatalog];
        self.mainView.delegate = self;
        [self.view addSubview:self.mainView];
        
        self.basketView = [[BottomBasketView alloc] initBottomBasketViewWithPrice:[[SingleTone sharedManager] priceType] andCount:[[SingleTone sharedManager] countType] andView:self.view];
        self.basketView.delegate = self;
        if ([[[SingleTone sharedManager] countType] integerValue] != 0) {
            self.basketView.alpha = 1.f;
            self.buttonBasket.alpha = 1.f;
            self.buttonBasket.userInteractionEnabled = YES;
        } else {
            self.buttonBasket.alpha = 0.4;
            self.buttonBasket.userInteractionEnabled = NO;
        }
        [self.view addSubview:self.basketView];
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkOrder:) name:NOTIFICATION_CHECK_COUNT_ORDER object:nil];

    
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - CatalogMainListViewDelegate

- (void) pushToCatalogListController: (CatalogMainListView*) catalogMainListView andCatId:(NSString *) catID
                                andCatName:(NSString *) catName{
    CatalogListController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogListController"];
    detail.catID = catID;
    detail.catName = catName;
    [self.navigationController pushViewController:detail animated:YES];
}

-(void) getApiCatalog: (void (^)(void))block
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             @"0",@"cat",
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",nil];
    
    
    [api getDataFromServerWithParams:params method:@"cat_catalog" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            self.arrayCatalog = [respDict objectForKey:@"list"];
            
 
                block();
            
            
        }
        
    }];
    
}

#pragma mark - BottomBasketViewDelegate

- (void) actionBasket: (BottomBasketView*) bottomBasketView {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) actionFormalization: (BottomBasketView*) bottomBasketView {
    if ([[[SingleTone sharedManager] priceType] integerValue] < 1990) {
        [AlertClassCustom createAlertMinPrice];
    } else {
        FormalizationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"FormalizationController"];
        [self.navigationController pushViewController:detail animated:YES];
    }
}

#pragma mark - ANIMATION POP PUSH
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController*)fromVC
                                                 toViewController:(UIViewController*)toVC
{
    if (operation == UINavigationControllerOperationPush)
        return [[PushAnimator alloc] init];
    
    if (operation == UINavigationControllerOperationPop)
        return [[PopAnimator alloc] init];
    
    return nil;
}
        


@end
