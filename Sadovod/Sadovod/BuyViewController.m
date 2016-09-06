//
//  BuyViewController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 26/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "BuyViewController.h"
#import "BuyView.h"
#import "Macros.h"
#import "HexColors.h"
#import "BasketController.h"
#import "FormalizationController.h"

@interface BuyViewController () <BuyViewDelegate>

@property (strong, nonatomic) UILabel * label;
@property (strong, nonatomic) NSArray * arrayData;

@end

@implementation BuyViewController

//Кастомный лейбл наносится на верхний бар
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if (self.label == nil) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 80, 24, 80, 40)];
        self.label.text = @"220 руб";
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        [self.navigationController.view.window addSubview:self.label];
    } else {
        self.label.alpha = 1.f;
    }
}

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"Капри" andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    self.arrayData = [self setCustonArray];
    
#pragma mark - View
    
    BuyView * mainView = [[BuyView alloc] initWithView:self.view andData:self.arrayData];
    mainView.deleagte = self;
    [self.view addSubview:mainView];
    
    
    //Временное вью для отображения корзины и оформления
    //--------------------------
    UIView * viewBasket = [[UIView alloc] initWithFrame:CGRectMake(0.f, self.view.frame.size.height - 50.f, self.view.frame.size.width, 50.f)];
    viewBasket.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"000000" alpha:0.5];
    
    UIButton * buttonBasket = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonBasket.frame = CGRectMake(10.f, 0.f, self.view.frame.size.width - 110.f, 50.f);
    [buttonBasket setTitle:@"Итого 1 шт на 400 руб" forState:UIControlStateNormal];
    [buttonBasket setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonBasket.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
    buttonBasket.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [buttonBasket addTarget:self action:@selector(buttonBasketAction) forControlEvents:UIControlEventTouchUpInside];
    [viewBasket addSubview:buttonBasket];
    
    UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100.f, 0.f, 1.f, 50.f)];
    backgroundView.backgroundColor = [UIColor blackColor];
    [viewBasket addSubview:backgroundView];
    
    UIButton * buttonContents = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonContents.frame = CGRectMake(self.view.frame.size.width - 99.f, 0.f, 99.f, 50.f);
    [buttonContents setTitle:@"Оформить" forState:UIControlStateNormal];
    [buttonContents setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonContents.titleLabel.font = [UIFont fontWithName:VM_FONT_BOLD size:15];
    [buttonContents addTarget:self action:@selector(buttonContentsAction) forControlEvents:UIControlEventTouchUpInside];
    [viewBasket addSubview:buttonContents];
    
    
    [self.view addSubview:viewBasket];
    
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    
    self.label.alpha = 0.f;
    
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

#pragma mark - BuyViewDelegate

- (void) addCountOrder: (BuyView*) buyView {
//    self.mainViewOrder.alpha = 1.f;
}

- (void) hideCountOrder: (BuyView*) buyView {
//    self.mainViewOrder.alpha = 0.f;
}



//Тестовые селекторы для переходов в корзину и оформление
- (void) buttonBasketAction {
    BasketController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"BasketController"];
    [self.navigationController pushViewController:detail animated:NO];
}

- (void) buttonContentsAction {
    FormalizationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"FormalizationController"];
    [self.navigationController pushViewController:detail animated:NO];
}
 
@end
