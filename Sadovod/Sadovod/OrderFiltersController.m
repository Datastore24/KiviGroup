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

@interface OrderFiltersController () <OrderFiltersViewDelegate>

@property (strong, nonatomic) NSDictionary * arrayData;

@end

@implementation OrderFiltersController

- (void) viewDidLoad {
    [super viewDidLoad];
    
 
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
#pragma mark - View
    [self getApiCatalog:^{
        NSString * filterTitle = [NSString stringWithFormat:@"Фильтр - %@ товаров",[self.arrayData objectForKey:@"count"]];
        NSArray * filterArray =(NSArray *)[self.arrayData objectForKey:@"list"];
        [self setCustomTitle:filterTitle andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка
        OrderFiltersView * mainView = [[OrderFiltersView alloc] initWithView:self.view andData:filterArray];
        mainView.delegate = self;
        [self.view addSubview:mainView];
    } andMaxCost:@"0" andMinCost:@"0"];
   
}


#pragma mark - Actions

- (void) buttonBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - OrderFiltersViewDelegate

- (void) backTuCatalog: (OrderFiltersView*) orderFiltersView {
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark - API

-(void) getApiCatalog: (void (^)(void))block andMaxCost:(NSString *) maxCost andMinCost:(NSString *) minCost
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             self.catID,@"cat",
                             maxCost, @"max_cost",
                             minCost, @"min_cost",
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",nil];
    
    NSLog(@"CAT FIL: %@",self.catID);
    [api getDataFromServerWithParams:params method:@"get_filter" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            self.arrayData = respDict;
            
            
            block();
            
            
        }
        
    }];
    
}

@end
