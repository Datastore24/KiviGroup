//
//  CatalogController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 12/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "CatalogController.h"
#import "CatalogView.h"
#import "CatalogMainListController.h"
#import "APIGetClass.h"
#import "SingleTone.h"
#import "OrderController.h"

#import "Auth.h"
#import "AuthDbClass.h"
#import "APIGetClass.h"
#import "Macros.h"
#import "BottomBasketView.h"
#import "FormalizationController.h"
#import "BasketController.h"
#import "AlertClassCustom.h"


@interface CatalogController () <CatalogViewDelegate, BottomBasketViewDelegate>

@property (strong, nonatomic) BottomBasketView * basketView;


@end

@implementation CatalogController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.basketView.labelButtonBasket.text = [NSString stringWithFormat:@"Итого %@ шт на %@ руб", [[SingleTone sharedManager] countType], @"700"];
    if ([[[SingleTone sharedManager] countType] integerValue] != 0) {
        self.basketView.alpha = 1.f;
    } else {
        self.basketView.alpha = 0.f;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayProduct = [NSArray new];
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"Садовод" andBarButtonAlpha: NO andButtonBasket: NO]; //Ввод заголовка

    
#pragma mark - View
    [self getKey:^{
        [self getApiName:^{
            CatalogView * mainView = [[CatalogView alloc] initWithView:self.view andData:self.arrayProduct andName:self.arrayName];
            mainView.delegate = self;
            [self.view addSubview:mainView];
            
            self.basketView = [[BottomBasketView alloc] initBottomBasketViewWithPrice:@"700" andCount:[[SingleTone sharedManager] countType] andView:self.view];
            self.basketView.delegate = self;
            if ([[[SingleTone sharedManager] countType] integerValue] != 0) {
                self.basketView.alpha = 1.f;
            }
            [self.view addSubview:self.basketView];
        }];
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkOrder:) name:NOTIFICATION_CHECK_COUNT_ORDER object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showBasketView:) name:NOTIFICATION_SHOW_BASKET_VIEW object:nil];
    
    //Параметры кнопки корзины
    self.buttonBasket.alpha = 0.4;
    self.buttonBasket.userInteractionEnabled = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) checkOrder: (NSNotification*) notification {
    //Параметры кнопки корзины
    self.buttonBasket.alpha = 1.;
    self.buttonBasket.userInteractionEnabled = YES;
}





#pragma mark - CatalogViewDelegate

- (void) getCatalog: (CatalogView*) catalogView {
    CatalogMainListController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogMainListController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) pushToBuyView: (CatalogView*) catalogView andProductID:(NSString *) productID
       andProductPrice:(NSString *) productPrice
        andProductName:(NSString *) productName {
    OrderController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderController"];
    detail.productID = productID;
    detail.productName = productName;
    detail.productPrice = productPrice;
    
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - API

-(void) getKey: (void (^)(void))block{
    AuthDbClass * authDbClass = [[AuthDbClass alloc] init];
    NSArray * arrayUser = [authDbClass showAllUsers]; //Массив данных CoreData
    NSDictionary * params;
    if(arrayUser.count>0){
        Auth * authCoreData = [arrayUser objectAtIndex:0];
        
        params = [[NSDictionary alloc] initWithObjectsAndKeys: authCoreData.superkey, @"super_key",
                  authCoreData.catalogkey,@"catalog_key", nil];
    }else{
        params = nil;
    }
    
    APIGetClass * api = [APIGetClass new]; //Создаем экземпляр API
    [api getDataFromServerWithParams:params method:@"check_keys" complitionBlock:^(id response) {
        
        
        NSDictionary * respDict =(NSDictionary *) response;
        NSLog(@"TOKENS %@",respDict);
        [authDbClass checkKey:[respDict objectForKey:@"super_key"] andCatalogKey:[respDict objectForKey:@"catalog_key"]];
        
        [[SingleTone sharedManager] setSuperKey:[respDict objectForKey:@"super_key"]];
        [[SingleTone sharedManager] setCatalogKey:[respDict objectForKey:@"catalog_key"]];
        
        
        
        block();
    }];
    
}

-(void) getApiName: (void (^)(void))block
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                    [[SingleTone sharedManager] catalogKey], @"token",
                    @"ios_sadovod",@"appname",nil];
   
    
    [api getDataFromServerWithParams:params method:@"guest_index" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            self.arrayName = [respDict objectForKey:@"list"];
                NSString * catID = [[self.arrayName objectAtIndex:0] objectForKey:@"cat"];
                [self getApiTabProducts:catID andPage:@"1" andBlock:^{
                    block();
                }];
        }
    }];
}

- (void) getApiTabProducts:(NSString *) cat andPage: (NSString *) page
                  andBlock:(void (^)(void))block
{
    
 
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",
                             cat, @"cat",
                             page, @"page",
                             nil];
    
    [api getDataFromServerWithParams:params method:@"get_tab_products" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            
            if([response isKindOfClass:[NSDictionary class]]){
                self.arrayProduct =[respDict objectForKey:@"list"];
              
                block();
            }else{
                NSLog(@"Пришел не Dictionary");
            }
        }

    }];
}

#pragma mark - BottomBasketViewDelegate

- (void) actionBasket: (BottomBasketView*) bottomBasketView {
    BasketController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"BasketController"];
    [self.navigationController pushViewController:detail animated:YES];
}
- (void) actionFormalization: (BottomBasketView*) bottomBasketView {
    if ([[[SingleTone sharedManager] priceType] integerValue] < 1990) {
        [AlertClassCustom createAlertMinPrice];
    } else {
    FormalizationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"FormalizationController"];
    [self.navigationController pushViewController:detail animated:YES];
    }
}

@end
