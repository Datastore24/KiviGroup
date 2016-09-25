//
//  OrderController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 22/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "OrderController.h"
#import "OrderView.h"
#import "BuyViewController.h"
#import "APIGetClass.h"
#import "SingleTone.h"
#import "Macros.h"
#import "BasketController.h"
#import "FormalizationController.h"
#import "AlertClassCustom.h"
#import "AuthorizationController.h"
#import "PopAnimator.h"
#import "PushAnimator.h"
#import "GaleryView.h"

@interface OrderController () <OrderViewDelegate, BottomBasketViewDelegate, UINavigationControllerDelegate, GaleryViewDelegate>

@property (strong, nonatomic) NSDictionary * arrayData;

@property (strong, nonatomic) OrderView * mainView;
@property (strong, nonatomic) BottomBasketView * basketView;
@property (strong, nonatomic) NSArray * arrayCart;
@property (strong, nonatomic) GaleryView * galeryView;

@end

@implementation OrderController


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.navigationController.delegate = self;
    CGRect rectView = self.mainView.frame;
    rectView.origin.y = 0;
    rectView.size.height = self.view.frame.size.height;
    self.mainView.frame = rectView;
    self.mainView.mainScrollView.frame = rectView;
    
    self.basketView.labelButtonBasket.text = [NSString stringWithFormat:@"Итого %@ шт на %@ руб", [[SingleTone sharedManager] countType], [[SingleTone sharedManager] priceType]];
    if ([[[SingleTone sharedManager] countType] integerValue] != 0) {
        self.basketView.alpha = 1.f;
        self.mainView.mainScrollView.contentSize = CGSizeMake(0, 1060);
        self.buttonBasket.alpha = 1.f;
        self.buttonBasket.userInteractionEnabled = YES;
    } else {
        self.basketView.alpha = 0.f;
        self.mainView.mainScrollView.contentSize = CGSizeMake(0, 1010);
        self.buttonBasket.alpha = 0.4f;
        self.buttonBasket.userInteractionEnabled = NO;
    }

}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomTitle:self.productName andBarButtonAlpha: YES andButtonBasket: NO]; //Ввод
     [self initializeCartBarButton]; //Инициализация кнопок навигации
    //    [self.navigationController setNavigationBarHidden:NO];
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
    
    
#pragma mark - View
    [self getApiProduct:^{
        self.mainView = [[OrderView alloc] initWithView:self.view andData:self.arrayData andCart:self.arrayCart];
        self.mainView.delegate = self;
        [self.view addSubview:self.mainView];
        
        self.basketView = [[BottomBasketView alloc] initBottomBasketViewWithPrice:[[SingleTone sharedManager] priceType] andCount:[[SingleTone sharedManager] countType] andView:self.view];
        self.basketView.delegate = self;
        if ([[[SingleTone sharedManager] countType] integerValue] != 0) {
            self.basketView.alpha = 1.f;
        }
        [self.view addSubview:self.basketView];
        
        self.galeryView = [[GaleryView alloc] initWithView:self.view andData:self.arrayData];
        self.galeryView.delegate = self;
        self.galeryView.alpha = 0.f;
        [self.view addSubview:self.galeryView];
        

    } andProductID:self.productID];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkOrder:) name:NOTIFICATION_CHECK_COUNT_ORDER object:nil];
   
    
    //Параметры кнопки корзины
    self.buttonBasket.alpha = 0.4;
    self.buttonBasket.userInteractionEnabled = NO;
    
}

#pragma mark - OrderViewDelegate

- (void) pushTuBiyView: (OrderView*) orderView{
    BuyViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"BuyViewController"];
    detail.productID = self.productID;
    detail.productName = self.productName;
    detail.productPrice = self.productPrice;
    [self.navigationController pushViewController:detail animated:NO];
}

- (void) getApiAddCart: (OrderView*) orderView andProductID: (NSString *) productID
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",
                             productID,@"size",
  
                             nil];
    
    [api getDataFromServerWithParams:params method:@"buy_product_add" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            

        }
    }];
}

- (void) showGalery: (OrderView*) orderView {
    [UIView animateWithDuration:0.3 animations:^{
        self.galeryView.alpha = 1.f;
    }];
}

- (void) showBottomBar: (OrderView*) orderView {
    self.basketView.labelButtonBasket.text = [NSString stringWithFormat:@"Итого %@ шт на %@ руб", [[SingleTone sharedManager] countType], [[SingleTone sharedManager] priceType]];
    [UIView animateWithDuration:0.3 animations:^{
        self.basketView.alpha = 1.f;
    } completion:^(BOOL finished) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SHOW_BASKET_VIEW object:nil];
    }];

}

-(void) getApiCart: (OrderView*) orderView  andBlock:(void (^)(void))block andProductID: (NSString *) productID
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",
                             productID,@"product",
                             nil];
    
    [api getDataFromServerWithParams:params method:@"get_sizes_product_buy" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            
            
            
            self.arrayCartNew = [respDict objectForKey:@"list"] ;
            
            block();
            
            
        }
        
    }];
    
}

- (void) pushAuthorization: (OrderView*) orderView {
    AuthorizationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"AuthorizationController"];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - Actions

- (void) buttonBackAction {
    [self.navigationController popViewControllerAnimated:NO];
}



- (void) checkOrder: (NSNotification*) notification {
    //Параметры кнопки корзины
    self.buttonBasket.alpha = 1.;
    self.buttonBasket.userInteractionEnabled = YES;
}

#pragma  mark - API


-(void) getApiProduct: (void (^)(void))block andProductID: (NSString *) productID
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",
                             productID,@"product",
                             nil];
    
    [api getDataFromServerWithParams:params method:@"product" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            
            self.arrayData = [respDict objectForKey:@"product"];
            
            [self getApiCart:^{
                 block();
            } andProductID:productID];
           
            
            
        }
        
    }];
    
}

-(void) getApiCart: (void (^)(void))block andProductID: (NSString *) productID
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",
                             productID,@"product",
                             nil];
    
    [api getDataFromServerWithParams:params method:@"get_sizes_product_buy" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            
            
            
            self.arrayCart = [respDict objectForKey:@"list"] ;
            
            block();
            
            
        }
        
    }];
    
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

#pragma mark - GaleryViewDelegate 

- (void) hideGaleryView: (GaleryView*) galeryView {
    [UIView animateWithDuration:0.3 animations:^{
        [self.galeryView setAlpha:0.f];
    }];
}


@end
