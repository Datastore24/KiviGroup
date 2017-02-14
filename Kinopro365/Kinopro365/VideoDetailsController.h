//
//  VideoDetailsController.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 2/6/17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"
#import <youtube-ios-player-helper/YTPlayerView.h>

@interface VideoDetailsController : MainViewController

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIButton *buttonConfDelete;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonDelete;

- (IBAction)actionButtonBack:(UIBarButtonItem *)sender;
- (IBAction)actionButtonAddVideo:(UIBarButtonItem *)sender;
- (IBAction)actionButtonDelete:(UIBarButtonItem *)sender;
- (IBAction)actionButtonConfDelete:(UIButton *)sender;

@end
