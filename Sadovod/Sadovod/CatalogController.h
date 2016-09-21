//
//  CatalogController.h
//  Sadovod
//
//  Created by Виктор Мишустин on 12/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "MainViewController.h"

@interface CatalogController : MainViewController

@property (strong, nonatomic) NSArray * arrayName; //Массив с Категориями
@property (strong, nonatomic) NSArray * arrayProduct; //Массив с Категориями
@property (strong,nonatomic) NSString* productName;
@property (strong,nonatomic) NSDictionary* cartDict;

@end
