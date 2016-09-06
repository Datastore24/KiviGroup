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
#import "OrderFiltersController.h"
#import "APIGetClass.h"
#import "SingleTone.h"
#import "Filter.h"
#import "FilterDbClass.h"

@interface CatalogDetailController () <CatalogDetailViewDelegate>




@end

@implementation CatalogDetailController

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
    
    self.arrayData = [NSArray new];
    
#pragma mark - View
    [self getApiCatalog:^{
        CatalogDetailView * mainView = [[CatalogDetailView alloc] initWithView:self.view andData:self.arrayData];
        mainView.delegate = self;
        [self.view addSubview:mainView];
    }];
    
    
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

- (void) pushToOrderController: (CatalogDetailView*) catalogDetailView andProductID: (NSString *) productID {
    OrderController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderController"];
    detail.productID = productID;
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) pushToOrderFilters: (CatalogDetailView*) catalogDetailView andCatID: (NSString*) catID
                    andCost:(NSString*) cost andFilter:(NSString*) filter{
    OrderFiltersController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderFiltersController"];
    detail.catID = catID;
    detail.filter = filter;
    detail.cost = cost;
    detail.sort = self.sort;
    [self.navigationController pushViewController:detail animated:YES];
}

-(void) getApiCatalog:(CatalogDetailView*) catalogDetailView andBlock: (void (^)(void))block andSort:(NSString *) sort andFilter:(NSString*) filter andCost:(NSString *) cost
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",
                             filter,@"o",
                             cost,@"cost",
                             self.catID,@"cat",
                             sort,@"sort",
                             nil];
    NSLog(@"PARAMS: %@",params);
    
    [api getDataFromServerWithParams:params method:@"cat_prods_catalog" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
           
            self.arrayData = [respDict objectForKey:@"list"];
            
               block();
            
            
        }
        
    }];
    
}



#pragma mark - API

-(void) getApiCatalog: (void (^)(void))block
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    FilterDbClass * filterDb = [[FilterDbClass alloc] init];
    
    Filter * filter = [filterDb filterCatID:[NSString stringWithFormat:@"%@",self.catID] ];
    
    NSString * cost;
    NSString * o;
   
    
    
    if(filter.o.length !=0){
        cost = [NSString stringWithFormat:@"%@-%@",filter.min_cost,filter.max_cost];
        o=filter.o;
        
    }else{
        cost=@"";
        o=@"";
    }

    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",
                             self.catID,@"cat",
                             o,@"o",
                             cost,@"cost",
                             @"upd-1",@"sort",
                             nil];
    
    [api getDataFromServerWithParams:params method:@"cat_prods_catalog" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            self.arrayData = [respDict objectForKey:@"list"];
            
        
            block();
            
            
        }
        
    }];
    
}


@end
