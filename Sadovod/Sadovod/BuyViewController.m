//
//  BuyViewController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 26/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "BuyViewController.h"
#import "BuyView.h"
#import "Macros.h"
#import "HexColors.h"
#import "BasketController.h"
#import "FormalizationController.h"
#import "SingleTone.h"
#import "FormalizationController.h"
#import "BasketController.h"
#import "SingleTone.h"
#import "APIGetClass.h"

@interface BuyViewController () <BuyViewDelegate, BottomBasketViewDelegate>

@property (strong, nonatomic) UILabel * label;
@property (strong, nonatomic) NSArray * arrayData;
@property (strong, nonatomic) NSArray * arrayCart;
@property (strong, nonatomic) BottomBasketView * basketView;

@end

@implementation BuyViewController

//Кастомный лейбл наносится на верхний бар
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

    if (self.label == nil) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 80, 24, 80, 40)];
        self.label.text = [NSString stringWithFormat:@"%@ руб",self.productPrice];
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        [self.navigationController.view.window addSubview:self.label];
    } else {
        self.label.alpha = 1.f;
    }
}

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:self.productName andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
   
    [self getApiProduct:^{
        

        BuyView * mainView = [[BuyView alloc] initWithView:self.view andData:self.arrayData andCart:self.arrayCart];
        mainView.deleagte = self;
        [self.view addSubview:mainView];
        
    } andProductID:self.productID];
    
#pragma mark - View
    
    
    
    self.basketView = [[BottomBasketView alloc] initBottomBasketViewWithPrice:@"700" andCount:[[SingleTone sharedManager] countType] andView:self.view];
    self.basketView.delegate = self;
    if ([[[SingleTone sharedManager] countType] integerValue] != 0) {
        self.basketView.alpha = 1.f;
    }
    [self.view addSubview:self.basketView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showBasketView:) name:NOTIFICATION_SHOW_BASKET_VIEW object:nil];
    
}

- (void) showBasketView: (NSNotification*) notification {
    self.basketView.labelButtonBasket.text = [NSString stringWithFormat:@"Итого %@ шт на %@ руб", [[SingleTone sharedManager] countType], @"700"];
    self.basketView.alpha = 1.f;
    
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    
    self.label.alpha = 0.f;
    
}


#pragma mark - Actions

- (void) buttonBackAction {
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - BuyViewDelegate

- (void) addCountOrder: (BuyView*) buyView {
//    self.mainViewOrder.alpha = 1.f;
}

- (void) hideCountOrder: (BuyView*) buyView {
//    self.mainViewOrder.alpha = 0.f;
}



//Тестовые селекторы для переходов в корзину и оформление
- (void) buttonBasketAction {
    BasketController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"BasketController"];
    [self.navigationController pushViewController:detail animated:NO];
}

- (void) buttonContentsAction {
    FormalizationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"FormalizationController"];
    [self.navigationController pushViewController:detail animated:NO];
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

-(void) getApiAddToBasket: (NSString *) productID
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
            
            
            NSLog(@"RESP %@",respDict);
            
            
        }
        
    }];
    
}

-(void) getApiDelToBasket: (NSString *) productID
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",
                             productID,@"size",
                             nil];
    
    [api getDataFromServerWithParams:params method:@"buy_product_del" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            
            
            NSLog(@"RESP %@",respDict);
            
            
        }
        
    }];
    
}

#pragma mark - API

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
            
            
            self.arrayData = [[respDict objectForKey:@"product"] objectForKey:@"sizes"];
            
            [self getApiCart:^{
                block();
            }];

        }
        
    }];
    
}

-(void) getApiCart: (void (^)(void))block
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",
                             nil];
    
    [api getDataFromServerWithParams:params method:@"cart_info_detail" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            
           
            
            self.arrayCart = [respDict objectForKey:@"list"] ;
            
            
            block();
            
            
        }
        
    }];
    
}


 
@end
