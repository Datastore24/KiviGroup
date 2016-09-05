//
//  BasketController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 30/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "BasketController.h"
#import "Macros.h"
#import "HexColors.h"
#import "BasketView.h"
#import "CatalogController.h"

@interface BasketController () <BasketViewGelegate>

@property (strong, nonatomic) NSArray * arrayData;

@end

@implementation BasketController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"Корзина" andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    self.arrayData = [self setCustonArray];
    
#pragma mark - View
    
    BasketView * mainView = [[BasketView alloc] initWithView:self.view andData:self.arrayData];
    mainView.delegate = self;
    [self.view addSubview:mainView];

    
    
}

- (NSMutableArray*) setCustonArray
{
    NSMutableArray * arrayDetails = [[NSMutableArray alloc] init];
    NSArray * arrayName = [NSArray arrayWithObjects: @"Кеды", @"Свитер", @"Штаны", @"Рубашка", nil];
    NSArray * arraySize = [NSArray arrayWithObjects:@"37", @"40", @"35", @"39", nil];
    NSArray * arrayCount = [NSArray arrayWithObjects:@"1", @"2", @"1", @"1", nil];
    NSArray * arrayPrice = [NSArray arrayWithObjects:@"453", @"347", @"275", @"393", nil];
    NSArray * arrayImage = [NSArray arrayWithObjects:@"basketImage4.png", @"basketImage1.png", @"basketImage2.png", @"busketImage3.png", nil];
    
    
    
    for (int i = 0; i < arrayName.count; i++) {
        NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:
                               [arrayName objectAtIndex:i], @"name",
                               [arraySize objectAtIndex:i], @"size",
                               [arrayCount objectAtIndex:i], @"count",
                               [arrayPrice objectAtIndex:i], @"price",
                               [arrayImage objectAtIndex:i], @"image", nil];
        [arrayDetails addObject:dict];
    }
    
    
    
    return arrayDetails;
}

#pragma mark - Actions

- (void) buttonBackAction {
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - BasketViewGelegate

- (void) backTuCatalog: (BasketView*) basketView {
    
    CatalogController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogController"];
    [self.navigationController pushViewController:detail animated:YES];
    
}

@end
