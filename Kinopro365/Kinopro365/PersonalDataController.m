//
//  PersonalDataController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 11.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "PersonalDataController.h"

@interface PersonalDataController ()

@end

@implementation PersonalDataController

- (void) loadView {
    [super loadView];
    
    self.mainViewPersonalData.layer.cornerRadius = 5.f;
    self.buttonNext.layer.cornerRadius = 5.f;
    self.buttonChoiceProfession.layer.cornerRadius = 5.f;
    self.viewRedRound.layer.cornerRadius = 4.5f;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
//    self.navigationController.navigationBarHidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Action

- (IBAction)actionButtonHelp:(UIButton *)sender {
    [self showAlertWithMessage:@"\nУкажите ваше имя и фамилию\nангл. буквами для правильного"
                               @"\nотображения в международном\nформате\n"];
}
@end
