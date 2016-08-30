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

@interface BasketController ()

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
    
    
}

- (NSMutableArray*) setCustonArray
{
    NSMutableArray * arrayDetails = [[NSMutableArray alloc] init];
    NSArray * arraySizes = [NSArray arrayWithObjects:
                            @"36", @"37", @"38", @"39", @"40", @"41", nil];
    NSArray * arrayOrderCount = [NSArray arrayWithObjects:@"1", @"0", @"0", @"0", @"1", @"0", nil];
    
    for (int i = 0; i < arraySizes.count; i++) {
        NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:
                               [arraySizes objectAtIndex:i], @"size",
                               [arrayOrderCount objectAtIndex:i], @"count", nil];
        [arrayDetails addObject:dict];
    }
    
    
    
    return arrayDetails;
}

#pragma mark - Actions

- (void) buttonBackAction {
    [self.navigationController popViewControllerAnimated:NO];
}

@end
