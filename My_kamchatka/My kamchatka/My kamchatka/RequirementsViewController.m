//
//  RequirementsViewController.m
//  My kamchatka
//
//  Created by Viktor on 10.02.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "RequirementsViewController.h"
#import "SWRevealViewController.h"

@implementation RequirementsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Параметры кнопки меню---------------------------------------
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end