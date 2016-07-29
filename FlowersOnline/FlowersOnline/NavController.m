//
//  NavController.m
//  FlowersOnline
//
//  Created by Виктор Мишустин on 29/07/16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "NavController.h"
#import "SingleTone.h"
#import "Macros.h"

@interface NavController ()

@property (strong, nonatomic) UIView * countOrdersView;

@end

@implementation NavController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.countOrdersView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 75, 10, 30, 20)];
    self.countOrdersView.backgroundColor = [UIColor clearColor];
    self.countOrdersView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.countOrdersView.tag = 240;
    self.countOrdersView.layer.borderWidth = 1.5f;
    self.countOrdersView.layer.cornerRadius = 7.f;
    [self.navigationBar addSubview:self.countOrdersView];
    [[SingleTone sharedManager] setViewBasketBar:self.countOrdersView];
    
    UILabel * labelBasket = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    if ([[SingleTone sharedManager] labelCountBasket] == nil) {
        labelBasket.text = @"0";
    } else {
        labelBasket.text = [[SingleTone sharedManager] labelCountBasket].text;
    }
    
    labelBasket.textColor = [UIColor whiteColor];
    labelBasket.font = [UIFont fontWithName:FONTREGULAR size:14];
    labelBasket.textAlignment = NSTextAlignmentCenter;
    [self.countOrdersView addSubview:labelBasket];
    [[SingleTone sharedManager] setLabelCountBasket:labelBasket];
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
