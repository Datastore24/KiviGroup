//
//  BookmarksController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 10.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "BookmarksController.h"
#import "KinosferaCell.h"
#import "SingleTone.h"

@interface BookmarksController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation BookmarksController

- (void) loadView {
    [super loadView];
    
    self.navigationController.navigationBarHidden = NO;
    
    UILabel * customText = [[UILabel alloc]initWithTitle:@"Избранное"];
    self.navigationItem.titleView = customText;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString * identifier = @"Cell";
    
    
    KinosferaCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    

    cell.image.image = [UIImage imageNamed:@"cellImage.png"];
    cell.name.text = @"Актеры";
    cell.number.text = @"21";
    //    cell.arrawImage = [UIImage imageNamed:@""];
    
    if ([cell.number.text isEqualToString:@"0"]) {
        cell.number.alpha = 0.f;
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    
}


#pragma mark - Actions

- (IBAction)actionButtonMenu:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.centerContainer toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}
@end
