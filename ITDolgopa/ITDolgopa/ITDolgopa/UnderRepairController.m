//
//  UnderRepairController.m
//  ITDolgopa
//
//  Created by Viktor on 16.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "UnderRepairController.h"
#import "SWRevealViewController.h"
#import "SingleTone.h"
#import "APIGetClass.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "TitleClass.h"
#import "CustomCallView.h"
#import "UNderRepairDetailsController.h"
#import "BalanceViewController.h"
#import <AFNetworking/AFNetworking.h>

#import "NetworkRechabilityMonitor.h"

@interface UnderRepairController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (assign, nonatomic) BOOL isNoInternet;

@end

@implementation UnderRepairController
{
    CustomCallView * cellView;
    NSArray * arrayDevice;
    UIButton * buttonBalance;
    NSMutableArray * mainArray;

}


-(void) viewWillAppear:(BOOL)animated{
    
[NetworkRechabilityMonitor showNoInternet:self.view andShow:NO];
    
}


- (void) viewDidLoad
{
#pragma mark - initialization
    
    //проверка интернет соединения --------------------------
    self.isNoInternet = 0;
        [NetworkRechabilityMonitor startNetworkReachabilityMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        NSLog(@"Reachability: %ld", (long)status);
        if(status == 0){
            if(self.isNoInternet == 0){
                [NetworkRechabilityMonitor showNoInternet:self.view andShow:YES];
                self.isNoInternet = 1;
            }
            NSLog(@"НЕТ ИНТЕРНЕТА");
        }else{
            if(self.isNoInternet == 1){
                arrayDevice = nil;
                mainArray = [NSMutableArray new];
//               [self getDevicesWithPhone:[[SingleTone sharedManager] phone]];
            }
            NSLog(@"ЕСТЬ ИНТЕРНЕТ");
            [NetworkRechabilityMonitor showNoInternet:self.view andShow:NO];
        }
    }];
    //
    
    self.navigationController.navigationBar.layer.cornerRadius=5;
    self.navigationController.navigationBar.clipsToBounds=YES;
    
    //Заголовок-----------------------------------------------
    NSString * titleString;
    if ([[SingleTone sharedManager] tableChange]) {
        titleString = @"В РЕМОНТЕ";
    } else {
        titleString = @"ИСТОРИЯ";
    }
    TitleClass * title = [[TitleClass alloc]initWithTitle:titleString];
    self.navigationItem.titleView = title;
    NSInteger balance = [[[SingleTone sharedManager] billingBalance] integerValue];
    
    mainArray = [NSMutableArray new];

    //Кнопка бара--------------------------------------------
    buttonBalance =  [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonBalance setTitle:[NSString stringWithFormat:@"%ld", (long)balance] forState:UIControlStateNormal];
    [buttonBalance addTarget:self action:@selector(buttonOrdersAction)forControlEvents:UIControlEventTouchUpInside];
    [buttonBalance setFrame:CGRectMake(0, 0, 60, 30)];
    
    UIBarButtonItem *barButtonOrders = [[UIBarButtonItem alloc] initWithCustomView:buttonBalance];
    self.navigationItem.rightBarButtonItem = barButtonOrders;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Назад"
                                   style:UIBarButtonItemStylePlain
                                   target:nil
                                   action:nil];
    self.navigationItem.backBarButtonItem=backButton;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:MAINCOLORBUTTONLOGIN];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    //Отключаем основной цвет----------------------------------
    self.view.backgroundColor = [UIColor colorWithHexString:MAINBACKGROUNDCOLOR];
    
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
    //Параметры таблицы----------------------------------------------
    //Убираем полосы разделяющие ячейки------------------------------
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.backgroundColor = [UIColor clearColor];
    self.mainTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 80);

    [self getDevicesWithPhone:[[SingleTone sharedManager] phone]];

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mainArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithHexString:MAINBACKGROUNDCOLOR];
    
//    NSLog(@"%@", mainArray);
    
    NSDictionary * dict = [mainArray objectAtIndex:indexPath.row];
    NSString * textStatus = [NSString new];
    NSString * textColorStatus = [NSString new];
    NSString * endDate;
    if ([[dict objectForKey:@"inwork_wstatus"] integerValue] == 1) {
        textStatus = @"В ремонте";
        textColorStatus = @"29a9e0";
        endDate = [dict objectForKey:@"inwork_end"];
    } else if ([[dict objectForKey:@"inwork_wstatus"] integerValue] == 2) {
        if ([[dict objectForKey:@"take_money"] integerValue] == 0){
            textStatus = @"Готов к выдаче";
            textColorStatus = @"8bc543";
        }else{
            textStatus = @"Выдан";
            textColorStatus = @"c7ffc4";
        }
        if([[dict objectForKey:@"real_inwork_end"] intValue]==0){
                endDate = [dict objectForKey:@"inwork_end"];
        }else{
                endDate = [dict objectForKey:@"real_inwork_end"];
        }
        
        
    } else if ([[dict objectForKey:@"inwork_wstatus"] integerValue] == 3) {
        textStatus = @"Отказ в ремонте";
        textColorStatus = @"ed1d24";
        endDate = [dict objectForKey:@"inwork_end"];
    }
    
    
    
    //Инициализауия класса ячейки-----------------------------
    cellView = [[CustomCallView alloc] initWithDevice:[dict objectForKey:@"inwork_vendors"]
                                           andCreated:[dict objectForKey:@"created"]
                                          andBreaking:[dict objectForKey:@"inwork_defects"]
                                         andReadiness:endDate
                    andPPrice:[NSString stringWithFormat:@"%@ руб.",[dict objectForKey:@"inwork_pprice"]]
                    andPrepay:[NSString stringWithFormat:@"%@ руб.",[dict objectForKey:@"inwork_prepay"]]
                                            andStatus:textStatus
                                       andColorStatus:textColorStatus
                                              andView:self.view];
    [cell addSubview:cellView];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //Передаем в сингтон данные об конкретном устройстве
    [[SingleTone sharedManager] setDictDevice:[mainArray objectAtIndex:indexPath.row]];
    
    UNderRepairDetailsController * details = [self.storyboard instantiateViewControllerWithIdentifier:@"UnderRepairDetails"];
    [self.navigationController pushViewController:details animated:YES];
}

#pragma mark - API

- (void) getDevicesWithPhone: (NSString*) phone
{
    APIGetClass * apiDevices = [APIGetClass new];
    NSDictionary * dictParams = [NSDictionary dictionaryWithObjectsAndKeys:phone, @"phone", nil];
    
    [apiDevices getDataFromServerWithParams:dictParams method:@"get_inworks" complitionBlock:^(id response) {
        
        NSDictionary * dictResponse = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
//            NSLog(@"Все хорошо");
            NSDictionary * dictResponse = (NSDictionary*) response;
            arrayDevice = [dictResponse objectForKey:@"inworks"];
            //Создание массива под различные вариации---------------------------
            for (int i = 0; i < arrayDevice.count; i++) {
                NSDictionary * dictArray = [arrayDevice objectAtIndex:i];
                if ([[SingleTone sharedManager] tableChange]) {
                    if ([[dictArray objectForKey:@"inwork_wstatus"] integerValue] == 1) {
                        [mainArray addObject:[arrayDevice objectAtIndex:i]];
                    } else if ([[dictArray objectForKey:@"inwork_wstatus"] integerValue] == 2)
                    {
                        if ([[dictArray objectForKey:@"take_money"] integerValue] == 0){
                            [mainArray addObject:[arrayDevice objectAtIndex:i]];
                        }
                    }
                    
                }
                else {
                    if ([[dictArray objectForKey:@"inwork_wstatus"] integerValue] == 2) {
                        if ([[dictArray objectForKey:@"take_money"] integerValue] != 0) {
                            [mainArray addObject:[arrayDevice objectAtIndex:i]];
                        }
                        
                    } else if ([[dictArray objectForKey:@"inwork_wstatus"] integerValue] == 3) {
                            [mainArray addObject:[arrayDevice objectAtIndex:i]];
                    }
                }
            }

        }
            [self.mainTableView reloadData];
    }];

}

#pragma mark - ButtonsMethods

- (void) buttonOrdersAction
{
    BalanceViewController * detail = [self.storyboard
                                      instantiateViewControllerWithIdentifier:@"Balance"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
