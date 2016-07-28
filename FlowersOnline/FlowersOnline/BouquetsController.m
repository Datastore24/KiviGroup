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
    
    UIView * countOrdersView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 75, 10, 30, 20)];
    countOrdersView.backgroundColor = [UIColor clearColor];
    countOrdersView.layer.borderColor = [UIColor whiteColor].CGColor;
    countOrdersView.tag = 240;
    countOrdersView.layer.borderWidth = 1.5f;
    countOrdersView.layer.cornerRadius = 7.f;
    [self.navigationController.navigationBar addSubview:countOrdersView];
    [[SingleTone sharedManager] setViewBasketBar:countOrdersView];
    
    UILabel * labelBasket = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    if ([[SingleTone sharedManager] labelCountBasket] == nil) {
        labelBasket.text = @"0";
    } else {
        labelBasket.text = [[SingleTone sharedManager] labelCountBasket].text;
    }
    
    labelBasket.textColor = [UIColor whiteColor];
    labelBasket.font = [UIFont fontWithName:FONTREGULAR size:14];
    labelBasket.textAlignment = NSTextAlignmentCenter;
    [countOrdersView addSubview:labelBasket];
    [[SingleTone sharedManager] setLabelCountBasket:labelBasket];
    
#pragma mark - View
    
    //загрузка данных------
    
    [self getAPIWithBlock:^{        
        
        //отображение----
        BouquetsView * mainView = [[BouquetsView alloc] initWithView:self.view andArrayData:self.arrayResponse];
        [self.view addSubview:mainView];
        
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
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:@"2", @"category_id", nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:dict method:@"load_products" complitionBlock:^(id response) {\
        
        if ([response isKindOfClass:[NSArray class]]) {
            _arrayResponse = response;
        } else {
            NSLog(@"Что то другое");
        }

                
        block();

    }];
}



@end
