//
//  HistoryPaymentController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 11.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "HistoryPaymentController.h"
#import "CellPaymentHistory.h"

@interface HistoryPaymentController () <UITableViewDelegate, UITableViewDataSource, CellPaymentHistoryDelegate>

@end

@implementation HistoryPaymentController

- (void) loadView {
    [super loadView];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.tableView.allowsSelection = NO;
    
    UILabel * customText = [[UILabel alloc]initWithTitle:@"История платежей"];
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

#pragma mark - Actions

- (IBAction)actionButtonBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString * identifier = @"Cell";
    
    CellPaymentHistory * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.delegate = self;
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 66;
    
}

#pragma mark - CellPaymentHistoryDelegate

- (void) actionCell: (CellPaymentHistory*) cellPaymentHistory withButtonDelete: (UIButton*) sender {
    
    NSLog(@"Delete");
    
}




@end
