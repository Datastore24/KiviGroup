//
//  BasketController.m
//  FlowersOnline
//
//  Created by Viktor on 13.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "BasketController.h"
#import "UIColor+HexColor.h"
#import "ButtonMenu.h"
#import "TitleClass.h"
#import "BasketView.h"
#import "CheckoutController.h"
#import "SingleTone.h"
#import "APIGetClass.h"
#import "BouquetsController.h"

@interface BasketController ()

@property (strong, nonatomic) NSArray * arrayDelivery;

@end

@implementation BasketController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
#pragma mark - Header
    [[NSNotificationCenter defaultCenter] postNotificationName:@"alphaView" object:nil];
    //Пареметры кнопки меню------------------------------------
    UIButton * buttonMenu = [ButtonMenu createButtonMenu];
    [buttonMenu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=buttonMenu;
    //Заголовок--------------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"КОРЗИНА"];
    self.navigationItem.titleView = title;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushCheckout) name:NOTIFICATION_BASKET_CONTROLLER_PUSH_CHEKOUT_CONTROLLER object:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushBouquetsController) name:@"pushBouquetsController" object:nil];

    
    
#pragma mark - Initialization
    
    [self getAPIWithBlock:^{
        BasketView * mainView = [[BasketView alloc] initWithView:self.view andData:[[SingleTone sharedManager] arrayBouquets] andDelivery:self.arrayDelivery];
        [self.view addSubview:mainView];
    }];
    
    

}

- (void) viewWillAppear:(BOOL)animated
{
    [[SingleTone sharedManager] viewBasketBar].alpha = 0;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [[SingleTone sharedManager] viewBasketBar]. alpha = 1;
}

- (void) viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"downNotification" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) pushCheckout
{
    CheckoutController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CheckoutController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) pushBouquetsController {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - API

- (void) getAPIWithBlock: (void (^)(void))block
{
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:nil method:@"get_deliveryes" complitionBlock:^(id response) {\
        self.arrayDelivery = response;
        
        block();
        
    }];
}


@end
