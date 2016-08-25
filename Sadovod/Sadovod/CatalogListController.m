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

@interface CatalogListController () <CatalogListViewDelegate>

@property (strong, nonatomic) NSArray * arrayCatalog;


@end

@implementation CatalogListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"CATID %@",self.catID);
    
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"Женская одежда" andBarButtonAlpha: YES andButtonBasket: NO]; //Ввод заголовка
    //    [self.navigationController setNavigationBarHidden:NO];
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    

#pragma mark - View

    [self getApiCatalog:^{
        CatalogListView * mainView = [[CatalogListView alloc] initWithView:self.view andData:self.arrayCatalog];
        mainView.delegate = self;
        [self.view addSubview:mainView];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions
- (void)buttonBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - API

-(void) getApiCatalog: (void (^)(void))block
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             self.catID,@"cat",
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios",@"appname",nil];
    
    
    [api getDataFromServerWithParams:params method:@"get_tree_by_catalog" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            self.arrayCatalog = [respDict objectForKey:@"tree"];
            
            NSLog(@"%@",respDict);
            block();
            
            
        }
        
    }];
    
}

#pragma mark - CatalogListViewDelegate

- (void) pushToCatalogDetail: (CatalogListView*) catalogListView {
    CatalogDetailController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogDetailController"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
