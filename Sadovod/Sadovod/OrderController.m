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
#import "APIGetClass.h"
#import "SingleTone.h"
#import "Macros.h"

@interface OrderController () <OrderViewDelegate>

@property (strong, nonatomic) NSDictionary * arrayData;
@property (strong, nonatomic) OrderView * mainView;

@end

@implementation OrderController


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    CGRect rectView = self.mainView.frame;
    rectView.origin.y = 0;
    rectView.size.height = self.view.frame.size.height;
    self.mainView.frame = rectView;
    self.mainView.mainScrollView.frame = rectView;

}

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:self.productName andBarButtonAlpha: YES andButtonBasket: NO]; //Ввод
     [self initializeCartBarButton]; //Инициализация кнопок навигации
    //    [self.navigationController setNavigationBarHidden:NO];
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
    
    
#pragma mark - View
    [self getApiProduct:^{
        self.mainView = [[OrderView alloc] initWithView:self.view andData:self.arrayData];
       

        self.mainView.delegate = self;
        [self.view addSubview:self.mainView];
        

    } andProductID:self.productID];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkOrder:) name:NOTIFICATION_CHECK_COUNT_ORDER object:nil];
   
    
    //Параметры кнопки корзины
    self.buttonBasket.alpha = 0.4;
    self.buttonBasket.userInteractionEnabled = NO;
    
}

#pragma mark - OrderViewDelegate

- (void) pushTuBiyView: (OrderView*) orderView {
    BuyViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"BuyViewController"];
    [self.navigationController pushViewController:detail animated:NO];
}

- (void) getApiAddCart: (OrderView*) orderView andProductID: (NSString *) productID andCount: (NSString *) countProduct
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",
                             productID,@"price",
                             countProduct, @"count",
                             nil];
    
    [api getDataFromServerWithParams:params method:@"cart_change_count" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            
            //self.arrayData = [respDict objectForKey:@"product"];
            
            NSLog(@"%@",[respDict objectForKey:@"message"]);
            
            
            
        }
        
    }];
    
}

- (void) showBottomBar: (OrderView*) orderView {

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

- (void) checkOrder: (NSNotification*) notification {
    //Параметры кнопки корзины
    self.buttonBasket.alpha = 1.;
    self.buttonBasket.userInteractionEnabled = YES;
}

#pragma  mark - API


-(void) getApiProduct: (void (^)(void))block andProductID: (NSString *) productID
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",
                             productID,@"product",
                             nil];
    
    [api getDataFromServerWithParams:params method:@"product" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            
            self.arrayData = [respDict objectForKey:@"product"];
            
            
            block();
            
            
        }
        
    }];
    
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




@end
