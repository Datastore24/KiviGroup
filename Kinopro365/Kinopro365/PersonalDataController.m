//
//  PersonalDataController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 11.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "PersonalDataController.h"
#import "CountryViewController.h"
#import "ChooseProfessionViewController.h"
#import "AddInfoemationController.h"
#import "AddParamsController.h"
#import "CoutryModel.h"
#import "SingleTone.h"
#import "ChooseProfessionalModel.h"
#import "HMImagePickerController.h"
#import "VideoViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "APIManger.h"



@interface PersonalDataController () <CountryViewControllerDelegate,
                                      ChooseProfessionViewControllerDelegate,
                                      HMImagePickerControllerDelegate>

@property (strong, nonatomic) NSArray * images;
@property (nonatomic) NSArray * selectedAssets;
@property (strong, nonatomic) HMImagePickerController * pickerAvatar; //Фото контроллер для выбора аватара
@property (strong, nonatomic) UIImage * imageAvatar; //Картинка аватара;

@end

@implementation PersonalDataController

- (void) loadView {
    [super loadView];


    self.mainTopView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.mainTopView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.mainTopView.layer.shadowOpacity = 1.0f;
    self.mainTopView.layer.shadowRadius = 4.0f;
    self.buttonNext.layer.cornerRadius = 5.f;
    
    self.buttonAvatar.layer.borderColor = [UIColor hx_colorWithHexRGBAString:COLOR_BORDER_AVATAR].CGColor;
    self.buttonAvatar.layer.borderWidth = 1.f;
    self.buttonAvatar.layer.cornerRadius = 5.f;
    self.buttonAvatar.clipsToBounds = YES;
    
    [self hideAllTextFildWithMainView:self.mainTopView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    APIManger * apiManager = [[APIManger alloc] init];
    NSString * userURL = [NSString stringWithFormat:@"v1/users/%@",[[SingleTone sharedManager] siteUserID]];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [[SingleTone sharedManager] token],@"access-token",
                             @"json",@"_format",nil];
    [apiManager getDataFromSeverWithMethod80:userURL andParams:params complitionBlock:^(id response) {
        NSLog(@"USER INFO %@",response);
        self.textFildPhone1.text = [NSString stringWithFormat:@"+%@",[response objectForKey:@"username"]];
        self.textFildPhone1.textColor = [UIColor grayColor];
        self.textFildPhone1.userInteractionEnabled = NO;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if (self.navigationController.navigationBarHidden == NO) {
        [self.navigationController setNavigationBarHidden: YES animated:YES];
    }    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    
    if (textField.keyboardType == UIKeyboardTypeNumbersAndPunctuation) {
        return [textField checkForNamberPhoneWithTextField:textField shouldChangeCharactersInRange:range
                                                                                 replacementString:string];
    } else if ([textField isEqual:self.textFildName] || [textField isEqual:self.textFildLastName]) {
        return [textField checkForRussianWordsWithTextField:textField withString:string];
    } else if ([textField isEqual:self.textFildNameEN] || [textField isEqual:self.textFildLastNameEN]) {
        return [textField checkForEnglishWordsWithTextField:textField withString:string];
    } else {
        return [textField validationEmailFor:textField replacementString:string];
    }

    return YES;
}

#pragma mark - CountryViewControllerDelegate

- (void) changeButtonText: (CountryViewController*) controller withString: (NSString*) string {
    
    if ([[[SingleTone sharedManager] country_citi] isEqualToString:@"country"]) {
        [self.buttonCountry setTitle:string forState:UIControlStateNormal];
        [self.buttonCountry setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } else {
        [self.buttonCity setTitle:string forState:UIControlStateNormal];
        [self.buttonCity setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } 
}

#pragma mark - ChooseProfessionalViewControllerDelegate

- (void) setTitlForButtonDelegate: (ChooseProfessionViewController*) chooseProfessionViewController
                         withTitl: (NSString*) titl {
    
    [self.buttonProfession setTitle:titl forState:UIControlStateNormal];
    self.imageButtonProffecional.alpha = 0.f;
    
    
}

#pragma mark - HMImagePickerControllerDelegate
- (void)imagePickerController:(HMImagePickerController *)picker
      didFinishSelectedImages:(NSArray<UIImage *> *)images
               selectedAssets:(NSArray<PHAsset *> *)selectedAssets {
    
    if ([picker isEqual:self.pickerAvatar]) {
        self.imageAvatar = [images objectAtIndex:0];
        [self.buttonAvatar setImage:self.imageAvatar forState:UIControlStateNormal];
    } else {
        self.images = images;
        self.selectedAssets = selectedAssets;
        self.labelCountPhoto.text = [NSString stringWithFormat:@"%lu из 10", (unsigned long)self.images.count];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Action

- (IBAction)actionButtonAvatar:(UIButton *)sender {
    self.pickerAvatar = [[HMImagePickerController alloc] initWithSelectedAssets:nil];
    self.pickerAvatar.pickerDelegate = self;
    self.pickerAvatar.targetSize = CGSizeMake(600, 600);
    self.pickerAvatar.maxPickerCount = 1;
    
    [self presentViewController:self.pickerAvatar animated:YES completion:nil];
}

- (IBAction)actionButtonCountry:(UIButton *)sender {
    [[SingleTone sharedManager] setCountry_citi:@"country"];
    [self pushCountryController];
}

- (IBAction)actionButtonCity:(UIButton *)sender {
    if ([self.buttonCountry.titleLabel.text isEqualToString:@"Страна"]) {
        [self showAlertWithMessage:@"\nВведите страну!\n"];
    } else {
        [[SingleTone sharedManager] setCountry_citi:@"city"];
        [self pushCountryController];
    }
}

- (IBAction)actionButtonBirthday:(UIButton *)sender {
    [self showDataPickerBirthdayWithButton:sender];
}

- (IBAction)actionButtonQuestion:(UIButton *)sender {
    [self showAlertWithMessage:@"\nУкажите ваше имя и фамилию\nангл. буквами для правильного\n"
                               @"отображения в международном\nформате.\n"];
}

- (IBAction)actionButtonProfession:(UIButton *)sender {
    ChooseProfessionViewController * detai = [self.storyboard
                                                instantiateViewControllerWithIdentifier:@"ChooseProfessionViewController"];
    [[SingleTone sharedManager] setProfessionControllerCode:@"0"];
    detai.delegate = self;
    [self.navigationController pushViewController:detai animated:YES];
}

- (IBAction)actionButtonPhoto:(UIButton *)sender {
    HMImagePickerController *picker = [[HMImagePickerController alloc] initWithSelectedAssets:self.selectedAssets];
    picker.pickerDelegate = self;
    picker.targetSize = CGSizeMake(600, 600);
    picker.maxPickerCount = 10 - self.images.count;
    
    [self presentViewController:picker animated:YES completion:nil];

}

- (IBAction)actionButtonVideo:(UIButton *)sender {
    [self pushCountryControllerWithIdentifier:@"VideoViewController"];
}

- (IBAction)actionButtonAddInfo:(UIButton *)sender {
    [self pushCountryControllerWithIdentifier:@"AddInfoemationController"];
}

- (IBAction)actionButtonAddParams:(UIButton *)sender {
    [self pushCountryControllerWithIdentifier:@"AddParamsController"];
}

- (IBAction)actionButtonNext:(UIButton *)sender {
    NSLog(@"actionButtonNext");
    
}

#pragma mark - Other

- (void) pushCountryController {
    CountryViewController * detai = [self.storyboard instantiateViewControllerWithIdentifier:@"CountryViewController"];
    detai.delegate = self;
    [self.navigationController pushViewController:detai animated:YES];
}

@end
