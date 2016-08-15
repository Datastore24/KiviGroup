//
//  CheckoutView.m
//  FlowersOnline
//
//  Created by Viktor on 20.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "CheckoutView.h"
#import "InputTextView.h"
#import "Auth.h"
#import "AuthDBClass.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>
#import "SingleTone.h"
#import "APIGetClass.h"
#import "MessagePopUp.h";

@implementation CheckoutView

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 64, view.frame.size.width, view.frame.size.height - 64);
        AuthDBClass * authDbClass = [AuthDBClass new];
        NSArray * arrayPlaceHolder = [NSArray arrayWithObjects:
                                      @"Имя получателя", @"Телефон получателя",
                                      @"Email получателя", @"Адрес получателя",
                                      @"Комментарий к заказу", nil];

        UIKeyboardType type;
        if([authDbClass checkRegistration]){
            NSLog(@"ДАННЫЕ ЕСТЬ");
            NSLog(@"TOTAL %@",[[SingleTone sharedManager] allPrice]);
            NSArray * userArray = [authDbClass showAllUsers];
            Auth * auth = [userArray objectAtIndex:0];
            NSArray * arrayText = [NSArray arrayWithObjects:
                                          auth.name, auth.phone,
                                          auth.email, auth.address,
                                           @"",nil];
            
            for (int i = 0; i < arrayText.count; i++) {
                if (i == 1) {
                    type = UIKeyboardTypeNumbersAndPunctuation;
                } else {
                    type = UIKeyboardTypeDefault;
                }
                InputTextView * inputText = [[InputTextView alloc] initCheckoutWithView:self PointY:80 + 50 * i andTextPlaceHolder:[arrayPlaceHolder objectAtIndex:i] andText:[arrayText objectAtIndex:i] andKeyboardType:type];
                if (i == 1) {
                    inputText.userInteractionEnabled = NO;
                }
                inputText.tag = 20 + i;
                if (isiPhone5) {
                    inputText.height = 40 + 50 * i;
                } else if (isiPhone4s) {
                    inputText.height = 15 + 38 * i;
                }
                
                [self addSubview:inputText];
            }
            
        }else{
            
            NSLog(@"ДАННЫХ НЕТ");
            
            for (int i = 0; i < arrayPlaceHolder.count; i++) {
                if (i == 1) {
                    type = UIKeyboardTypeNumbersAndPunctuation;
                } else {
                    type = UIKeyboardTypeDefault;
                }
                InputTextView * inputText = [[InputTextView alloc] initCheckoutWithView:self PointY:80 + 50 * i andTextPlaceHolder:[arrayPlaceHolder objectAtIndex:i] andText:nil andKeyboardType:type];
                inputText.tag = 20 + i;
                if (isiPhone5) {
                    inputText.height = 40 + 50 * i;
                } else if (isiPhone4s) {
                    inputText.height = 15 + 38 * i;
                }
                
                if (i == 1) {
                    inputText.textFieldInput.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                }
                
                [self addSubview:inputText];
            }
            
        }
        
        //Оформить заказ--------------------------------------
        UIButton * buttonCheckout = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonCheckout.frame = CGRectMake(20, self.frame.size.height - 100, self.frame.size.width - 40, 40);
        buttonCheckout.backgroundColor = [UIColor colorWithHexString:@"85af02"];
        [buttonCheckout setTitle:@"Оформить" forState:UIControlStateNormal];
        [buttonCheckout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonCheckout.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:20];
        [buttonCheckout addTarget:self action:@selector(buttonCheckoutAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonCheckout];
        
        
    }
    return self;
}

#pragma mark - Action Methods

- (void) buttonCheckoutAction
{
     AuthDBClass * authDbClass = [AuthDBClass new];
    InputTextView * name = (InputTextView *)[self viewWithTag:20];
    InputTextView * phone = (InputTextView *)[self viewWithTag:21];
    InputTextView * email = (InputTextView *)[self viewWithTag:22];
    InputTextView * address = (InputTextView *)[self viewWithTag:23];
    InputTextView * comment = (InputTextView *)[self viewWithTag:24];
    if (name.textFieldInput.text.length == 0) {
        [self createAlerWithMessage:@"Введите имя."];
    } else if (phone.textFieldInput.text.length == 0) {
        [self createAlerWithMessage:@"Введите Телефон."];
    } else if (email.textFieldInput.text.length == 0) {
        [self createAlerWithMessage:@"Введите email."];
    } else if (address.textFieldInput.text.length == 0) {
        [self createAlerWithMessage:@"Введите адрес."];
    } else {

        if (![authDbClass checkRegistration]) {
            [authDbClass registerUser:name.textFieldInput.text andEmail:email.textFieldInput.text andAddress:address.textFieldInput.text andPhone:phone.textFieldInput.text];
        } else {
        [authDbClass updateUser:name.textFieldInput.text andEmail:email.textFieldInput.text andAddress:address.textFieldInput.text];
        }
        NSMutableArray * array = [NSMutableArray array];
        NSMutableArray * arrayCount = [[SingleTone sharedManager] arrayBasketCount];
       
        
        for (int i = 0; i < [[SingleTone sharedManager] arrayBouquets].count; i++) {
            NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[[[SingleTone sharedManager] arrayBouquets] objectAtIndex:i]];
            [dict setObject:[arrayCount objectAtIndex:i] forKey:@"count"];
            [array addObject:dict];
        }
        
        NSString * stringNumber = [NSString stringWithFormat:@"+%@", phone.textFieldInput.text];
        NSDictionary * contactDataDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                          name.textFieldInput.text, @"name",
                                          email.textFieldInput.text, @"email",
                                          address.textFieldInput.text, @"address",
                                          stringNumber, @"phone",
                                           [[SingleTone sharedManager] allPrice], @"total_price",
                                          comment.textFieldInput.text, @"comment", nil];
        
        NSError * error;
        
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:array
                                                           options:NSJSONWritingPrettyPrinted error:&error];
        NSString* newStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSDictionary * sendDict = [NSDictionary dictionaryWithObjectsAndKeys:newStr, @"order",
                                   [[SingleTone sharedManager] delivery], @"delivery", contactDataDict, @"contactData", nil];
        
       

        //То что отправляем---------------------------
            APIGetClass * apiOrder = [APIGetClass new];
        
        [apiOrder getDataFromServerJSONWithParams:sendDict method:@"add_order" complitionBlock:^(id response) {
            NSLog(@"RESP %@",response);
         NSDictionary * dictResponse = (NSDictionary*) response;
            if([[dictResponse objectForKey:@"error"] integerValue] == 0){
                
               [MessagePopUp showPopUpWithBlock:@"Ваш заказ успешно принят!" view:self complitionBlock:^{
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
}

#pragma mark - Alert

- (void) createAlerWithMessage: (NSString*) message {
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    alert.customViewColor = [UIColor colorWithHexString:COLORGREEN];
    [alert showNotice:@"Внимание!" subTitle:message closeButtonTitle:@"Ок" duration:0.0f];
    
    
}

@end
