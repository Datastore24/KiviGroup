//
//  MenuViewController.h
//  TravelTogether
//
//  Created by Виктор Мишустин on 02/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

//Контроллер навигации приложения--------------

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface MenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableMenu; //Основная таблица меню

@end
