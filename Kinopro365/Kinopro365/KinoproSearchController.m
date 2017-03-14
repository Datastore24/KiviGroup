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
#import "AddParamsController.h"
#import "ProfessionController.h"


@interface KinoproSearchController () <UITextFieldDelegate, CountryViewControllerDelegate>

@property (strong, nonatomic) NSArray * arrayData;

@end

@implementation KinoproSearchController
@synthesize delegate;

- (void) loadView {
    [super loadView];
    
    self.topView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.topView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.topView.layer.shadowOpacity = 1.0f;
    self.topView.layer.shadowRadius = 4.0f;
    
    self.buttonSearch.layer.cornerRadius = 5.f;
    
    self.viewCountAddParams.layer.cornerRadius = CGRectGetWidth(self.viewCountAddParams.bounds) / 2;
    
    UILabel * customText = [[UILabel alloc]initWithTitle:@"Поиск"];
    self.navigationItem.titleView = customText;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayData = [KinoproSearchModel setTestArray];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    NSLog(@"DOPPARAM %@",self.dopArray);
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

- (IBAction)actionButtonsGender:(CustomButton *)sender {

    for (CustomButton * button in self.buttonsGender) {
        if ([button isEqual:sender]) {
            button.alpha = 1.f;
            button.customName = sender.titleLabel.text;
            button.titleLabel.font = [UIFont fontWithName:FONT_ISTOK_BOLD size:16];
        } else {
            button.alpha = 0.5f;
            button.customName = nil;
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
    
    if ([self.buttonCountry.titleLabel.text isEqualToString:@"Страна"]) {
        [self showAlertWithMessage:@"\nВведите страну!\n"];
    } else {
        [[SingleTone sharedManager] setCountry_citi:@"city"];
        [self pushCountryController];
    }
}

- (IBAction)actionButtonAddParams:(id)sender {
    
    AddParamsController * addParamsController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddParamsController"];
    NSArray * searchArray = [[NSArray alloc] initWithObjects:@{@"professionID":self.profID}, nil];
    addParamsController.profArray = searchArray;
    addParamsController.isSearch = YES;
    [self.navigationController pushViewController:addParamsController animated:YES];

    
}

- (IBAction)actionButtonClearFilter:(id)sender {
    self.textFildName.text = nil;
    self.textFildSurname.text = nil;
    [self.buttonCity setTitle:@"Город" forState:UIControlStateNormal];
    [self.buttonCountry setTitle:@"Страна" forState:UIControlStateNormal];
    [self.buttonAgeOn setTitle:@"От" forState:UIControlStateNormal];
    [self.byttonAgeTo setTitle:@"До" forState:UIControlStateNormal];
    
    for(int i=0; i<self.buttonsGender.count; i++){
        CustomButton * button = [self.buttonsGender objectAtIndex:i];
        button.alpha = 0.5f;
        button.customName = nil;
        button.titleLabel.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:16];
        if(i==2){
            button.alpha = 1.f;
            button.customName = button.titleLabel.text;
            button.titleLabel.font = [UIFont fontWithName:FONT_ISTOK_BOLD size:16];
        }
        
    }
    
    
}

- (IBAction)actionButtonSearch:(id)sender {
    
    NSMutableDictionary * dictParams = [NSMutableDictionary new];
    if(self.textFildName.text.length != 0){
        [dictParams setObject:self.textFildName.text forKey:@"first_name"];
    }
    if(self.textFildSurname.text.length != 0){
        [dictParams setObject:self.textFildSurname.text forKey:@"last_name"];
    }
    if(![self.buttonAgeOn.titleLabel.text isEqualToString:@"От"]){
        [dictParams setObject:self.buttonAgeOn.titleLabel.text forKey:@"age_from"];
    }
    if(![self.byttonAgeTo.titleLabel.text isEqualToString:@"До"]){
        [dictParams setObject:self.byttonAgeTo.titleLabel.text forKey:@"age_to"];
    }
    if(![self.buttonCountry.titleLabel.text isEqualToString:@"Страна"]){
        [dictParams setObject:[[SingleTone sharedManager] countrySearchID] forKey:@"country_id"];
    }
    
    if(![self.buttonCity.titleLabel.text isEqualToString:@"Город"]){
        [dictParams setObject:[[SingleTone sharedManager] citySearchID] forKey:@"city_id"];
    }
    for(int i=0; i<self.buttonsGender.count; i++){
        CustomButton * genderButton = [self.buttonsGender objectAtIndex:i];
        if([genderButton.customName isEqualToString:@"Муж."]){
            [dictParams setObject:@"2" forKey:@"sex"];
        }else if([genderButton.customName isEqualToString:@"Жен."]){
            [dictParams setObject:@"1" forKey:@"sex"];
        }
    }
    if(self.dopArray.count>0){
        [dictParams setObject:self.dopArray forKey:@"dopArray"];
    }
    
    ProfessionController * addParam = [self.navigationController.viewControllers objectAtIndex:1];
    
    addParam.isFiltered = YES;
    addParam.filterArray = dictParams;
    
    [self.navigationController popToViewController:addParam animated:YES];
    
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
    detai.isSearch = YES;
    [self.navigationController pushViewController:detai animated:YES];
}

#pragma mark - CountryViewControllerDelegate

- (void) changeButtonTextInSearch: (CountryViewController*) controller withString: (NSString*) string {
    
    if ([[[SingleTone sharedManager] country_citi] isEqualToString:@"country"]) {
        [self.buttonCountry setTitle:string forState:UIControlStateNormal];
    } else {
        [self.buttonCity setTitle:string forState:UIControlStateNormal];
    }
}

@end
