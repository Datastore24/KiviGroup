//
//  TwoViewController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 18.11.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftSideButtonMenu:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.centerContainer toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}


- (IBAction)actionTestButton:(id)sender {
    
    
    [self pushMethodWithIdentifier:@"NewViewController"];
    
}


- (void) pushMethodWithIdentifier: (NSString*) identifier {
    
    UIViewController * nextController =
    [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    [self.navigationController pushViewController:nextController animated:YES];

    
    
}

@end
