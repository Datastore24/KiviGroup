//
//  ProfessionDetailController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 14.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "ProfessionDetailController.h"

@interface ProfessionDetailController ()

@end

@implementation ProfessionDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionButtonBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
