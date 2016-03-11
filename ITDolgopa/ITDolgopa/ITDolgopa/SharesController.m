//
//  SharesController.m
//  ITDolgopa
//
//  Created by Viktor on 05.03.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "SharesController.h"
#import "TitleClass.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "SWRevealViewController.h"
#import "SharesView.h"
#import "APIGetClass.h"

@implementation SharesController
{
    NSArray * arrayResponse;
}

- (void) viewDidLoad {
    
#pragma mark - Header
    self.navigationController.navigationBar.layer.cornerRadius=5;
    self.navigationController.navigationBar.clipsToBounds=YES;
    
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"АКЦИИ"];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:MAINCOLORBUTTONLOGIN];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    //Пареметры кнопки меню------------------------------------
    UIImage *imageBarButton = [UIImage imageNamed:@"menuIcon.png"];
    [_buttonMenu setImage:imageBarButton];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake( 0, 0, 30, 30);
    [button setImage:imageBarButton forState:UIControlStateNormal];
    [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=button;
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.navigationController.navigationBar.hidden = NO; // спрятал navigation bar

#pragma mark - initialization
    
    [self getArraySharesWithBlock:^{
        
//        NSLog(@"%@", arrayResponse);
        
        //Создание класса вью----------------------------------------
        SharesView * sharesView = [[SharesView alloc] initWithView:self.view andArray:arrayResponse];
        [self.view addSubview: sharesView];

    }];    
}


#pragma mark - API

//Метод загрузки массива------------------------------------------
- (void) getArraySharesWithBlock: (void (^) (void)) block
{
    APIGetClass * apiGetShares = [APIGetClass new];
    [apiGetShares getDataFromServerWithParams:nil method:@"promotions_show" complitionBlock:^(id response) {

        NSDictionary * responseConferm = (NSDictionary*) response;
        if ([[responseConferm objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [responseConferm objectForKey:@"error_msg"]);
        } else if ([[responseConferm objectForKey:@"error"] integerValue] == 0) {
//            NSLog(@"Все хорошо");
            arrayResponse = [NSArray arrayWithArray:[responseConferm objectForKey:@"promo_array"]];
        }
        
        block();
    }];
}

@end
