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

@implementation CheckoutView

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 64, view.frame.size.width, view.frame.size.height - 64);
        AuthDBClass * authDbClass = [AuthDBClass new];
        
        if([authDbClass checkRegistration]){
            NSLog(@"ДАННЫЕ ЕСТЬ");
            NSArray * userArray = [authDbClass showAllUsers];
            Auth * auth = [userArray objectAtIndex:0];
            NSLog(@"%@",auth.name);
            
            NSArray * arrayText = [NSArray arrayWithObjects:
                                          auth.name, auth.phone,
                                          auth.email, auth.address,
                                           @"Комментарий к заказу",nil];
            
            for (int i = 0; i < arrayText.count; i++) {
                InputTextView * inputText = [[InputTextView alloc] initCheckoutWithView:self PointY:80 + 50 * i andTextPlaceHolder:nil];
                inputText.tag = 20 + i;
                if (isiPhone5) {
                    inputText.height = 40 + 50 * i;
                } else if (isiPhone4s) {
                    inputText.height = 15 + 38 * i;
                }
                inputText.textFieldInput.text=[arrayText objectAtIndex:i];
                [self addSubview:inputText];
            }
            
        }else{
             NSLog(@"ДАННЫХ НЕТ");
            
            NSArray * arrayPlaceHolder = [NSArray arrayWithObjects:
                                          @"Имя получателя", @"Телефон получателя",
                                          @"Email получателя", @"Адрес получателя",
                                          @"Комментарий к заказу", nil];
            
            for (int i = 0; i < arrayPlaceHolder.count; i++) {
                InputTextView * inputText = [[InputTextView alloc] initCheckoutWithView:self PointY:80 + 50 * i andTextPlaceHolder:[arrayPlaceHolder objectAtIndex:i]];
                inputText.tag = 20 + i;
                if (isiPhone5) {
                    inputText.height = 40 + 50 * i;
                } else if (isiPhone4s) {
                    inputText.height = 15 + 38 * i;
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
    NSLog(@"Push");
     AuthDBClass * authDbClass = [AuthDBClass new];
    InputTextView * name = (InputTextView *)[self viewWithTag:20];
    InputTextView * phone = (InputTextView *)[self viewWithTag:21];
    InputTextView * email = (InputTextView *)[self viewWithTag:22];
    InputTextView * address = (InputTextView *)[self viewWithTag:23];
    [authDbClass registerUser:name.textFieldInput.text andEmail:email.textFieldInput.text
                   andAddress:address.textFieldInput.text andPhone:phone.textFieldInput.text];
    
}

@end
