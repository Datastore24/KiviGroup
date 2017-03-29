//
//  FeedbackController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 12.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "FeedbackController.h"

@interface FeedbackController ()

@end

@implementation FeedbackController

- (void) loadView {
    [super loadView];
    [self.navigationController setNavigationBarHidden: NO animated:YES];
    self.viewForText.layer.borderColor = [UIColor hx_colorWithHexRGBAString:COLOR_ALERT_BUTTON_COLOR].CGColor;
    self.viewForText.layer.borderWidth = 1.f;
    self.viewForText.layer.cornerRadius = 5.f;
    self.viewForText.clipsToBounds = YES;
    
    self.labelCustomPlaceholder.text = @"Ваши предложения и пожелания. Если вы нашли ошибку, пожалуйста, опишите ее подробнее. Если вы окажетесь первым,  кто нашел  данную ошибку или нам понравится ваша идея по улучшению ресурса - вы получите плюс три месяца  пользования в подарок.";
    
    CGRect rectLabel = self.labelCustomPlaceholder.frame;
    if (isiPhone6) {
        rectLabel.origin.y -= 10;
        self.labelCustomPlaceholder.frame = rectLabel;
    }
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Обратная связь"];
    self.navigationItem.titleView = CustomText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


- (IBAction)ActionButtonMenu:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.centerContainer toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (IBAction)actionButtonSave:(UIButton *)sender {
    
    [self showAlertWithMessageWithBlock:@"Ваше сообщение отправлено! Благодарим вас за вклад в развитие ресурса!" block:^{
        NSLog(@"Едем дальше");
    }];
    

    
    NSLog(@"Сохранить");
}

#pragma mark - Animathion

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
