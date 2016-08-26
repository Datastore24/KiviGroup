//
//  BuyViewController.m
//  Sadovod
//
//  Created by Виктор Мишустин on 26/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "BuyViewController.h"
#import "Macros.h"

@interface BuyViewController ()

@property (strong, nonatomic) UILabel * label;

@end

@implementation BuyViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"Капри" andBarButtonAlpha: YES andButtonBasket: YES]; //Ввод заголовка
    
    //Кнопка Назад---------------------------------------------
    UIButton * buttonBack = [UIButton createButtonBack];
    [buttonBack addTarget:self action:@selector(buttonBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mailbuttonBack =[[UIBarButtonItem alloc] initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = mailbuttonBack;
    
//    //Кнопка цены---------------------------------------------
//    UIButton * buttonPrice = [UIButton buttonWithType:UIButtonTypeSystem];
//    buttonPrice.frame = CGRectMake(- 30, 0, 15, 80);
//    [buttonPrice setTitle:@"220 руб" forState:UIControlStateNormal];
//    [buttonPrice setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    buttonPrice.titleLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:10];
//    UIBarButtonItem *mailbuttonPrice =[[UIBarButtonItem alloc] initWithCustomView:buttonPrice];
//    self.navigationItem.rightBarButtonItem = mailbuttonPrice;
    
    if (self.label == nil) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 80, 20, 80, 40)];
        self.label.text = @"220 руб";
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont fontWithName:VM_FONT_REGULAR size:15];
        [self.navigationController.view.window addSubview:self.label];
        NSLog(@"Buy");
    } else {
        self.label.alpha = 1.f;
        NSLog(@"Hello");
    }


}

- (void) dealloc {
    NSLog(@"%@", self.label);
}


- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    
    self.label.alpha = 0.f;
    
}

#pragma mark - Actions

- (void) buttonBackAction {
    [self.navigationController popViewControllerAnimated:NO];
}

@end
