//
//  LeftSideViewController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 17.11.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "MenuViewController.h"
#import "BackViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionButtonBack:(id)sender {
    BackViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"BackViewController"];
    [self.mm_drawerController
     setCenterViewController:detail
     withCloseAnimation:YES
     completion:nil];
}
@end
