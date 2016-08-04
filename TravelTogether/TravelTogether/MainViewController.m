//
//  MainViewController.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 02/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "MainViewController.h"
#import "UILabel+TitleCategory.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initializeCartBarButton {
    
    //Пареметры кнопки меню------------------------------------
    UIButton * buttonMenu = [UIButton createButtonMenu];
    [buttonMenu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * menuButton =[[UIBarButtonItem alloc] initWithCustomView:buttonMenu];
    self.navigationItem.leftBarButtonItem = menuButton;
    
}

- (void) setCustomTitle: (NSString*) title {
    UILabel * CustomText = [[UILabel alloc]initWithTitle:title];
    self.navigationItem.titleView = CustomText;
}


@end
