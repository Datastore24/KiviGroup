//
//  KinoproSearchController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 2/1/17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "KinoproSearchController.h"

@interface KinoproSearchController ()

@end

@implementation KinoproSearchController

- (void) loadView {
    [super loadView];
    
    self.topView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.topView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.topView.layer.shadowOpacity = 1.0f;
    self.topView.layer.shadowRadius = 4.0f;
    
    self.buttonSearch.layer.cornerRadius = 5.f;
    
    UILabel * customText = [[UILabel alloc]initWithTitle:@"Поиск"];
    self.navigationItem.titleView = customText;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
