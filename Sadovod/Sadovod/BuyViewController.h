//
//  BuyViewController.h
//  Sadovod
//
//  Created by Виктор Мишустин on 26/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "MainViewController.h"

@interface BuyViewController : MainViewController
@property (strong,nonatomic) NSString* productID;
@property (strong,nonatomic) NSString* productName;
@property (strong,nonatomic) NSString* productPrice;


@end
