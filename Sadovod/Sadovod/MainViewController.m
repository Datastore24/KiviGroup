//
//  ViewController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 12/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "MainViewController.h"
#import "UILabel+TitleCategory.h"
#import "HexColors.h"
#import "Macros.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStatusBarBackgroundColor:[UIColor hx_colorWithHexRGBAString:VM_COLOR_STATUS_BAR_COLOR]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) initializeCartBarButton
{
    
    //Пареметры кнопки меню------------------------------------
    UIButton * buttonMenu = [UIButton createButtonMenu];
    [buttonMenu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * menuButton =[[UIBarButtonItem alloc] initWithCustomView:buttonMenu];
    self.navigationItem.leftBarButtonItem = menuButton;
    
}

- (void) setCustomTitle: (NSString*) title
{
    UILabel * CustomText = [[UILabel alloc]initWithTitle:title];
    self.navigationItem.titleView = CustomText;
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

@end
