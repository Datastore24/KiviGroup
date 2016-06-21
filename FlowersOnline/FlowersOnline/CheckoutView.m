//
//  CheckoutView.m
//  FlowersOnline
//
//  Created by Viktor on 20.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "CheckoutView.h"
#import "InputTextView.h"

@implementation CheckoutView

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 64, view.frame.size.width, view.frame.size.height - 64);
        
        NSArray * arrayPlaceHolder = [NSArray arrayWithObjects:
                                      @"Имя получателя", @"Телефон получателя",
                                      @"Email получателя", @"Адрес получателя",
                                      @"Комментарий к заказу", nil];
        
        for (int i = 0; i < arrayPlaceHolder.count; i++) {
            InputTextView * inputText = [[InputTextView alloc] initCheckoutWithView:self PointY:80 + 50 * i andTextPlaceHolder:[arrayPlaceHolder objectAtIndex:i]];
            inputText.tag = 20 + i;
            [self addSubview:inputText];
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
}

@end
