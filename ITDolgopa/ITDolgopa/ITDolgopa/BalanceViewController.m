//
//  BalanceViewController.m
//  ITDolgopa
//
//  Created by Viktor on 20.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "BalanceViewController.h"
#import "TitleClass.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "SWRevealViewController.h"
#import "APIGetClass.h"
#import "SingleTone.h"
#import "BalanceView.h"
#import <AFNetworking/AFNetworking.h>
#import "NetworkRechabilityMonitor.h"

@implementation BalanceViewController
{
    NSDictionary * dictResponse;
    UIScrollView * mainScrollView;
}

- (void) viewDidLoad
{
#pragma mark - initialization
    
    //проверка интернет соединения --------------------------
    self.isNoInternet = 0;
    [NetworkRechabilityMonitor startNetworkReachabilityMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %ld", (long)status);
        if(status == 0){
            [NetworkRechabilityMonitor showNoInternet:self.view andShow:YES];
            self.isNoInternet = 1;
            NSLog(@"НЕТ ИНТЕРНЕТА");
        }else{
            if(self.isNoInternet == 1){
                [self loadDesignAndInfo];
            }
            NSLog(@"ЕСТЬ ИНТЕРНЕТ");
            [NetworkRechabilityMonitor showNoInternet:self.view andShow:NO];
        }
    }];
    //
    
    self.navigationController.navigationBar.layer.cornerRadius=5;
    self.navigationController.navigationBar.clipsToBounds=YES;
    
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"БАЛАНС"];
    self.navigationItem.titleView = title;
    
    //Инициализация scrollView--------------------------------
    mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    mainScrollView.backgroundColor = [UIColor colorWithHexString:MAINBACKGROUNDCOLOR];
    [self.view addSubview:mainScrollView];
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:MAINCOLORBUTTONLOGIN];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    //Отключаем основной цвет----------------------------------
    
    
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
    [self loadDesignAndInfo];
    
    }

- (void) loadDesignAndInfo{
    //Вызываем метод API для получения данных от сервера----------------------------
    [self getBalanceWithPhone:[[SingleTone sharedManager] phone] andBlock:^{
        
        BalanceView * balanceView = [[BalanceView alloc] initWithView:self.view
                                                            andInWork:[NSString stringWithFormat:@"%@", [dictResponse objectForKey:@"inwork"]]
                                                             andReady:[NSString stringWithFormat:@"%@", [dictResponse objectForKey:@"ready"]]
                                                              andDone:[NSString stringWithFormat:@"%@", [dictResponse objectForKey:@"done"]]
                                                               andAll:[NSString stringWithFormat:@"%@", [dictResponse objectForKey:@"all"]]
                                                          andAllMoney:[NSString stringWithFormat:@"%@", [dictResponse objectForKey:@"allmoney"]]
                                                              andDolg:[NSString stringWithFormat:@"%@", [dictResponse objectForKey:@"dolg"]]];
        [mainScrollView addSubview:balanceView];
        NSArray * arrayListInWork = [NSArray arrayWithArray:[dictResponse objectForKey:@"list_inwork"]];
        for (int i = 0; i < arrayListInWork.count; i++) {
            
            NSDictionary * dictListWork = [arrayListInWork objectAtIndex:i];
            BalanceView * balanceJob = [[BalanceView alloc] initWithView:mainScrollView andInworkVendors:[dictListWork objectForKey:@"inwork_vendors"] andInworkPprice:[NSString stringWithFormat:@"%@ руб.", [dictListWork objectForKey:@"inwork_pprice"]]];
            balanceJob.frame = CGRectMake(0, 300 + 80 * i, mainScrollView.frame.size.width, 80);
            [mainScrollView addSubview:balanceJob];
        }
        
        mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 300 + 50 + 80 * arrayListInWork.count);
    }];

}


#pragma mark - API

- (void) getBalanceWithPhone: (NSString*) phone andBlock: (void (^)(void))block
{
    APIGetClass * apiBalance = [[APIGetClass alloc] init];
    NSDictionary * dictParams = [NSDictionary dictionaryWithObjectsAndKeys:phone, @"phone", nil];
    [apiBalance getDataFromServerWithParams:dictParams method:@"balance" complitionBlock:^(id response) {
        
        dictResponse = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
//            NSLog(@"%@", response);
        }
        block();
       
    }];
}

@end
