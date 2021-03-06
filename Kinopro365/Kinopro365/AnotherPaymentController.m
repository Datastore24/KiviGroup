//
//  AnotherPaymentController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 11.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "AnotherPaymentController.h"
#import "UITextField+CheckNumber.h"

@interface AnotherPaymentController () <UITextFieldDelegate>

@end

@implementation AnotherPaymentController

- (void) loadView {
    [super loadView];
    
    self.navigationController.navigationBarHidden = NO;
    
    UILabel * customText = [[UILabel alloc]initWithTitle:@"Продлить аккаунт другому"];
    self.navigationItem.titleView = customText;
    
    self.buttonConfirm.layer.cornerRadius = 3.f;
    
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

- (IBAction)actionButtonBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)actionButtonTime:(id)sender {
}

- (IBAction)actionButtonConfirm:(id)sender {
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField.keyboardType == UIKeyboardTypeNumbersAndPunctuation) {
        if ([textField.text isEqualToString:@""]) {
            textField.text = @"id";
        }
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.keyboardType == UIKeyboardTypeNumbersAndPunctuation) {
        if ([textField.text isEqualToString:@"id"]) {
            textField.text = @"";
        }
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return [textField checkForIDWithTextField:textField shouldChangeCharactersInRange:range replacementString:string complitionBlock:^(NSString *response) {
        
    }];
}



@end
