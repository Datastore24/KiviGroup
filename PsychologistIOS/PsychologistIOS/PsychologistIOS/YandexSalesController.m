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
    [self.view addSubview:mainWeb];
    session = [[YMAAPISession alloc] init];
    NSDictionary *additionalParameters = @{
                                           YMAParameterResponseType    : YMAValueParameterResponseType, //Constant parameter
                                           YMAParameterRedirectUri     : @"http://psy.kivilab.ru/API/api.php?api_key=ww5CkGQpkFInVEkGceLxJUZ32BxYQZQqBk53spf&action=yandex",          //URI that the OAuth server sends the authorization result to.
                                           YMAParameterScope           : @"payment-p2p"                 //A list of requested permissions.
                                           };
    // session - instance of YMAAPISession class
    // webView - instance of UIWebView class
    NSURLRequest *authorizationRequest =  [session authorizationRequestWithClientId:@"BF597AD73D170C2623FBF54CABC2C852CD2A6CA96CFE5BFD645B80872E9F532B" additionalParameters:additionalParameters];
    
    [mainWeb loadRequest:authorizationRequest];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL shouldStartLoad = YES;
    NSMutableDictionary *authInfo = nil;
    NSError *error = nil;
    // session - instance of YMAAPISession class
    if ([session isRequest:request
                  toRedirectUrl:@"http://psy.kivilab.ru/API/api.php?api_key=ww5CkGQpkFInVEkGceLxJUZ32BxYQZQqBk53spf&action=yandex"
              authorizationInfo:&authInfo
                          error:&error]) {
        shouldStartLoad = NO;
        if (error == nil) {
            NSString *authCode = authInfo[@"code"];
            
            NSDictionary *additionalParameters = @{
                                                   @"grant_type"           : @"authorization_code", // Constant parameter
                                                   YMAParameterRedirectUri : @"http://psy.kivilab.ru/API/api.php?api_key=ww5CkGQpkFInVEkGceLxJUZ32BxYQZQqBk53spf&action=yandex"
                                                   };
            
            // session  - instance of YMAAPISession class
            // authCode - temporary authorization code
            [session receiveTokenWithCode:authCode
                                 clientId:@"BF597AD73D170C2623FBF54CABC2C852CD2A6CA96CFE5BFD645B80872E9F532B"
                     additionalParameters:additionalParameters
                               completion:^(NSString *instanceId, NSError *error) {
                                   if (error == nil && instanceId != nil && instanceId.length > 0) {
                                       NSString *accessToken = instanceId;
                                       token = accessToken;

                                   }
                                   else {
                                       // Process error
                                   }
                               }];
        }
    }
    return shouldStartLoad;
}

@end
