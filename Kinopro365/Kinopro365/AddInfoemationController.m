//
//  AddInfoemationController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 20.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "AddInfoemationController.h"

@interface AddInfoemationController ()

@end

@implementation AddInfoemationController

- (void) loadView {
    [super loadView];
    [self.navigationController setNavigationBarHidden: NO animated:YES];
    self.textViewAddInformation.layer.borderColor = [UIColor hx_colorWithHexRGBAString:COLOR_ALERT_BUTTON_COLOR].CGColor;
    self.textViewAddInformation.layer.borderWidth = 1.f;
    self.textViewAddInformation.layer.cornerRadius = 5.f;
    
    self.buttonSave.layer.cornerRadius = 5.f;
    
    self.labelCustomPlaceholder.text = @"Кратко расскажите о себе.\nКакие курсы закончили? В каких\nпроектах участвовали?";
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Доп. информация"];
    self.navigationItem.titleView = CustomText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.textViewAddInformation.text.length != 0) {
        self.labelCustomPlaceholder.alpha = 0;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if (textView.text.length != 0) {
        self.labelCustomPlaceholder.alpha = 0.f;
    } else {
        self.labelCustomPlaceholder.alpha = 1.f;
    }
    
}

#pragma mark - Actions

- (IBAction)actionBackBarButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionButtonSave:(UIButton *)sender {
    
    [self createActivitiIndicatorAlertWithView];
    [self performSelector:@selector(testMethod) withObject:nil afterDelay:3.f];
}

#pragma mark - Other

- (void) testMethod {
    [self deleteActivitiIndicator];
}
@end
