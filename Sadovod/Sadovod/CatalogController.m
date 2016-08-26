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

#import "Auth.h"
#import "AuthDbClass.h"
#import "APIGetClass.h"
#import "SingleTone.h"


@interface CatalogController () <CatalogViewDelegate>




@end

@implementation CatalogController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayProduct = [NSArray new];
    
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"Садовод" andBarButtonAlpha: NO andButtonBasket: NO]; //Ввод заголовка
//    [self.navigationController setNavigationBarHidden:NO];
    
#pragma mark - View
    [self getKey:^{
        [self getApiName:^{
            CatalogView * mainView = [[CatalogView alloc] initWithView:self.view andData:self.arrayProduct andName:self.arrayName];
            mainView.delegate = self;
            [self.view addSubview:mainView];
        }];
    }];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - CatalogViewDelegate

- (void) getCatalog: (CatalogView*) catalogView {
    CatalogMainListController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogMainListController"];
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
                    @"ios",@"appname",nil];
   
    
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
                             @"ios",@"appname",
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

@end
