//
//  SettingsDetailsController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 11.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "SettingsDetailsController.h"

@interface SettingsDetailsController ()

@end

@implementation SettingsDetailsController

- (void) loadView {
    [super loadView];
    
    self.navigationController.navigationBarHidden = NO;
    
    UILabel * customText = [[UILabel alloc]initWithTitle:@"Уведомления"];
    self.navigationItem.titleView = customText;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)actionSwichArtisticFilm:(UISwitch*)sender {
    
    NSLog(@"actionSwichArtisticFilm %@", sender.on ? @"Включен" : @"Выключен");
    
}

- (IBAction)actionsSwichSeries:(UISwitch*)sender {
    
    NSLog(@"actionsSwichSeries %@", sender.on ? @"Включен" : @"Выключен");
}

- (IBAction)actionSwichShortFilm:(UISwitch*)sender {
    
    NSLog(@"actionSwichShortFilm %@", sender.on ? @"Включен" : @"Выключен");
}

- (IBAction)actionSwichDocumentary:(UISwitch*)sender {
    
    NSLog(@"actionSwichDocumentary %@", sender.on ? @"Включен" : @"Выключен");
}

- (IBAction)actionSwichTelecast:(UISwitch*)sender {
    
    NSLog(@"actionSwichTelecast %@", sender.on ? @"Включен" : @"Выключен");
}

- (IBAction)actionSwichAdvertising:(UISwitch*)sender {
    
    NSLog(@"actionSwichAdvertising %@", sender.on ? @"Включен" : @"Выключен");
}

- (IBAction)actionSwichMusicClip:(UISwitch*)sender {
    
    NSLog(@"actionSwichMusicClip %@", sender.on ? @"Включен" : @"Выключен");
}

- (IBAction)actionSwichScoring:(UISwitch*)sender {
    
    NSLog(@"actionSwichScoring %@", sender.on ? @"Включен" : @"Выключен");
}

- (IBAction)actionSwichRealityShow:(UISwitch*)sender {
    
    NSLog(@"actionSwichRealityShow %@", sender.on ? @"Включен" : @"Выключен");
}

- (IBAction)actionSwichExtras:(UISwitch*)sender {
    
    NSLog(@"actionSwichExtras %@", sender.on ? @"Включен" : @"Выключен");
}

- (IBAction)ActionButtonBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
