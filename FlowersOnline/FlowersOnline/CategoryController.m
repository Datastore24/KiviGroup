//
//  CategoryController.m
//  FlowersOnline
//
//  Created by Виктор on 13.08.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "CategoryController.h"
#import "UIColor+HexColor.h"
#import "ButtonMenu.h"
#import "TitleClass.h"
#import "BouquetsView.h"
#import "BasketController.h"
#import "SingleTone.h"
#import "APIGetClass.h"
#import "CategoryView.h"

@interface CategoryController ()

@property (strong, nonatomic) NSArray * arrayResponse;

@end

@implementation CategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //Пареметры кнопки меню------------------------------------
    UIButton * buttonMenu = [ButtonMenu createButtonMenu];
    [buttonMenu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=buttonMenu;
    
    //Заголовок--------------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"КАТЕГОРИИ"];
    self.navigationItem.titleView = title;
    
    //Кнопка корзины---------------------------------------------
    UIButton * buttonBasket = [ButtonMenu createButtonBasket];
    [buttonBasket addTarget:self action:@selector(buttonBasketAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:buttonBasket];
    self.navigationItem.rightBarButtonItem = mailbutton;
    if ([[SingleTone sharedManager] arrayBouquets].count == 0) {
        mailbutton.enabled = NO;
    }
    
#pragma mark - Initialization View
    
    [self getAPIWithBlock:^{
        CategoryView * mainView = [[CategoryView alloc] initWithView:self.view andData:self.arrayResponse];
        [self.view addSubview:mainView];
    }];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (void) getAPIWithBlock: (void (^)(void))block
{
    //    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:@"5", @"category_id", nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:nil method:@"get_categories" complitionBlock:^(id response) {\
        
        if ([response isKindOfClass:[NSArray class]]) {
            self.arrayResponse = response;
        } else {
            NSLog(@"Что то другое");
        }
        
        
        block();
        
    }];
}

#pragma mark - Buttons Action

- (void) buttonBasketAction
{
    BasketController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"BasketController"];
    [self.navigationController pushViewController:detail animated:YES];
}



@end
