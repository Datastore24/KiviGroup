//
//  CheckoutController.m
//  FlowersOnline
//
//  Created by Viktor on 20.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "CheckoutController.h"
#import "UIColor+HexColor.h"
#import "ButtonMenu.h"
#import "TitleClass.h"
#import "CheckoutView.h"
#import "SingleTone.h"
#import "BouquetsController.h"
#import "APIGetClass.h"
#import "MessagePopUp.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>

@interface CheckoutController () <CheckoutViewDelegate>



@end

@implementation CheckoutController



- (void) viewDidLoad
{
#pragma mark - Header
    //Заголовок--------------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"ОФОРМЛЕНИЕ"];
    self.navigationItem.titleView = title;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushMainView) name:@"sendDataandPushMainView" object:nil];
    
#pragma mark - Initializayion
    
    CheckoutView * mainView = [[CheckoutView alloc] initWithView:self.view];
    mainView.delegate = self;
    [self.view addSubview:mainView];
    
    

}

- (void) viewWillAppear:(BOOL)animated
{
    [[SingleTone sharedManager] viewBasketBar].alpha = 0;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [[SingleTone sharedManager] viewBasketBar]. alpha = 1;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) pushMainView {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"popNotificationToReleaseBouquetsView" object:nil];
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}


- (void) sendToServer: (CheckoutView*) bouquetsView withDict: (NSDictionary*) sendDict {
    
    //То что отправляем---------------------------
    APIGetClass * apiOrder = [APIGetClass new];
    
    [apiOrder getDataFromServerJSONWithParams:sendDict method:@"add_order" complitionBlock:^(id response) {
        NSLog(@"RESP %@",response);
        NSDictionary * dictResponse = (NSDictionary*) response;
        if([[dictResponse objectForKey:@"error"] integerValue] == 0){
            
            [MessagePopUp showPopUpWithBlock:@"Ваш заказ успешно принят!" view:bouquetsView complitionBlock:^{
                [[[SingleTone sharedManager] arrayBouquets] removeAllObjects];
                [[[SingleTone sharedManager] arrayBasketCount] removeAllObjects];
                [[SingleTone sharedManager] labelCountBasket].text = [NSString stringWithFormat:@"%d", 0];
                sleep(1.3f);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"sendDataandPushMainView" object:nil];
            }];
            
        }else{
            [self createAlerWithMessage:[dictResponse objectForKey:@"error_msg"]];
        }
        
        
        
        
        
        
        
    }];
}

- (void) createAlerWithMessage: (NSString*) message {
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    alert.customViewColor = [UIColor colorWithHexString:COLORGREEN];
    [alert showNotice:@"Внимание!" subTitle:message closeButtonTitle:@"Ок" duration:0.0f];
    
    
}

@end
