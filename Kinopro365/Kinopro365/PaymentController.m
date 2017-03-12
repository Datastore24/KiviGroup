//
//  PaymentControllerController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 11.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "PaymentController.h"

@interface PaymentController ()

@end

@implementation PaymentController

- (void) loadView {
    [super loadView];
    
    self.navigationController.navigationBarHidden = NO;
    
    UILabel * customText = [[UILabel alloc]initWithTitle:@"Оплата"];
    self.navigationItem.titleView = customText;
    
    self.buttonConfirm.layer.cornerRadius = 3.f;
    
    self.topView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.topView.layer.shadowOffset = CGSizeMake(0.0f, -1.0f);
    self.topView.layer.shadowOpacity = 1.0f;
    self.topView.layer.shadowRadius = 4.0f;

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions


- (IBAction)actionButtonChoosePay:(id)sender {
    NSLog(@"actionButtonChoosePay");
}

- (IBAction)actionButtonConfirm:(id)sender {
    NSLog(@"actionButtonConfirm");
}

- (IBAction)actionButtonAnotherMan:(id)sender {
    [self pushCountryControllerWithIdentifier:@"AnotherPaymentController"];
}

- (IBAction)actionButtonHistory:(id)sender {
    [self pushCountryControllerWithIdentifier:@"HistoryPaymentController"];
}

- (IBAction)actionButtonVK:(id)sender {
    NSLog(@"actionButtonVK");
}

- (IBAction)actionButtonFacebook:(id)sender {
    NSLog(@"actionButtonFacebook");
}

- (IBAction)actionButtonMenu:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.centerContainer toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
@end
