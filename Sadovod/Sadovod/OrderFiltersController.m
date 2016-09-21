//
//  OrderFiltersController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 25/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "OrderFiltersController.h"
#import "OrderFiltersView.h"
#import "APIGetClass.h"
#import "SingleTone.h"
#import "Filter.h"
#import "FilterDbClass.h"
#import "PopAnimator.h"
#import "PushAnimator.h"

@interface OrderFiltersController () <OrderFiltersViewDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSDictionary * arrayData;

@end

@implementation OrderFiltersController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.delegate = self;
}

- (void) viewDidLoad {
    [super viewDidLoad];

    
 
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
#pragma mark - View
   
    FilterDbClass * filterDb = [[FilterDbClass alloc] init];
    
    Filter * filter = [filterDb filterCatID:[NSString stringWithFormat:@"%@",self.catID] ];
    
    
    if(filter.o.length !=0 && self.filter.length == 0){
        NSString * cost = [NSString stringWithFormat:@"%@-%@",filter.min_cost,filter.max_cost];
        self.cost=cost;
        self.filter=filter.o;
    }
    
    [self getApiCatalog:^{
        NSString * filterTitle = [NSString stringWithFormat:@"Фильтр - %@ товаров",[self.arrayData objectForKey:@"count"]];
        NSArray * filterArray =(NSArray *)[self.arrayData objectForKey:@"list"];
   
        [self setCustomTitle:filterTitle andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка
        OrderFiltersView * mainView = [[OrderFiltersView alloc] initWithView:self.view andData:filterArray];
        mainView.delegate = self;
        [self.view addSubview:mainView];
    } andCost:self.cost andFilter:self.filter];
   
}


#pragma mark - Actions

- (void) buttonBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - OrderFiltersViewDelegate

- (void) backTuCatalog: (OrderFiltersView*) orderFiltersView andCost:(NSString*) cost andString:(NSString*) string {
    
    
    NSDictionary * dictFilter = [[NSDictionary alloc] initWithObjectsAndKeys:
                                            cost,@"cost",
                                            string,@"string", nil];
    
    if([string length]==0){
        string = @"";
    }
    
    NSString * min_cost;
    NSString * max_cost;
    
    if([cost length]==0){
        min_cost = @"";
        max_cost = @"";
    }else{
        
        NSArray *arrayCost = [cost componentsSeparatedByString:@"-"];
        min_cost = [arrayCost objectAtIndex:0];
        max_cost = [arrayCost objectAtIndex:1];
    }
    
    FilterDbClass * filterDb = [[FilterDbClass alloc] init];
    if([filterDb checkFilter:[NSString stringWithFormat:@"%@",self.catID]  andMinCost: min_cost andMaxCost:max_cost andO:string]){
        
        [filterDb updateFilter:[NSString stringWithFormat:@"%@",self.catID]  andMinCost:min_cost andMaxCost:max_cost andO:string];
    }
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_FILTER_APPLY" object:dictFilter];
    
     

    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark - API

-(void) getApiCatalog: (void (^)(void))block andCost:(NSString *) cost
            andFilter: (NSString *) filter
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    if([filter length]==0){
        filter = @"";
    }
    
    NSString * min_cost;
    NSString * max_cost;
    
    if([cost length]==0){
        min_cost = @"";
        max_cost = @"";
    }else{
        
        NSArray *arrayCost = [cost componentsSeparatedByString:@"-"];
        min_cost = [arrayCost objectAtIndex:0];
        max_cost = [arrayCost objectAtIndex:1];
    }
    
   
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             self.catID,@"cat",
                             filter,@"o",
                             min_cost,@"min_cost",
                             max_cost,@"max_cost",
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",nil];
    

    [api getDataFromServerWithParams:params method:@"get_filter" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            self.arrayData = respDict;
            
            
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

@end
