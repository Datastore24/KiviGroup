//
//  CatalogController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 12/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "CatalogController.h"
#import "CatalogView.h"

@interface CatalogController ()

@end

@implementation CatalogController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"САДОВОД"]; //Ввод заголовка
//    [self.navigationController setNavigationBarHidden:NO];
    
#pragma mark - View
    
    CatalogView * mainView = [[CatalogView alloc] initWithView:self.view andData:[self setCustonArray]];
    [self.view addSubview:mainView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray*) setCustonArray
{
    NSArray * arrayImage = [NSArray arrayWithObjects:
                            @"imageProduct1.jpg", @"imageProduct2.jpg", @"imageProduct3.jpg", @"imageProduct4.jpg",
                            @"imageProduct5.jpg", @"imageProduct6.jpg", @"imageProduct7.jpg", @"imageProduct8.jpg",
                            @"imageProduct9.jpg", @"imageProduct10.jpg", nil];
    NSArray * arrayPrice = [NSArray arrayWithObjects:@"216", @"310", @"525", @"673", @"558", @"138", @"385", @"134", @"245", @"384", nil];
    NSMutableArray * mArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < arrayImage.count; i++) {
        NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[arrayImage objectAtIndex:i], @"image", [arrayPrice objectAtIndex:i], @"price", nil];
        [mArray addObject:dict];
    }
    
    return mArray;
}

@end
