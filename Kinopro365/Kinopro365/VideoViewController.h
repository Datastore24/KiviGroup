//
//  VideoViewController.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 25.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"

@interface VideoViewController : MainViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *burronSaveURL;

- (IBAction)actionBackButton:(id)sender;
- (IBAction)actionButtonSaveURL:(UIButton *)sender;

@end
