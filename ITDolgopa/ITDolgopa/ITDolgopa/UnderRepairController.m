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

@interface UnderRepairController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation UnderRepairController
{
    CustomCallView * cellView;
    NSArray * arrayDevice;
    UIButton * buttonBalance;
}


- (void) viewDidLoad
{
#pragma mark - initialization
    
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"В РЕМОНТЕ"];
    self.navigationItem.titleView = title;
    NSInteger balance = [[[SingleTone sharedManager] billingBalance] integerValue];

    //Кнопка бара--------------------------------------------
    buttonBalance =  [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonBalance setTitle:[NSString stringWithFormat:@"%ld", (long)balance] forState:UIControlStateNormal];
    [buttonBalance addTarget:self action:@selector(buttonOrdersAction)forControlEvents:UIControlEventTouchUpInside];
    [buttonBalance setFrame:CGRectMake(0, 0, 60, 30)];
    
    UIBarButtonItem *barButtonOrders = [[UIBarButtonItem alloc] initWithCustomView:buttonBalance];
    self.navigationItem.rightBarButtonItem = barButtonOrders;
    
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
//    _buttonMenu.target = self.revealViewController;
//    _buttonMenu.action = @selector(revealToggle:);
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
    return arrayDevice.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithHexString:MAINBACKGROUNDCOLOR];
    
    NSDictionary * dict = [arrayDevice objectAtIndex:indexPath.row];
    NSString * textStatus = [NSString new];
    NSString * textColorStatus = [NSString new];
    if ([[dict objectForKey:@"inwork_wstatus"] integerValue] == 1) {
        textStatus = @"В ремонте";
        textColorStatus = @"29a9e0";
    } else if ([[dict objectForKey:@"inwork_wstatus"] integerValue] == 2) {
        if ([[dict objectForKey:@"take_money"] integerValue] == 0){
            textStatus = @"Готов к выдаче";
            textColorStatus = @"8bc543";
        }else{
            textStatus = @"Выдан";
            textColorStatus = @"8bc543";
        }
        
        
        
        
    } else if ([[dict objectForKey:@"inwork_wstatus"] integerValue] == 3) {
        textStatus = @"Отказ в ремонте";
        textColorStatus = @"ed1d24";
    }
    
    
    
    //Инициализауия класса ячейки-----------------------------
    cellView = [[CustomCallView alloc] initWithDevice:[dict objectForKey:@"inwork_vendors"]
                                          andBreaking:[dict objectForKey:@"inwork_defects"]
                                         andReadiness:[dict objectForKey:@"inwork_end"]
                                            andStatus:textStatus
                                       andColorStatus:textColorStatus
                                              andView:self.view];
    [cell addSubview:cellView];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
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
            NSLog(@"Все хорошо");
            NSDictionary * dictResponse = (NSDictionary*) response;
            arrayDevice = [dictResponse objectForKey:@"inworks"];
//            NSLog(@"arrayDevice %@", arrayDevice);
        }
            [self.mainTableView reloadData];
    }];

}

#pragma mark - ButtonsMethods

- (void) buttonOrdersAction
{
    NSLog(@"buttonOrdersAction");
}

@end
