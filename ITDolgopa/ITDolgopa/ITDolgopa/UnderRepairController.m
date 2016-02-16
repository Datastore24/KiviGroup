//
//  UnderRepairController.m
//  ITDolgopa
//
//  Created by Viktor on 16.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "UnderRepairController.h"
#import "SWRevealViewController.h"
#import "SingleTone.h"
#import "APIGetClass.h"

@interface UnderRepairController () <UITableViewDataSource>

@end

@implementation UnderRepairController

- (void) viewDidLoad
{
#pragma mark - initialization
    
    _buttonMenu.target = self.revealViewController;
    _buttonMenu.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.navigationController.navigationBar.hidden = NO; // спрятал navigation bar
    
    NSLog(@"%@", [[SingleTone sharedManager] phone]);
    
    [self getDevicesWithPhone:[[SingleTone sharedManager] phone]];
    

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = @"Hello";
    
    return cell;
}

#pragma mark - API

- (void) getDevicesWithPhone: (NSString*) phone
{
    APIGetClass * apiDevices = [APIGetClass new];
    NSDictionary * dictParams = [NSDictionary dictionaryWithObjectsAndKeys:phone, @"phone", @"1", @"status", nil];
    
    [apiDevices getDataFromServerWithParams:dictParams method:@"get_inwork" complitionBlock:^(id response) {
        
        NSDictionary * dictResponse = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            NSLog(@"Все хорошо");
            
            NSLog(@"%@", response);
        }
        
    }];
}

@end
