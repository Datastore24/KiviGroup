//
//  MenuViewController.m
//  ITDolgopa
//
//  Created by Viktor on 16.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "MenuViewController.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "SWRevealViewController.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation MenuViewController
{
    NSArray * menu;
    NSArray * icons;
}

#pragma mark - Initialization

- (void) viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithHexString:@"373737"];
    self.mainTableView.backgroundColor = nil;
    self.mainTableView.scrollEnabled = NO;
    
    
    menu = [NSArray arrayWithObjects:@"Cell1", @"Cell2", @"Cell3", @"Cell4", @"Cell5",
                                     @"Cell6", @"Cell7", @"Cell8", @"Cell9", @"Cell10", nil];
    icons = [NSArray arrayWithObjects:@"remont.png", @"istoriya.png", @"balans.png", @"akcii.png",
                            @"vremya.png", @"master.png", @"chat.png", @"sait.png", @"razrabotchik", @"", nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menu count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = [menu objectAtIndex:indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    cell.backgroundColor = nil;
    
    if ([cellIdentifier isEqualToString:@"Cell10"]) {
        cell.userInteractionEnabled = NO;
    }
    
    UIImageView * imageViewIcons = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
    imageViewIcons.image = [UIImage imageNamed:[icons objectAtIndex:indexPath.row]];
    [cell addSubview:imageViewIcons];
    
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }
}

#pragma mark - UITableViewDelegate
//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 9)
    {
        return 153.f;
    } else {
    return 40.f;
}
}

@end
