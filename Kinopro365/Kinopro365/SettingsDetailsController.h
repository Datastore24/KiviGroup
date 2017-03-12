//
//  SettingsDetailsController.h
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 11.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"

@interface SettingsDetailsController : MainViewController

//Labels----------
@property (weak, nonatomic) IBOutlet UILabel *labelArtisticFilm;
@property (weak, nonatomic) IBOutlet UILabel *labelSeries;
@property (weak, nonatomic) IBOutlet UILabel *labelShortFilm;
@property (weak, nonatomic) IBOutlet UILabel *labelDocumentary;
@property (weak, nonatomic) IBOutlet UILabel *labelTelecast;
@property (weak, nonatomic) IBOutlet UILabel *labelAdvertising;
@property (weak, nonatomic) IBOutlet UILabel *labelMusicClip;
@property (weak, nonatomic) IBOutlet UILabel *labelScoring;
@property (weak, nonatomic) IBOutlet UILabel *labelRealityShow;
@property (weak, nonatomic) IBOutlet UILabel *labelExtras;

//Swiches
@property (weak, nonatomic) IBOutlet UISwitch *swichArtisticFilm;
@property (weak, nonatomic) IBOutlet UISwitch *swichSeries;
@property (weak, nonatomic) IBOutlet UISwitch *swichShortFilm;
@property (weak, nonatomic) IBOutlet UISwitch *swichDocumentary;
@property (weak, nonatomic) IBOutlet UISwitch *swichTelecast;
@property (weak, nonatomic) IBOutlet UISwitch *swichAdvertising;
@property (weak, nonatomic) IBOutlet UISwitch *swichMusicClip;
@property (weak, nonatomic) IBOutlet UISwitch *swichScoring;
@property (weak, nonatomic) IBOutlet UISwitch *swichRealityShow;
@property (weak, nonatomic) IBOutlet UISwitch *swichExtras;

//Actions
- (IBAction)actionSwichArtisticFilm:(UISwitch*)sender;
- (IBAction)actionsSwichSeries:(UISwitch*)sender;
- (IBAction)actionSwichShortFilm:(UISwitch*)sender;
- (IBAction)actionSwichDocumentary:(UISwitch*)sender;
- (IBAction)actionSwichTelecast:(UISwitch*)sender;
- (IBAction)actionSwichAdvertising:(UISwitch*)sender;
- (IBAction)actionSwichMusicClip:(UISwitch*)sender;
- (IBAction)actionSwichScoring:(UISwitch*)sender;
- (IBAction)actionSwichRealityShow:(UISwitch*)sender;
- (IBAction)actionSwichExtras:(UISwitch*)sender;



- (IBAction)ActionButtonBack:(id)sender;

@end
