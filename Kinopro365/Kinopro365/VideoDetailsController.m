//
//  VideoDetailsController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 2/6/17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "VideoDetailsController.h"
#import "VideoDetailsModel.h"

@interface VideoDetailsController () <VideoDetailsModelDelegate>

@end

@implementation VideoDetailsController

- (void) loadView {
    [super loadView];
    
    [self.navigationController setNavigationBarHidden: NO animated:YES];
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Видео"];
    self.navigationItem.titleView = CustomText;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    VideoDetailsModel * videoDetailsModel = [[VideoDetailsModel alloc] init];
    videoDetailsModel.delegate = self;
    [videoDetailsModel getVideoArrayWithOffset:@"0" andCount:@"1000"];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Actions

- (IBAction)actionButtonBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionButtonAddVideo:(UIBarButtonItem *)sender {
        [self pushCountryControllerWithIdentifier:@"VideoViewController"];
}

#pragma mark - VideoDetailsModelDelegate

- (void) loadVideo: (NSArray *) array{
    
    NSLog(@"ARRAY %@",array);
    
}

@end
