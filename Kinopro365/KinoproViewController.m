//
//  TwoViewController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 18.11.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "KinoproViewController.h"
#import "KinosferaCell.h"
#import "ChooseProfessionalModel.h"
#import "KinoproSearchController.h"
#import "TestViewController.h"

@interface KinoproViewController ()

@property (strong, nonatomic) NSArray * arrayData;

@end

@implementation KinoproViewController

- (void) loadView {
    [super loadView];

    self.navigationController.navigationBarHidden = NO;
    
    UILabel * customText = [[UILabel alloc]initWithTitle:@"Киносфера"];
    self.navigationItem.titleView = customText;
    
    UIImage *myImage = [UIImage imageNamed:@"magnifying-glass"];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *glassButton = [[UIBarButtonItem alloc] initWithImage:myImage style:UIBarButtonItemStylePlain
                                                                  target:self action:@selector(actionGlassButton:)];
    self.navigationItem.rightBarButtonItem = glassButton;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayData = [ChooseProfessionalModel getArrayToTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftSideButtonMenu:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.centerContainer toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}


- (void) pushMethodWithIdentifier: (NSString*) identifier {
    
    UIViewController * nextController =
    [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    [self.navigationController pushViewController:nextController animated:YES];
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrayData.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString * identifier = @"Cell";
    
    
    KinosferaCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    NSDictionary * dict = [self.arrayData objectAtIndex:indexPath.row];
    
    cell.image.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
    cell.name.text = [dict objectForKey:@"name"];
    cell.number.text = [dict objectForKey:@"number"];
//    cell.arrawImage = [UIImage imageNamed:@""];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
    NSLog(@"didSelectRowAtIndexPath %ld", (long)indexPath.row);
    
}

#pragma mark - Actions

- (void) actionGlassButton: (UIBarButtonItem*) barButton {
    
    [self pushMethodWithIdentifier:@"KinoproSearchController"];
    
    
}

@end
