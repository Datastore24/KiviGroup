//
//  OrderFiltersController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 25/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "OrderFiltersController.h"
#import "OrderFiltersView.h"

@interface OrderFiltersController () <OrderFiltersViewDelegate>

@property (strong, nonatomic) NSArray * arrayData;

@end

@implementation OrderFiltersController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"Фильтр - 454 товаров" andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    self.arrayData = [self setCustonArray];
    
#pragma mark - View
    OrderFiltersView * mainView = [[OrderFiltersView alloc] initWithView:self.view andData:self.arrayData];
    mainView.delegate = self;
    [self.view addSubview:mainView];    
}


#pragma mark - Actions

- (void) buttonBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - OrderFiltersViewDelegate

- (void) backTuCatalog: (OrderFiltersView*) orderFiltersView {
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSMutableArray*) setCustonArray
{
    NSMutableArray * mArray = [[NSMutableArray alloc] init];
    
    NSArray * arraySize = [NSArray arrayWithObjects:
                           @"36", @"38", @"40", @"42",
                           @"44", @"46", @"48", @"50",
                           @"52", @"54", @"56", @"58",
                           @"60", @"62", @"64", @"68", nil];
    NSArray * arrayColor = [NSArray arrayWithObjects:
                            @"3333ff", @"ff0000", @"ffffff", @"666666", @"85d6ff", @"009900",
                            @"000000", @"663300", @"ff00bb", @"9900cc", @"ffff00", @"ff6600", @"ffeedd", nil];
    
    
    //Кнопки
    NSArray * arraySilhouette = [NSArray arrayWithObjects:@"прямой", @"приталенный", @"свободный", nil];
    NSArray * arrayModel = [NSArray arrayWithObjects:@"блуза", @"туника", @"кофточка", @"рубашка", nil];
    NSArray * arraySeason = [NSArray arrayWithObjects:@"лето", @"весна/осень", nil];
    NSArray * arrayPattern = [NSArray arrayWithObjects:@"однотонный", @"принт", @"цветочный", @"горошек", @"полоска", @"ромб", @"клетка", nil];
    NSArray * arraySleeve = [NSArray arrayWithObjects:@"короткий", @"прямой", @"отсутствует", @"3/4", nil];
    NSArray * arrayClasp = [NSArray arrayWithObjects:@"без застежки", @"пуговицы", @"молния", @"кнопки", nil];
    NSArray * arrayNeckline = [NSArray arrayWithObjects:@"круглый", @"V-образный", @"каре", @"U-образны", @"лодочка", @"американская пройма", nil];
    NSArray * arrayOther = [NSArray arrayWithObjects:@"Джинсовая", @"Трикотажная", @"С цветами", @"хлопок", @"вискоза", @"синтетика", @"шелк", @"лайкра", @"полиэстер", @"атлас", nil];
    
    
    
    
    //Загаловки
    NSArray * arrayNames = [NSArray arrayWithObjects:@"Силуэт", @"Модель", @"Сезон", @"Узор", @"Рукав", @"Застежка", @"Вырез", @"Прочее", nil];
    
    NSArray * arrayDetails = [NSArray arrayWithObjects:arraySilhouette, arrayModel, arraySeason, arrayPattern, arraySleeve, arrayClasp, arrayNeckline, arrayOther, nil];
    NSMutableArray * detailArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < arrayDetails.count; i++) {
        NSDictionary * dictDetail = [NSDictionary dictionaryWithObjectsAndKeys:[arrayDetails objectAtIndex:i], @"array", [arrayNames objectAtIndex:i], @"name", nil];
        [detailArray addObject:dictDetail];
    }
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:arraySize, @"size", arrayColor, @"color", arraySilhouette, @"silhouette", detailArray, @"detail", nil];
    [mArray addObject:dict];
    
    
    return mArray;
}

@end
