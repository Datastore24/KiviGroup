//
//  OrderController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 22/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "OrderController.h"
#import "OrderView.h"
#import "BuyViewController.h"

@interface OrderController () <OrderViewDelegate>

@property (strong, nonatomic) NSArray * arrayData;

@end

@implementation OrderController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self initializeCartBarButton]; //Инициализация кнопок навигации
    [self setCustomTitle:@"Штаны черные" andBarButtonAlpha: YES andButtonBasket: NO]; //Ввод заголовка
    //    [self.navigationController setNavigationBarHidden:NO];
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
    self.arrayData = [self setCustonArray];
    
#pragma mark - View
   
    OrderView * mainView = [[OrderView alloc] initWithView:self.view andData:self.arrayData];
    mainView.delegate = self;
    [self.view addSubview:mainView];
        
    
}

#pragma mark - OrderViewDelegate

- (void) pushTuBiyView: (OrderView*) orderView {
    BuyViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"BuyViewController"];
    [self.navigationController pushViewController:detail animated:NO];
}

#pragma mark - Actions

- (void) buttonBackAction {
    [self.navigationController popViewControllerAnimated:NO];
}

- (NSMutableArray*) setCustonArray
{
    NSArray * arrayImage = [NSArray arrayWithObjects:
                            @"imageProduct1.jpg", @"imageProduct2.jpg", @"imageProduct3.jpg", nil];
    NSArray * arraySizes = [NSArray arrayWithObjects:@"40", @"42", @"44", @"46", nil];
    NSMutableArray * mArray = [[NSMutableArray alloc] init];
    
    NSArray * arratTitlsDetail = [NSArray arrayWithObjects:@"Цвет", @"Бренд", @"Силуэт", @"Модель", @"Сезон", @"Узор", @"Рукав", @"Застежка", @"Вырез", @"хлопок", @"полиэстер", @"ID", nil];
    NSArray * arratDetailText = [NSArray arrayWithObjects:@"красный", @"JRF", @"прямой", @"блуза", @"весна/осень", @"принт", @"прямой", @"без застежки", @"круглый", @"90%", @"10%", @"97941", nil];
    NSMutableArray * arrayDetails = [[NSMutableArray alloc] init];
    for (int i = 0; i < arratTitlsDetail.count; i++) {
        NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:
                               [arratTitlsDetail objectAtIndex:i], @"titl",
                               [arratDetailText objectAtIndex:i], @"text", nil];
        [arrayDetails addObject:dict];
    }
        NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:arrayImage, @"imageArray", arraySizes, @"sizeArray", @"310", @"price", arrayDetails, @"details", nil];
        [mArray addObject:dict];

    
    return mArray;
}



@end
