//
//  NetworkRechabilityMonitor.h
//  ITDolgopa
//
//  Created by Кирилл Ковыршин on 02.03.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NetworkRechabilityMonitor : NSObject

+(void)startNetworkReachabilityMonitoring;
+(BOOL)checkNetworkStatus;
+(void)showNoInternet: (UIView *) view andShow:(BOOL) showGlass;

@end
