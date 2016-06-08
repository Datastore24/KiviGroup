//
//  YandexSalesController.m
//  PsychologistIOS
//
//  Created by Viktor on 11.05.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "YandexSalesController.h"
#import "YMAAPISession.h"
#import "YMAHostsProvider.h"
#import <YandexMoneySDKObjc/YMAAPISession.h>
#import "YMAExternalPaymentRequest.h"
#import "YMAExternalPaymentResponse.h"
#import "SingleTone.h"

@interface YandexSalesController () <UIWebViewDelegate>

@end

@implementation YandexSalesController
{
    UIWebView * mainWeb;
    YMAAPISession * session;
    NSString * token;
}

- (void) viewDidLoad
{
    mainWeb = [[UIWebView alloc] initWithFrame:self.view.frame];
    mainWeb.delegate = self;
    
    NSString * paymentType = @"";
    NSString * shopId = @"58658";
    NSString * scid = @"536545";
    NSString * sum = @"10";
    //customerNumber - id пользователя
    NSString * customerNumber = [[SingleTone sharedManager] userID];
    //shopArticleId - идентификатор тарифа
    NSString * id_tariff = @"";
    NSString * id_category = @"";
    NSString *urlStr = [NSString stringWithFormat:@"https://demomoney.yandex.ru/eshop.xml?paymentType=%@&shopId=%@&scid=%@&sum=%@&customerNumber=%@&id_tariff=%@&id_category=%@",paymentType, shopId, scid, sum, customerNumber, id_tariff, id_category];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [mainWeb loadRequest:requestObj];
    [self.view addSubview:mainWeb];

}



@end
