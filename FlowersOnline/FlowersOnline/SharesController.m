//
//  SharesController.m
//  FlowersOnline
//
//  Created by Виктор Мишустин on 10.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "SharesController.h"
#import "UIColor+HexColor.h"
#import "ButtonMenu.h"
#import "TitleClass.h"
#import "SharesView.h"
#import "BasketController.h"
#import "APIGetClass.h"
#import <MONActivityIndicatorView.h>
#import "SingleTone.h"

@interface SharesController () <MONActivityIndicatorViewDelegate>

@property (strong, nonatomic) NSArray * arrayData;

@end

@implementation SharesController

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark - Header
    
    //Пареметры кнопки меню------------------------------------
    UIButton * buttonMenu = [ButtonMenu createButtonMenu];
    [buttonMenu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=buttonMenu;
    //Заголовок--------------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"АКЦИИ"];
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

    MONActivityIndicatorView *indicatorView = [[MONActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 50, self.view.frame.size.height / 2 - 20, 100, 40)];
    indicatorView.numberOfCircles = 5;
    indicatorView.radius = 10;
    indicatorView.delegate = self;
    [indicatorView startAnimating];
    [self.view addSubview:indicatorView];
    
    
    [self getAPIWithBlock:^{
        [indicatorView stopAnimating];
        SharesView * mainView = [[SharesView alloc] initWithView:self.view andData:self.arrayData];
        [self.view addSubview:mainView];
    }];
    


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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        APIGetClass * apiGallery = [APIGetClass new];
        [apiGallery getDataFromServerWithParams:nil method:@"load_actions" complitionBlock:^(id response) {
            self.arrayData = response;
            
            block();
            
        }];
    });
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
