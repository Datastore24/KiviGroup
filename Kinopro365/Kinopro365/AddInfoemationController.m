//
//  AddInfoemationController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 20.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "AddInfoemationController.h"
#import "UserInformationTable.h"

@interface AddInfoemationController ()

@end

@implementation AddInfoemationController

- (void) loadView {
    [super loadView];
    [self.navigationController setNavigationBarHidden: NO animated:YES];
    self.viewForText.layer.borderColor = [UIColor hx_colorWithHexRGBAString:COLOR_ALERT_BUTTON_COLOR].CGColor;
    self.viewForText.layer.borderWidth = 1.f;
    self.viewForText.layer.cornerRadius = 5.f;
    self.viewForText.clipsToBounds = YES;
    
    self.labelCustomPlaceholder.text = @"Кратко расскажите о себе.\nКакие курсы закончили? В каких\nпроектах участвовали?";
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Доп. информация"];
    self.navigationItem.titleView = CustomText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RLMResults *userTableDataArray = [UserInformationTable allObjects];
    
    if(userTableDataArray.count>0){
        
        UserInformationTable * userTable = [userTableDataArray objectAtIndex:0];
        if(userTable.user_comment.length !=0){
            self.labelCustomPlaceholder.alpha = 0;
            self.textViewAddInformation.text = userTable.user_comment;
        }
    }
    
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

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self animationMethodWithBool:YES];
    
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    [self animationMethodWithBool:NO];
    
}

#pragma mark - Actions

- (IBAction)actionBackBarButton:(id)sender {
    

    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionButtonSave:(UIButton *)sender {
    
    [self createActivitiIndicatorAlertWithView];
   
    [self performSelector:@selector(saveToBase) withObject:nil afterDelay:2.f];
}

#pragma mark - Other

- (void) saveToBase {
    [self deleteActivitiIndicator];
    if(self.textViewAddInformation.text.length !=0){
        RLMResults *userTableDataArray = [UserInformationTable allObjects];
        
        if(userTableDataArray.count>0){
            
            UserInformationTable * userTable = [userTableDataArray objectAtIndex:0];
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            userTable.user_comment = self.textViewAddInformation.text;
            userTable.isSendToServer = @"0";
            [realm commitWriteTransaction];
            
        }
        
    }
    [self showAlertWithMessageWithBlock:@"Дополнительная информация сохранена." block:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

- (void) animationMethodWithBool: (BOOL) isBool {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        if (isBool) {
            

            CGRect rectTextView = self.viewForText.frame;
            rectTextView.size.height -= (352 - 130);
            self.viewForText.frame = rectTextView;
            CGRect rectText = self.textViewAddInformation.frame;
            rectText.size.height -= (352 - 130);
            self.textViewAddInformation.frame = rectText;

        } else {

            CGRect rectTextView = self.viewForText.frame;
            rectTextView.size.height += (352 - 130);
            self.viewForText.frame = rectTextView;
            CGRect rectText = self.textViewAddInformation.frame;
            rectText.size.height += (352 - 130);
            self.textViewAddInformation.frame = rectText;
        }
        
    }];
}
@end
