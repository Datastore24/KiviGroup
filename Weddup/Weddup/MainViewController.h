//
//  MainViewController.h
//  Weddup
//
//  Created by Кирилл Ковыршин on 11.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem * barButton;
@property (strong, nonatomic) IBOutlet UIView *logoImage;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (weak, nonatomic) IBOutlet UIView *logoView;
@end
