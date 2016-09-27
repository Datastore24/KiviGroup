//
//  BasketController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 30/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "BasketController.h"
#import "Macros.h"
#import "HexColors.h"
#import "BasketView.h"
#import "CatalogController.h"
#import "PopAnimator.h"
#import "PushAnimator.h"
#import "APIGetClass.h"
#import "SingleTone.h"

@interface BasketController () <BasketViewGelegate, UINavigationControllerDelegate>


@property (strong, nonatomic) NSArray * arrayCart;

@end

@implementation BasketController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.delegate = self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    
    [self setCustomTitle:@"Корзина" andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;

    
#pragma mark - View
    
    [self getApiCart:^{
        
        BasketView * mainView = [[BasketView alloc] initWithView:self.view andData:self.arrayCart];
        mainView.delegate = self;
        [self.view addSubview:mainView];
        
    }];
    
    

    
    
}


#pragma mark - Actions

- (void) buttonBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - BasketViewGelegate

- (void) backTuCatalog: (BasketView*) basketView {
    
    CatalogController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogController"];
    [self.navigationController pushViewController:detail animated:YES];
    
}

-(void) getApiClearSizeToBasket: (BasketView*) basketView andSizeID: (NSString *) sizeID
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
            
            [[SingleTone sharedManager] setCountType:[NSString stringWithFormat:@"%@",[respDict objectForKey:@"global_count"]]];
            
            [[SingleTone sharedManager] setPriceType:[NSString stringWithFormat:@"%@",[respDict objectForKey:@"global_cost"]]];
            
                        NSLog(@"RESP CART %@",respDict);
            
            
            
        }
        
    }];
    
}

-(void) getApiChangeSizeCountBasket: (BasketView*) basketView andSizeID: (NSString *) sizeID andCount: (NSString *) count
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",
                             sizeID,@"price",
                             count,@"count",
                             nil];
    
    [api getDataFromServerWithParams:params method:@"cart_change_count" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            
            [[SingleTone sharedManager] setCountType:[NSString stringWithFormat:@"%@",[respDict objectForKey:@"global_count"]]];
            
            [[SingleTone sharedManager] setPriceType:[NSString stringWithFormat:@"%@",[respDict objectForKey:@"global_cost"]]];
            

            

            
            
            
            
            
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

#pragma mark - API
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
            
            
            NSLog(@"CART %@",respDict);
            self.arrayCart = [respDict objectForKey:@"list"] ;
            
            block();
            
            
        }
        
    }];
    
}


@end
