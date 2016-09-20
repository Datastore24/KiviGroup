//
//  OrderController.h
//  Sadovod
//
//  Created by Виктор Мишустин on 22/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "MainViewController.h"

@interface OrderController : MainViewController
@property (strong,nonatomic) NSString* productID;
@property (strong,nonatomic) NSString* productName;
@property (strong,nonatomic) NSString* productPrice;

@end
