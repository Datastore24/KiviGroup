//
//  PhotoDetailsController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 2/6/17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "PhotoDetailsController.h"
#import "PhotoDetailsModel.h"

@interface PhotoDetailsController () <PhotoDetailsModelDelegate>

@end

@implementation PhotoDetailsController

- (void) loadView {
    [super loadView];
    
    [self.navigationController setNavigationBarHidden: NO animated:YES];
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Фото"];
    self.navigationItem.titleView = CustomText;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    PhotoDetailsModel * photoDetailsModel = [[PhotoDetailsModel alloc] init];
    photoDetailsModel.delegate = self;
    [photoDetailsModel getPhotosArrayWithOffset:@"0" andCount:@"1000"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Actions

- (IBAction)actionButtonBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - PhotoDetailsModelDelegate

- (void) loadPhotos: (NSArray *) array{
    
    NSLog(@"ARRAY PHOTOS %@",array);
    
}
@end
