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

@implementation UnderRepairController

- (void) viewDidLoad
{
#pragma mark - initialization
    
    _buttonMenu.target = self.revealViewController;
    _buttonMenu.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.navigationController.navigationBar.hidden = NO; // спрятал navigation bar
    
    NSLog(@"%@", [[SingleTone sharedManager] billingBalance]);
}

@end
