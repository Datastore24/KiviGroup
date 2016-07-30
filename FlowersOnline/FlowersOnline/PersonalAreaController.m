//
//  PersonalAreaController.m
//  FlowersOnline
//
//  Created by Виктор Мишустин on 05.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "PersonalAreaController.h"
#import "UIColor+HexColor.h"
#import "ButtonMenu.h"
#import "TitleClass.h"
#import "PersonalAreaView.h"
#import "BasketController.h"
#import "AuthDBClass.h"
#import "Auth.h"
#import "APIGetClass.h"

@interface PersonalAreaController ()
@property (strong, nonatomic) NSArray * arrayData;

@end

@implementation PersonalAreaController

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark - Header
    
    //Пареметры кнопки меню------------------------------------
    UIButton * buttonMenu = [ButtonMenu createButtonMenu];
    [buttonMenu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=buttonMenu;
    //Заголовок--------------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"ЛИЧНЫЙ КАБИНЕТ"];
    self.navigationItem.titleView = title;
    
    //Кнопка корзины---------------------------------------------
    UIButton * buttonBasket = [ButtonMenu createButtonBasket];
    [buttonBasket addTarget:self action:@selector(buttonBasketAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:buttonBasket];
    self.navigationItem.rightBarButtonItem = mailbutton;
    
#pragma mark - InitializationView
    
    
    [self getAPIWithBlock:^{
        PersonalAreaView * mainView = [[PersonalAreaView alloc] initWithView:self.view andData:self.arrayData];
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
    AuthDBClass * authDbClass = [AuthDBClass new];
    NSArray * userInfo = [authDbClass showAllUsers];
    if(userInfo.count >0){
        Auth * auth = [userInfo objectAtIndex:0];
        NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:auth.phone,@"phone", nil];
        APIGetClass * apiGallery = [APIGetClass new];
        [apiGallery getDataFromServerWithParams:params method:@"get_orders" complitionBlock:^(id response) {
            self.arrayData = response;
            NSLog(@"API %@",response);
            block();
            
        }];
    }
   
    
}

@end
