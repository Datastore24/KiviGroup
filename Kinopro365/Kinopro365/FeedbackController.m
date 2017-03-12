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
    self.textViewAddInformation.layer.borderColor = [UIColor hx_colorWithHexRGBAString:COLOR_ALERT_BUTTON_COLOR].CGColor;
    self.textViewAddInformation.layer.borderWidth = 1.f;
    self.textViewAddInformation.layer.cornerRadius = 5.f;
    
    self.buttonSave.layer.cornerRadius = 5.f;
    
    self.labelCustomPlaceholder.text = @"Если вы нашли ошибку, напишите нам об этом!";
    
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

#pragma mark - Actions


- (IBAction)ActionButtonMenu:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.centerContainer toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (IBAction)actionButtonSave:(UIButton *)sender {
    

    
    NSLog(@"Сохранить");
}



@end
