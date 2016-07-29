//
//  BouquetsController.m
//  FlowersOnline
//
//  Created by Виктор Мишустин on 05.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "BouquetsController.h"
#import "UIColor+HexColor.h"
#import "ButtonMenu.h"
#import "TitleClass.h"
#import "BouquetsView.h"
#import "BasketController.h"
#import "SingleTone.h"
#import "APIGetClass.h"

@interface BouquetsController ()

@property (strong, nonatomic) NSArray * arrayResponse;

@end

@implementation BouquetsController

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark - Header
    
    //Пареметры кнопки меню------------------------------------
    UIButton * buttonMenu = [ButtonMenu createButtonMenu];
    [buttonMenu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=buttonMenu;
    //Заголовок--------------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"БУКЕТЫ"];
    self.navigationItem.titleView = title;
    
    //Кнопка корзины---------------------------------------------
    UIButton * buttonBasket = [ButtonMenu createButtonBasket];
    [buttonBasket addTarget:self action:@selector(buttonBasketAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:buttonBasket];
    self.navigationItem.rightBarButtonItem = mailbutton;

#pragma mark - View
    
    //загрузка данных------
    
    [self getAPIWithBlock:^{        
        
        //отображение----
        BouquetsView * mainView = [[BouquetsView alloc] initWithView:self.view andArrayData:self.arrayResponse];
        [self.view addSubview:mainView];
        
        NSLog(@"Загруженно");
        
    }];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Buttons Action

- (void) buttonBasketAction
{
    BasketController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"BasketController"];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - API

- (void) getAPIWithBlock: (void (^)(void))block
{
    
//    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:@"", @"category_id", nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:nil method:@"load_products" complitionBlock:^(id response) {\
        
        if ([response isKindOfClass:[NSArray class]]) {
            _arrayResponse = response;
        } else {
            NSLog(@"Что то другое");
        }

                
        block();

    }];
}



@end
