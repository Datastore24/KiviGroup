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

@property (strong, nonatomic) NSArray * arrayName; //Массив с Категориями
@property (strong, nonatomic) NSMutableArray * arrayProduct; //Массив с Категориями


@end

@implementation CatalogController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayProduct = [NSMutableArray new];
    
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"Садовод" andBarButtonAlpha: NO]; //Ввод заголовка
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

- (NSMutableArray*) setCustonArray
{
    NSArray * arrayImage = [NSArray arrayWithObjects:
                            @"imageProduct1.jpg", @"imageProduct2.jpg", @"imageProduct3.jpg", @"imageProduct4.jpg",
                            @"imageProduct5.jpg", @"imageProduct6.jpg", @"imageProduct7.jpg", @"imageProduct8.jpg",
                            @"imageProduct9.jpg", @"imageProduct10.jpg", nil];
    NSArray * arrayPrice = [NSArray arrayWithObjects:@"216", @"310", @"525", @"673", @"558", @"138", @"385", @"134", @"245", @"384", nil];
    NSMutableArray * mArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < arrayImage.count; i++) {
        NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[arrayImage objectAtIndex:i], @"image", [arrayPrice objectAtIndex:i], @"price", nil];
        [mArray addObject:dict];
    }
    
    return mArray;
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
            
            
           
            for(int i=0;i<self.arrayName.count;i++){
                NSString * catID = [[self.arrayName objectAtIndex:i] objectForKey:@"cat"];
                NSString * catName = [[self.arrayName objectAtIndex:i] objectForKey:@"title"];
                
                [self getApiTabProducts:catID andName:catName andPage:@"1" andCount:i+1 andMaxCount:self.arrayName.count andBlock:^{
                    block();
                }];
                
                
                
            }


        }
        
        
    }];
}

- (void) getApiTabProducts:(NSString *) cat andName: (NSString *) catname andPage: (NSString *) page
                    andCount: (NSInteger) count andMaxCount: (NSInteger) maxCount
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
        
            NSLog(@"CAT NAME %@",catname);
            [self.arrayProduct addObject:[respDict objectForKey:@"list"]];
            if(count == maxCount){
                block();
            }
           
        }
        
        
    }];
}

@end
