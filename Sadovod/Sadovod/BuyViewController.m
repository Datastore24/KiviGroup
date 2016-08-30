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

@interface BuyViewController ()

@property (strong, nonatomic) UILabel * label;
@property (strong, nonatomic) NSArray * arrayData;

@end

@implementation BuyViewController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if (self.label == nil) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 80, 20, 80, 40)];
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
    
#pragma mark - View
    
    

}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    
    self.label.alpha = 0.f;
    
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

#pragma mark - Actions

- (void) buttonBackAction {
    [self.navigationController popViewControllerAnimated:NO];
}

@end
