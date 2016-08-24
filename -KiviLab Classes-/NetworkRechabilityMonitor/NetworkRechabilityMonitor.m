//
//  NetworkRechabilityMonitor.m
//  ITDolgopa
//
//  Created by Кирилл Ковыршин on 02.03.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "NetworkRechabilityMonitor.h"
#import <AFNetworking/AFNetworking.h>
#import "Macros.h"

@implementation NetworkRechabilityMonitor

#pragma mark - Start Monitoring Network Manager
+(void)startNetworkReachabilityMonitoring {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

#pragma mark - Check Internet Network Status
+(BOOL)checkNetworkStatus {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+(void)showNoInternet: (UIView *) view andShow:(BOOL) showGlass{
    //Проверка телефона и кода
    UIView * checkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 189)];
    checkView.center = view.center;
    checkView.tag=4010;
    
    UIImageView * imageGlassCheck = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 290, 189)];
    imageGlassCheck.image = [UIImage imageNamed:@"Glass90.png"];
    imageGlassCheck.alpha=1;
    
    
    UILabel * labelNoInternet = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 290, 40)];
    labelNoInternet.text = @"Нет Интернет соединения...";
    labelNoInternet.textColor = [UIColor blackColor];
    labelNoInternet.font = [UIFont fontWithName:MAINFONTLOGINVIEW size:17];
    
//
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

    activityIndicator.center=CGPointMake(checkView.frame.size.width/2,checkView.frame.size.height/2+30);
    activityIndicator.tag=4011;
    
    if(showGlass){
        [activityIndicator startAnimating];
    
        [checkView addSubview:imageGlassCheck];
        [checkView addSubview:labelNoInternet];
        
        [checkView addSubview:activityIndicator];
        [view addSubview:checkView];
    }else{
     
        UIView * checkViewTag = (UIView *)[view viewWithTag:4010];
        UIActivityIndicatorView *activityIndicatorTag = (UIActivityIndicatorView *) [view viewWithTag:4011];
        [activityIndicatorTag stopAnimating];
        [activityIndicatorTag setHidden:YES];
        [checkViewTag removeFromSuperview];
    }
    
    //
    
}

@end
