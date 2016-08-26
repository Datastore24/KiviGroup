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

@interface CatalogMainListController () <CatalogMainListViewDelegate>

@property (strong, nonatomic) NSArray * arrayCatalog;
@property (strong, nonatomic) CatalogMainListView * mainView;

@end

@implementation CatalogMainListController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    CGRect rectView = self.mainView.frame;
    rectView.origin.y = 0.f;
    self.mainView.frame = rectView;
    
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



#pragma mark - CatalogMainListViewDelegate

- (void) pushToCatalogListController: (CatalogMainListView*) catalogMainListView andCatId:(NSString *) catID {
    CatalogListController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogListController"];
    detail.catID = catID;
    [self.navigationController pushViewController:detail animated:YES];
}

-(void) getApiCatalog: (void (^)(void))block
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             @"0",@"cat",
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios",@"appname",nil];
    
    
    [api getDataFromServerWithParams:params method:@"cat_catalog" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            self.arrayCatalog = [respDict objectForKey:@"list"];
            
 
                block();
            
            
        }
        
    }];
    
}

        


@end
