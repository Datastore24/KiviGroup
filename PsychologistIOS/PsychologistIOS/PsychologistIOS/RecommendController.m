//
//  RecommendController.m
//  PsychologistIOS
//
//  Created by Viktor on 10.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "RecommendController.h"
#import "TitleClass.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "RecommendView.h"
#import "APIGetClass.h"

@implementation RecommendController{
    NSDictionary * dictResponse;
}

- (void) viewDidLoad
{
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = NO;
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"РЕКОМЕНДУЮ"];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"d46559"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
#pragma mark - Initialization
    [self getAPIWithBlock:^{
        
        NSArray * mainArrayAPI = [NSArray arrayWithArray:[dictResponse objectForKey:@"data"]];
        RecommendView * recommendView = [[RecommendView alloc] initWithView:self.view andArray:mainArrayAPI];
        [self.view addSubview:recommendView];
       
        
    }];
    
    //Основной вью контент------------------------------------
    RecommendView * recommendView = [[RecommendView alloc] initWithView:self.view andArray:nil];
    [self.view addSubview:recommendView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendAction:) name:NOTIFICATION_SEND_PERSONAL_SMS object:nil];
    
    
}

#pragma mark - API

- (void) getAPIWithBlock: (void (^)(void))block
{

    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:nil method:@"list_personal" complitionBlock:^(id response) {
        
        dictResponse = (NSDictionary*) response;
         NSLog(@"%@", dictResponse );
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            block();
        }
    }];
}

-(void)sendAction: (NSNotification*) notification{
    
    NSDictionary * dictSend = notification.object;
    [self sendSMS:[dictSend objectForKey:@"phone"] andtime:[dictSend objectForKey:@"time"]
        andPersonalID:[dictSend objectForKey:@"personal_id"]];
    
}

-(void) sendSMS:(NSString *) phone andtime:(NSString*) time andPersonalID:(NSString*) personalID
{
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             
                             phone,@"phone",
                             time,@"time",
                             personalID,@"personal_id",
                             nil];
    
    
    
    APIGetClass * getAPI = [[APIGetClass alloc] init];
    [getAPI getDataFromServerWithParams:params method:@"personal_call_back" complitionBlock:^(id response) {
        //        NSLog(@"%@", response);
        
        NSDictionary * result = (NSDictionary*)response;
        NSLog(@"resp: %@",result);
        
    }];
}

#pragma mark - DEALLOC
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
     

@end
