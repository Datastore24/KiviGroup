//
//  AlertClassCustom.m
//  Sadovod
//
//  Created by Виктор Мишустин on 21.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "AlertClassCustom.h"
#import <SCLAlertView.h>
#import "SingleTone.h"
#import "HexColors.h"
#import "Macros.h"

@implementation AlertClassCustom

+ (void) createAlertMinPrice {
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    
    NSInteger priceOrders = [[[SingleTone sharedManager] priceType] integerValue];
    NSString * stringPrice = [NSString stringWithFormat:@"%d", 1990 - priceOrders];
    alert.customViewColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_800];
    
    [alert showSuccess:@"Внимание!" subTitle:[NSString stringWithFormat:@"Минимальная сумма заказа 1990 руб. Вам необходимо набрать товаров еще на %@ руб.", stringPrice] closeButtonTitle:@"Ok" duration:0.0f];
    
    
}

@end
