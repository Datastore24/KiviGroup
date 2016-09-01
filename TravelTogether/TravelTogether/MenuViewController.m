//
//  MenuViewController.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 02/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "MenuViewController.h"
#import "HexColors.h"
#import "Macros.h"
#import "TableMenuCell.h"
#import "UIView+BorderView.h"

@interface MenuViewController ()

@property (strong, nonatomic) NSArray * arrayCell;
@property (strong, nonatomic) NSArray * arrayNames;
@property (strong, nonatomic) NSArray * arrayImages;

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Основной цвет--------------------------
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:VM_COLOR_PINK];
    
    //Настройки таблицы ---------------------
    self.tableMenu.scrollEnabled = NO;
    self.tableMenu.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableMenu.backgroundColor = [UIColor clearColor];
    
    CGRect rectMenu;
    if (isiPhone6) {
        rectMenu = self.tableMenu.frame;
        rectMenu.origin.y += 30;
        self.tableMenu.frame = rectMenu;
    }
    
    //Массив ячеек----------
    self.arrayCell = [NSArray arrayWithObjects:@"Cell1", @"Cell2", @"Cell3", @"Cell4", @"Cell5",
                      @"Cell6", @"Cell7", @"Cell8", @"Cell9", @"Cell10", nil];
    
    //Массив заголовков-----
    self.arrayNames = [NSArray arrayWithObjects:@"МОИ ПУТЕШЕСТВИЯ", @"ИСКАТЬ ПОПУТЧИКОВ",
                       @"АНКЕТА", @"НАСТРОЙКИ", @"СВЯЗАТЬСЯ С НАМИ", @"СООБЩЕНИЯ", @"ВЫ ПОНРАВИЛИСЬ", @"ОЦЕНИТЬ ПРИЛОЖЕНИЕ", @"", @"", nil];
    
    //Массив картинок-------
    self.arrayImages = [NSArray arrayWithObjects:@"image1.png", @"image2.png", @"image3.png", @"image4.png",
                        @"image5.png", @"image6.png", @"image7.png", @"image8.png", @"", @"", nil];
    
    if (isiPhone6) {
        [UIView borderViewWithHeight:self.view.frame.size.height - 86 andWight:0 andView:self.view andColor:VM_COLOR_WHITE];
    } else {
    //Наносим границу
    [UIView borderViewWithHeight:self.view.frame.size.height - 79 andWight:0 andView:self.view andColor:VM_COLOR_WHITE];
    }
    //Logo
    UIImageView * imageLogo = [[UIImageView alloc] initWithFrame:CGRectMake(25.f, 35.f, 206.f, 51.f)];
    if (isiPhone6) {
        imageLogo.frame = CGRectMake(25.f, 50.f, 206.f, 51.f);
    }
    imageLogo.image = [UIImage imageNamed:@"logoMenu.png"];
    [self.view addSubview:imageLogo];
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
    [cell addSubview:[customCell setCellListWithName:[self.arrayNames objectAtIndex:indexPath.row]
                                        andImageName:[self.arrayImages objectAtIndex:indexPath.row]
                                         andMainView:cell]];
    
    if ([cellIdentifier isEqualToString:@"Cell9"]) {
        cell.userInteractionEnabled = NO;
    } else if ([cellIdentifier isEqualToString:@"Cell10"]) {
        [cell addSubview:[customCell customCellQuitWithView:cell]];
    }
    
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
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];    
}

//Высота ячеки меню-------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 9) {
        if (isiPhone6) {
            return 100;
        } else {
           return 80;
        }
    } else if (indexPath.row == 8) {
        
        if (isiPhone6) {
            return 80;
        } else {
            return 60;
        }
    } else {
        if (isiPhone6) {
            return 45;
        } else {
           return 40;
        }
        
}
}
@end
