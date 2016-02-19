//
//  UNderRepairDetailsController.m
//  ITDolgopa
//
//  Created by Viktor on 18.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "UNderRepairDetailsController.h"
#import "SingleTone.h"
#import "APIGetClass.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "TitleClass.h"
#import "UnderRepairDetailsView.h"

@implementation UNderRepairDetailsController
{
    UIScrollView * mainScrollView;
    NSDictionary * dictResponse;
    NSInteger numberInTotal;
    UIButton * buttonBalance;
}

- (void) viewDidLoad
{
#pragma mark - initialization
    
    self.navigationController.navigationBar.layer.cornerRadius=5;
    self.navigationController.navigationBar.clipsToBounds=YES;
    
    //Кнопка бара--------------------------------------------
    NSInteger balance = [[[SingleTone sharedManager] billingBalance] integerValue];
    buttonBalance =  [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonBalance setTitle:[NSString stringWithFormat:@"%ld", (long)balance] forState:UIControlStateNormal];
    [buttonBalance addTarget:self action:@selector(buttonOrdersAction)forControlEvents:UIControlEventTouchUpInside];
    [buttonBalance setFrame:CGRectMake(0, 0, 60, 30)];
    
    UIBarButtonItem *barButtonOrders = [[UIBarButtonItem alloc] initWithCustomView:buttonBalance];
    self.navigationItem.rightBarButtonItem = barButtonOrders;
    
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:[[[SingleTone sharedManager] dictDevice]objectForKey:@"inwork_vendors"]];
    self.navigationItem.titleView = title;
    
    //Параметры скролВью----------------------------------------------------
    mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    mainScrollView.backgroundColor = [UIColor colorWithHexString:MAINBACKGROUNDCOLOR];
    [self.view addSubview:mainScrollView];
    
    //Инициализируем числовой параметр итого-----------------
    numberInTotal = 0;

    //Класс АПИ для отображения вью---------------------------
    [self getDeviceWithPhone:[[[SingleTone sharedManager] dictDevice]objectForKey:@"contr_phone"] andInworkId:[[[SingleTone sharedManager] dictDevice]objectForKey:@"inwork_id"] andBlock:^{
        
        NSString * textStatus = [NSString new];
        NSString * textColorStatus = [NSString new];
        NSString * endDate;
        if ([[dictResponse objectForKey:@"inwork_wstatus"] integerValue] == 1) {
            textStatus = @"В ремонте";
            textColorStatus = @"29a9e0";
            endDate = [dictResponse objectForKey:@"inwork_end"];
        } else if ([[dictResponse objectForKey:@"inwork_wstatus"] integerValue] == 2) {
            if ([[dictResponse objectForKey:@"take_money"] integerValue] == 0){
                textStatus = @"Готов к выдаче";
                textColorStatus = @"8bc543";
            }else{
                textStatus = @"Выдан";
                textColorStatus = @"c7ffc4";
            }
            if([[dictResponse objectForKey:@"real_inwork_end"] intValue]==0){
                endDate = [dictResponse objectForKey:@"inwork_end"];
            }else{
                endDate = [dictResponse objectForKey:@"real_inwork_end"];
            }
            
            
        } else if ([[dictResponse objectForKey:@"inwork_wstatus"] integerValue] == 3) {
            textStatus = @"Отказ в ремонте";
            textColorStatus = @"ed1d24";
            endDate = [dictResponse objectForKey:@"inwork_end"];
        }
        
        NSString * factRepairString;
        if ([[dictResponse objectForKey:@"akt_created"] integerValue] == 0) {
            factRepairString = @"Работы еще не выполнены";
        } else {
            factRepairString = [dictResponse objectForKey:@"akt_created"];
        }

        
        
        UnderRepairDetailsView * underRepairDetailsView = [[UnderRepairDetailsView alloc]
                                 initWithView:self.view
                                 andDevice:[dictResponse objectForKey:@"inwork_vendors"]
                                 andSN:[dictResponse objectForKey:@"inwork_sn"]
                                 andCreated:[dictResponse objectForKey:@"inw_created"]
                                 andBreaking:[dictResponse objectForKey:@"inwork_defects"]
                                 andStatus:textStatus
                                 andStatusColor:textColorStatus
                                 andReadiness:endDate
                                 andFactRepair:factRepairString];
        
        [mainScrollView addSubview:underRepairDetailsView];
        
        NSArray * arrayJob = [NSArray arrayWithArray:[dictResponse objectForKey:@"inwork_job"]];
        
        for (int i = 0; i < arrayJob.count; i++) {
            
            NSDictionary * dictDataJob = [arrayJob objectAtIndex:i];
            
            //Выщитываем чиловой параметр итого-------------------------------
            numberInTotal = numberInTotal + [[dictDataJob objectForKey:@"akt_money_price"]integerValue];
            UnderRepairDetailsView * jobUnderRepair = [[UnderRepairDetailsView alloc] initWithCustomFrame:CGRectMake(0, (underRepairDetailsView.frame.size.height + 50) + 100 * i, self.view.frame.size.width, 100) andNameJob:[dictDataJob objectForKey:@"akt_money_job"] andPriceJob:[dictDataJob objectForKey:@"akt_money_price"] andView:self.view];
            [mainScrollView addSubview:jobUnderRepair];
            
            if (i != arrayJob.count - 1) {
                UIView * viewLine = [[UIView alloc] initWithFrame:CGRectMake(40, jobUnderRepair.frame.origin.y + 99.5, self.view.frame.size.width - 80, 0.5)];
                viewLine.backgroundColor = [UIColor colorWithHexString:@"929597"];
                [mainScrollView addSubview:viewLine];
            }
   
        }
        
        mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, (underRepairDetailsView.frame.size.height + 300) + 100 * arrayJob.count);
        
        NSInteger toPay = 0;
        toPay = numberInTotal + [[dictResponse objectForKey:@"inwork_prepay"]integerValue];
        
        
        UnderRepairDetailsView * inTotal = [[UnderRepairDetailsView alloc] initWithCuntomFrame:CGRectMake(0, (underRepairDetailsView.frame.size.height + 100) + 100 * arrayJob.count, self.view.frame.size.width, 100) andInTotal:[NSString stringWithFormat:@"%ld", (long)numberInTotal] andPrepayment:[dictResponse objectForKey:@"inwork_prepay"] andToPay:[NSString stringWithFormat:@"%ld", (long)toPay] andView:self.view];
        [mainScrollView addSubview:inTotal];
        
    }];
}


#pragma mark - API

- (void) getDeviceWithPhone: (NSString*) phone
                andInworkId: (NSString*) inworkId andBlock: (void (^)(void))block
{
    APIGetClass * apiDevice = [APIGetClass new];
    NSDictionary * dictParams = [NSDictionary dictionaryWithObjectsAndKeys:phone, @"phone",
                                                                        inworkId, @"inwork_id", nil];
   [apiDevice getDataFromServerWithParams:dictParams method:@"get_inwork" complitionBlock:^(id response) {
       
        dictResponse = (NSDictionary*) response;
       
       if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
           NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
       } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {

       }
       
       block();

   }];
    
}

#pragma mark - ButtonsMethos

//Метод кнопки buttonOrders
- (void) buttonOrdersAction
{
    NSLog(@"buttonOrdersAction");
}

@end
