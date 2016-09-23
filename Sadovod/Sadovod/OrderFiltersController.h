//
//  OrderFiltersController.h
//  Sadovod
//
//  Created by Виктор Мишустин on 25/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "MainViewController.h"
#import "NMRangeSlider.h"

@interface OrderFiltersController : MainViewController
@property (strong, nonatomic) NSString * catID;
@property (strong, nonatomic) NSString * cost;
@property (strong, nonatomic) NSString * sort;
@property (strong, nonatomic) NSString * filter;
@property (strong, nonatomic) NSString * countProduct;


@end
