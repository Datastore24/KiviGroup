//
//  CatalogDetailController.h
//  Sadovod
//
//  Created by Виктор Мишустин on 19/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "MainViewController.h"

@interface CatalogDetailController : MainViewController
@property (strong, nonatomic) NSString * catID;
@property (strong, nonatomic) NSString * catName;
@property (strong, nonatomic) NSString * cost;
@property (strong, nonatomic) NSString * sort;
@property (strong, nonatomic) NSString * filter;
@property (strong, nonatomic) NSArray * arrayData;


@property (strong,nonatomic) NSString* productName;
@property (strong,nonatomic) NSString* productPrice;

@end
