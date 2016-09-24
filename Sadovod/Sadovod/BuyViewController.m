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
#import "AlertClassCustom.h"
#import "PopAnimator.h"
#import "PushAnimator.h"

@interface BuyViewController () <BuyViewDelegate, BottomBasketViewDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UILabel * label;
@property (strong, nonatomic) NSArray * arrayData;
@property (strong, nonatomic) NSArray * arrayCart;
@property (strong, nonatomic) BottomBasketView * basketView;
@property (strong, nonatomic) BuyView * mainView;

@end

@implementation BuyViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_SIZE_APPLY" object:nil];
    
}

//Кастомный лейбл наносится на верхний бар
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
    self.mainView.tableSize.frame = rectView;

    if (self.label == nil) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 80, 24, 80, 40)];
        self.label.text = [NSString stringWithFormat:@"%@ руб",self.productPrice];
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        [self.navigationController.view.window addSubview:self.label];
    } else {
        self.label.alpha = 1.f;
    } 
    
    self.basketView.labelButtonBasket.text = [NSString stringWithFormat:@"Итого %@ шт на %@ руб", [[SingleTone sharedManager] countType], [[SingleTone sharedManager] priceType]];
    if ([[[SingleTone sharedManager] countType] integerValue] != 0) {
        self.basketView.alpha = 1.f;
    }  else {
        self.basketView.alpha = 0.f;
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
        

        self.mainView = [[BuyView alloc] initWithView:self.view andData:self.arrayData andCart:self.arrayCart];
        self.mainView.deleagte = self;
        [self.view addSubview:self.mainView];
        
        self.basketView = [[BottomBasketView alloc] initBottomBasketViewWithPrice:[[SingleTone sharedManager] priceType] andCount:[[SingleTone sharedManager] countType] andView:self.view];
        self.basketView.delegate = self;
        if ([[[SingleTone sharedManager] countType] integerValue] != 0) {
            self.basketView.alpha = 1.f;
        }
        [self.view addSubview:self.basketView];
        
    } andProductID:self.productID];
    
#pragma mark - View
    
    
    

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showBasketView:) name:NOTIFICATION_SHOW_BASKET_VIEW object:nil];
    
}

- (void) showBasketView: (NSNotification*) notification {
    self.basketView.labelButtonBasket.text = [NSString stringWithFormat:@"Итого %@ шт на %@ руб", [[SingleTone sharedManager] countType], [[SingleTone sharedManager] priceType]];
    self.basketView.alpha = 1.f;
    
}



#pragma mark - Actions

- (void) buttonBackAction {
    NSLog(@"BACK");
    

    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - BuyViewDelegate

- (void) addCountOrder: (BuyView*) buyView {
    self.basketView.labelButtonBasket.text = [NSString stringWithFormat:@"Итого %@ шт на %@ руб", [[SingleTone sharedManager] countType], [[SingleTone sharedManager] priceType]];
    if ([[[SingleTone sharedManager] countType] integerValue] == 0) {
        self.basketView.alpha = 0.f;
    } else {
        self.basketView.alpha = 1.f;
    }

}

- (void) hideCountOrder: (BuyView*) buyView {
    self.basketView.labelButtonBasket.text = [NSString stringWithFormat:@"Итого %@ шт на %@ руб", [[SingleTone sharedManager] countType], [[SingleTone sharedManager] priceType]];
    if ([[[SingleTone sharedManager] countType] integerValue] == 0) {
        self.basketView.alpha = 0.f;
    }

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
    if ([[[SingleTone sharedManager] priceType] integerValue] < 1990) {
        [AlertClassCustom createAlertMinPrice];
    } else {
        FormalizationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"FormalizationController"];
        [self.navigationController pushViewController:detail animated:YES];
    }
}

-(void) getApiAddToBasket: (NSString *) sizeID
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",
                             sizeID,@"size",
                             nil];
    
    [api getDataFromServerWithParams:params method:@"buy_product_add" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            
            

            
            
        }
        
    }];
    
}

-(void) getApiDelToBasket: (NSString *) sizeID
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",
                             sizeID,@"size",
                             nil];
    
    [api getDataFromServerWithParams:params method:@"buy_product_del" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            
            
          
            
            
        }
        
    }];
    
}

-(void) getApiClearSizeToBasket: (NSString *) sizeID
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",
                             sizeID,@"size",
                             nil];
    
    [api getDataFromServerWithParams:params method:@"buy_product_clear" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            
            
            
            
            
        }
        
    }];
    
}

-(void) getApiClearAllSizeToBasket
{
    APIGetClass * api =[APIGetClass new]; //создаем API
   
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             self.productID,@"product",
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",
                             
                             nil];
    
    [api getDataFromServerWithParams:params method:@"buy_product_clear_all" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            
      
            
            
            
        }
        
    }];
    
}

-(void) getApiAddAllSizeToBasket
{
    APIGetClass * api =[APIGetClass new]; //создаем API

    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             self.productID,@"product",
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",
                             
                             nil];
    
    [api getDataFromServerWithParams:params method:@"buy_product_plus_one" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            
           
            
            
        }
        
    }];
    
}

-(void) getApiDelAllSizeToBasket
{
    APIGetClass * api =[APIGetClass new]; //создаем API
  
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             self.productID,@"product",
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",
                             
                             nil];
    
    [api getDataFromServerWithParams:params method:@"buy_product_minus_one" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            
         
            
            
            
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

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    
    self.label.alpha = 0.f;
    
}

 
@end
