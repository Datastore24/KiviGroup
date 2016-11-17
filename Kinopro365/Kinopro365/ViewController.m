//
//  ViewController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 17.11.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.mm_drawerController.maximumLeftDrawerWidth = 200;
 
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}


- (IBAction)leftSideButtonMenu:(id)sender {
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}

- (IBAction)actionTestButton:(id)sender {
    
    
    NSLog(@"Hello");
    
}




@end
