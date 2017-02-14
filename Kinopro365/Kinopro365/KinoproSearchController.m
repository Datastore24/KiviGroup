//
//  KinoproSearchController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 2/1/17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "KinoproSearchController.h"
#import "UITextField+CheckNumber.h"
#import "HexColors.h"
#import "KinoproSearchModel.h"
#import "Macros.h"
#import "SingleTone.h"
#import "CountryViewController.h"


@interface KinoproSearchController () <UITextFieldDelegate, CountryViewControllerDelegate>

@property (strong, nonatomic) NSArray * arrayData;

@end

@implementation KinoproSearchController

- (void) loadView {
    [super loadView];
    
    self.topView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.topView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.topView.layer.shadowOpacity = 1.0f;
    self.topView.layer.shadowRadius = 4.0f;
    
    self.buttonSearch.layer.cornerRadius = 5.f;
    
    UILabel * customText = [[UILabel alloc]initWithTitle:@"Поиск"];
    self.navigationItem.titleView = customText;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayData = [KinoproSearchModel setTestArray];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)actionButtonBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionButtonsGender:(UIButton *)sender {
    
    for (UIButton * button in self.buttonsGender) {
        if ([button isEqual:sender]) {
            button.alpha = 1.f;
            button.titleLabel.font = [UIFont fontWithName:FONT_ISTOK_BOLD size:16];
        } else {
            button.alpha = 0.5f;
            button.titleLabel.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:16];
        }
    }
}

- (IBAction)actionButtonAgeOn:(id)sender {
    [self showViewPickerWithButton:sender andTitl:@"Введите возраст" andArrayData:self.arrayData
                       andKeyTitle:nil andKeyID:nil andDefValueIndex:nil];
}

- (IBAction)actionButtonAgeTo:(id)sender {
    [self showViewPickerWithButton:sender andTitl:@"Введите возраст" andArrayData:self.arrayData
                       andKeyTitle:nil andKeyID:nil andDefValueIndex:nil];
}

- (IBAction)actionButtonCountry:(id)sender {
    [[SingleTone sharedManager] setCountry_citi:@"country"];
    [self pushCountryController];
}

- (IBAction)actionButtonCity:(id)sender {
    [[SingleTone sharedManager] setCountry_citi:@"city"];
    [self pushCountryController];
}

- (IBAction)actionButtonAddParams:(id)sender {
}

- (IBAction)actionButtonClearFilter:(id)sender {
}

- (IBAction)actionButtonSearch:(id)sender {
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {

        return [textField checkForRussianWordsWithTextField:textField withString:string];
}

#pragma mark - Other

- (void) pushCountryController {
    CountryViewController * detai = [self.storyboard instantiateViewControllerWithIdentifier:@"CountryViewController"];
    detai.delegate = self;
    [self.navigationController pushViewController:detai animated:YES];
}









@end
