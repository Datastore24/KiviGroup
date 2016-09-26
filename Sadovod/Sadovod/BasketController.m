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
#import "PopAnimator.h"
#import "PushAnimator.h"
#import "APIGetClass.h"
#import "SingleTone.h"

@interface BasketController () <BasketViewGelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSArray * arrayData;
@property (strong, nonatomic) NSArray * arrayCart;

@end

@implementation BasketController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.delegate = self;
}

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
    
    [self getApiCart:^{
        
    }];
    
    BasketView * mainView = [[BasketView alloc] initWithView:self.view andData:self.arrayData];
    mainView.delegate = self;
    [self.view addSubview:mainView];

    
    
}

- (NSMutableArray*) setCustonArray
{
    NSMutableArray * arrayDetails = [[NSMutableArray alloc] init];
    NSArray * arrayName = [NSArray arrayWithObjects: @"Кеды", @"Свитер", @"Штаны", @"Рубашка", nil];
    NSArray * arraySize = [NSArray arrayWithObjects:@"37", @"40", @"Без размера", @"39", nil];
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
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - BasketViewGelegate

- (void) backTuCatalog: (BasketView*) basketView {
    
    CatalogController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogController"];
    [self.navigationController pushViewController:detail animated:YES];
    
}

#pragma mark - ANIMATION POP PUSH
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController*)fromVC
                                                 toViewController:(UIViewController*)toVC
{
    if (operation == UINavigationControllerOperationPush)
        return [[PushAnimator alloc] init];
    
    if (operation == UINavigationControllerOperationPop)
        return [[PopAnimator alloc] init];
    
    return nil;
}

#pragma mark - API
-(void) getApiCart: (void (^)(void))block
{
    APIGetClass * api =[APIGetClass new]; //создаем API
    
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             
                             [[SingleTone sharedManager] catalogKey], @"token",
                             @"ios_sadovod",@"appname",
                             nil];
    
    [api getDataFromServerWithParams:params method:@"cart_info_detail" complitionBlock:^(id response) {
        
        if([response isKindOfClass:[NSDictionary class]]){
            
            NSDictionary * respDict = (NSDictionary *) response;
            
            
            NSLog(@"CART %@",respDict);
            self.arrayCart = [respDict objectForKey:@"list"] ;
            
            block();
            
            
        }
        
    }];
    
}


@end
