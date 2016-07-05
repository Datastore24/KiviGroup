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

@implementation CheckoutController

- (void) viewDidLoad
{
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = NO;
    //Заголовок--------------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"ОФОРМЛЕНИЕ"];
    self.navigationItem.titleView = title;
    
#pragma mark - Initializayion
    
    CheckoutView * mainView = [[CheckoutView alloc] initWithView:self.view];
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

@end