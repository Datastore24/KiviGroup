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
#import <MONActivityIndicatorView.h>

@interface BouquetsController () <MONActivityIndicatorViewDelegate>

@property (strong, nonatomic) NSArray * arrayResponse;
@property (strong, nonatomic) NSArray * arrayCetegory;

@end

@implementation BouquetsController

- (void) checkOerder {
    UIBarButtonItem *mailbutton = self.navigationItem.rightBarButtonItem;
    mailbutton.enabled = YES;
}

- (void) viewWillAppear:(BOOL)animated {
    UIBarButtonItem *mailbutton = self.navigationItem.rightBarButtonItem;
    if ([[SingleTone sharedManager] arrayBouquets].count == 0) {
        mailbutton.enabled = NO;
    }
}

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
    if ([[SingleTone sharedManager] arrayBouquets].count == 0) {
        mailbutton.enabled = NO;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkOerder) name:@"checkOrderNotification" object:nil];
    

#pragma mark - View
    
    //загрузка данных------
    
    MONActivityIndicatorView *indicatorView = [[MONActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 50, self.view.frame.size.height / 2 - 20, 100, 40)];
    indicatorView.numberOfCircles = 5;
    indicatorView.radius = 10;
    indicatorView.delegate = self;
    [indicatorView startAnimating];
    [self.view addSubview:indicatorView];
    
    [self getAPIWithBlock:^{
        [indicatorView stopAnimating];

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

- (void) getAPIWithCategoryBlock: (void (^)(void))block
{
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:nil method:@"get_categories" complitionBlock:^(id response) {\
        
        if ([response isKindOfClass:[NSArray class]]) {
            self.arrayCetegory = response;
        } else {
            NSLog(@"Что то другое");
        }
        block();
    }];
}

- (void) getAPIWithBlock: (void (^)(void))block
{
    
    [self getAPIWithCategoryBlock:^{
        NSDictionary * dictCategory = [self.arrayCetegory objectAtIndex:0];
        NSString * idCategory = [dictCategory objectForKey:@"id"];
        NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:idCategory, @"category_id", nil];
        
        APIGetClass * apiGallery = [APIGetClass new];
        [apiGallery getDataFromServerWithParams:dict method:@"load_products" complitionBlock:^(id response) {\
            
            if ([response isKindOfClass:[NSArray class]]) {
                self.arrayResponse = response;
                
            } else {
                NSLog(@"Что то другое");
            }
            block();
        }];
    }];
}

#pragma mark - MONActivityIndicatorViewDelegate

- (UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView
      circleBackgroundColorAtIndex:(NSUInteger)index {
    UIColor * color;
    if (index == 0) {
        color = [UIColor colorWithHexString:@"6DC066"];
    } else if (index == 1) {
        color = [UIColor colorWithHexString:@"A0DB8E"];
    } else if (index == 2) {
        color = [UIColor colorWithHexString:@"B4EEB4"];
    } else if (index == 3) {
        color = [UIColor colorWithHexString:@"D3FFCE"];
    } else if (index == 4) {
        color = [UIColor colorWithHexString:@"d3f4d7"];
    }

    return color;
}



@end
