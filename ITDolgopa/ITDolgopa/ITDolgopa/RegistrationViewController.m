//
//  RegistrationViewController.m
//  ITDolgopa
//
//  Created by Viktor on 12.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "RegistrationViewController.h"
#import "Macros.h"

@implementation RegistrationViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(10, 20, 100, 40);
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}


- (void) buttonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
