//
//  MenuController.m
//  FlowersOnline
//
//  Created by Viktor on 29.04.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "MenuController.h"

@implementation MenuController

- (void) viewDidLoad
{
    //Своства таблицы----------
    self.mainTableView.scrollEnabled = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:COLORBLACK];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.backgroundColor = [UIColor clearColor];
    
    if (isiPhone5) {
        CGRect customRect = self.mainTableView.frame;
        customRect.origin.y = customRect.origin.y - 70;
        self.mainTableView.frame = customRect;
    } else if (isiPhone4s) {
        CGRect customRect = self.mainTableView.frame;
        customRect.origin.y = customRect.origin.y - 100;
        self.mainTableView.frame = customRect;
    }
    
    //Массив ячеек----------
    self.cellArray = [NSArray arrayWithObjects:@"Cell1", @"Cell2", @"Cell3", @"Cell4", @"Cell5",
                      @"Cell6", @"Cell7", @"Cell8", nil];
    
    //Массив Заголовков-----
    self.arrayTint = [NSArray arrayWithObjects:@"БУКЕТЫ", @"ЛИЧНЫЙ КАБИНЕТ", @"АКЦИИ", @"ДОСТАВКА", @"КОНТАКТЫ", @"НАСТРОЙКИ", @"", @"", nil];
    
    //Массив картинок-------
    self.arrayImageMenu = [NSArray arrayWithObjects:
                           @"BuketImageMenu.png", @"UserNameImageMenu.png",
                           @"BookmarksImageMenu.png", @"DostavkaImageMenu.png",
                           @"ContactsImageMenu.png", @"SetttingsImageMenu.png", @"", @"", nil];
    
    
}




#pragma mark - UITableViewDataSource

//Колличество ячеек в таблице----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellArray.count;
}
//Создание ячеек----------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = [self.cellArray objectAtIndex:indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = nil;
    //Подвязываем картинки и заголовки--------
    CustomCellView * customCell = [[CustomCellView alloc] init];
    [cell addSubview:[customCell customCellWithTint:[self.arrayTint objectAtIndex:indexPath.row]
                                                   andImage:[self.arrayImageMenu objectAtIndex:indexPath.row]
                                                    andView:cell]];
    if ([cellIdentifier isEqualToString:@"Cell7"]) {
        cell.userInteractionEnabled = NO;
    }
    if ([cellIdentifier isEqualToString:@"Cell8"]) {
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//Высота ячеки меню-------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 6) {
        if (isiPhone6) {
            return 190;
        } else  if (isiPhone5) {
            return 165;
        } else  if (isiPhone4s) {
            return 110;
        }else {
        return 250;
        }
    } else if (indexPath.row == 7) {
        return 100;
    } else {
        return 40;
    }
}

@end
