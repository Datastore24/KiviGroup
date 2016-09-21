//
//  MenuViewController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 12/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "MenuViewController.h"
#import "HexColors.h"
#import "Macros.h"
#import "TableMenuCell.h"
#import "UIView+BorderView.h"
#import "SingleTone.h"
#import "PopAnimator.h"
#import "PushAnimator.h"

@interface MenuViewController () <UINavigationControllerDelegate>

@property (strong, nonatomic) NSArray * arrayCell;
@property (strong, nonatomic) NSArray * arrayNames;
@property (strong, nonatomic) NSArray * arrayImages;

@end

@implementation MenuViewController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
//    self.navigationController.delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 20)];
    view.backgroundColor=[UIColor blackColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(autorization:) name:NOTIFICATION_AUTORIZATION object:nil];
    
    
    //Основной цвет--------------------------
    self.view.backgroundColor = [UIColor whiteColor];
    
    //Настройки таблицы ---------------------
    self.tableMenu.scrollEnabled = NO;
    self.tableMenu.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableMenu.backgroundColor = [UIColor clearColor];
    
    //Массив ячеек----------
    self.arrayCell = [NSArray arrayWithObjects:@"Cell1", @"Cell2", @"Cell3", @"Cell4", @"Cell5",
                      @"Cell6", @"Cell7", @"Cell8", @"Cell9", @"Cell10", @"Cell11", @"Cell12", @"Cell13", nil];
    
    if ([[[SingleTone sharedManager] typeMenu] isEqualToString:@"0"]) {
        //Массив заголовков-----
        self.arrayNames = [NSArray arrayWithObjects:@"Каталог товаров", @"Позвонить нам",
                           @"Авторизация", @"Регистрация", @"Задать вопрос", @"Частые вопросы",
                           @"Доставка", @"Оплата", @"Контакты", @"О магазине", @"Возврат", @"Таблица размеров", @"", nil];
        //Массив картинок-------
        self.arrayImages = [NSArray arrayWithObjects:@"imageMenu1.png", @"imageMenu2.png", @"imageMenu13.png", @"registrationMenuImage.png",
                            @"imageMenu5.png", @"imageMenu6.png", @"imageMenu7.png", @"imageMenu8.png", @"imageMenu9.png", @"imageMenu10.png",
                            @"imageMenu11.png", @"imageMenu12.png", @"", nil];
    } else {
        //Массив заголовков-----
        self.arrayNames = [NSArray arrayWithObjects:@"Каталог товаров", @"Позвонить нам",
                           @"Мой профиль", @"Мои заказы", @"Задать вопрос", @"Частые вопросы",
                           @"Доставка", @"Оплата", @"Контакты", @"О магазине", @"Возврат", @"Таблица размеров", @"Выход", nil];
        //Массив картинок-------
        self.arrayImages = [NSArray arrayWithObjects:@"imageMenu1.png", @"imageMenu2.png", @"personMenuImage.png", @"imageMenu4.png",
                            @"imageMenu5.png", @"imageMenu6.png", @"imageMenu7.png", @"imageMenu8.png", @"imageMenu9.png", @"imageMenu10.png",
                            @"imageMenu11.png", @"imageMenu12.png", @"exitMenu.png", nil];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

//Колличество ячеек в таблице----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayCell.count;
}
//Создание ячеек----------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = [self.arrayCell objectAtIndex:indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = nil;
    //Подвязываем картинки и заголовки--------
    TableMenuCell * customCell = [[TableMenuCell alloc] init];
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    if ([[self.arrayNames objectAtIndex:indexPath.row] isEqualToString:@""]) {
        cell.userInteractionEnabled = NO;
    } else {
        cell.userInteractionEnabled = YES;
    }
    [cell.contentView addSubview:[customCell setCellListWithName:[self.arrayNames objectAtIndex:indexPath.row]
                                        andImageName:[self.arrayImages objectAtIndex:indexPath.row]
                                         andMainView:cell]];
    
    return cell;
}

//Метод выстраения ячеек в навигационной таблице (используется элементы доп библиотеки)----------
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }
}


#pragma mark - UITableViewDelegate

//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        [[SingleTone sharedManager] setBoolPhone:YES];
    } else {
        [[SingleTone sharedManager] setBoolPhone:NO];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 12) {
        [[SingleTone sharedManager] setTypeMenu:@"0"];
        //Массив заголовков-----
        self.arrayNames = [NSArray arrayWithObjects:@"Каталог товаров", @"Позвонить нам",
                           @"Авторизация", @"Регистрация", @"Задать вопрос", @"Частые вопросы",
                           @"Доставка", @"Оплата", @"Контакты", @"О магазине", @"Возврат", @"Таблица размеров", @"", nil];
        //Массив картинок-------
        self.arrayImages = [NSArray arrayWithObjects:@"imageMenu1.png", @"imageMenu2.png", @"imageMenu13.png", @"registrationMenuImage.png",
                            @"imageMenu5.png", @"imageMenu6.png", @"imageMenu7.png", @"imageMenu8.png", @"imageMenu9.png", @"imageMenu10.png",
                            @"imageMenu11.png", @"imageMenu12.png", @"", nil];
        [self.tableMenu reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 42.1f;
}

#pragma mark - Actions

- (void) autorization: (NSNotification*) notification {
    
    //Массив заголовков-----
    self.arrayNames = [NSArray arrayWithObjects:@"Каталог товаров", @"Позвонить нам",
                       @"Мой профиль", @"Мои заказы", @"Задать вопрос", @"Частые вопросы",
                       @"Доставка", @"Оплата", @"Контакты", @"О магазине", @"Возврат", @"Таблица размеров", @"Выход", nil];
    //Массив картинок-------
    self.arrayImages = [NSArray arrayWithObjects:@"imageMenu1.png", @"imageMenu2.png", @"personMenuImage.png", @"imageMenu4.png",
                        @"imageMenu5.png", @"imageMenu6.png", @"imageMenu7.png", @"imageMenu8.png", @"imageMenu9.png", @"imageMenu10.png",
                        @"imageMenu11.png", @"imageMenu12.png", @"exitMenu.png", nil];
    
    [self.tableMenu reloadData];
}

#pragma mark - Other

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

@end
