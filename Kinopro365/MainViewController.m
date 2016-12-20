//
//  MainViewController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 08.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"
#import <NYAlertViewController/NYAlertViewController.h>

@interface MainViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) UIActivityIndicatorView * activiti;
@property (strong, nonatomic) NSArray * arrayPickerView;
@property (strong, nonatomic) NSString * pickerViewString; //Сохраняет выбранный параметр в пикерВью

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gestures

- (void) hideAllTextFildWithMainView: (UIView*) view {
    
    UITapGestureRecognizer * gester = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(actionTapOnSelfView:)];
    [view addGestureRecognizer:gester];
    
}

#pragma mark - Actions

//Джестер на сворачивание клавиатуры
- (void) actionTapOnSelfView: (UITapGestureRecognizer*) tapGesture {
    
    for (UITextField * textFild in tapGesture.view.subviews) {
        [textFild resignFirstResponder];
    }
}

#pragma mark - Allerts

- (void) showAlertWithMessage: (NSString*) message {
    
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    
    alertViewController.backgroundTapDismissalGestureEnabled = YES;
    alertViewController.swipeDismissalGestureEnabled = YES;
    
    alertViewController.title = NSLocalizedString(@"", nil);
    alertViewController.message = NSLocalizedString(message, nil);
    
    alertViewController.buttonCornerRadius = 4.0f;
    alertViewController.view.tintColor = self.view.tintColor;
    
    alertViewController.titleFont = [UIFont fontWithName:@"AvenirNext-Bold" size:18.0f];
    alertViewController.messageFont = [UIFont fontWithName:FONT_ISTOK_REGULAR size:14.0f];
    alertViewController.buttonTitleFont = [UIFont fontWithName:FONT_ISTOK_BOLD
                                                          size:alertViewController.buttonTitleFont.pointSize];
    
    alertViewController.alertViewBackgroundColor = [UIColor whiteColor];
    alertViewController.alertViewCornerRadius = 10.0f;
    
    alertViewController.titleColor = [UIColor colorWithRed:0.42f green:0.78 blue:0.32f alpha:1.0f];
    alertViewController.messageColor = [UIColor blackColor];
    
    alertViewController.buttonColor = [UIColor hx_colorWithHexRGBAString:COLOR_ALERT_BUTTON_COLOR];
    alertViewController.buttonTitleColor = [UIColor whiteColor];
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"OK", nil)
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(NYAlertAction *action) {
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

- (void) showDataPickerBirthdayWithButton: (UIButton*) button {
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    
    alertViewController.title = NSLocalizedString(@"", nil);
    alertViewController.message = NSLocalizedString(@"\nВыберите вашу дату рождения", nil);
    alertViewController.buttonTitleFont = [UIFont fontWithName:FONT_ISTOK_BOLD
                                                          size:alertViewController.buttonTitleFont.pointSize];
    alertViewController.cancelButtonTitleFont = [UIFont fontWithName:FONT_ISTOK_BOLD
                                                                size:alertViewController.buttonTitleFont.pointSize];
    
    
    alertViewController.alertViewBackgroundColor = [UIColor whiteColor];
    alertViewController.alertViewCornerRadius = 10.0f;
    
    alertViewController.titleColor = [UIColor colorWithRed:0.42f green:0.78 blue:0.32f alpha:1.0f];
    alertViewController.messageColor = [UIColor blackColor];
    
    alertViewController.buttonColor = [UIColor hx_colorWithHexRGBAString:COLOR_ALERT_BUTTON_COLOR];
    alertViewController.cancelButtonColor = [UIColor hx_colorWithHexRGBAString:COLOR_ALERT_BUTTON_COLOR];
    alertViewController.buttonTitleColor = [UIColor whiteColor];
    alertViewController.cancelButtonTitleColor = [UIColor whiteColor];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    alertViewController.alertViewContentView = datePicker;
    
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Выбрать", nil)
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(NYAlertAction *action) {
                                                              [button setTitle:[self refactDateString:datePicker.date]
                                                                                             forState:UIControlStateNormal];
                                                              [button setTitleColor:[UIColor blackColor]
                                                                           forState:UIControlStateNormal];
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Отмена", nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(NYAlertAction *action) {
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    

    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

- (void) showViewPickerWithButton: (UIButton*) button andTitl: (NSString*) message andArrayData: (NSArray*) arrayData {
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    
    alertViewController.title = NSLocalizedString(@"", nil);
    alertViewController.message = NSLocalizedString(message, nil);
    alertViewController.buttonTitleFont = [UIFont fontWithName:FONT_ISTOK_BOLD
                                                          size:alertViewController.buttonTitleFont.pointSize];
    alertViewController.cancelButtonTitleFont = [UIFont fontWithName:FONT_ISTOK_BOLD
                                                                size:alertViewController.buttonTitleFont.pointSize];
    
    
    alertViewController.alertViewBackgroundColor = [UIColor whiteColor];
    alertViewController.alertViewCornerRadius = 10.0f;
    
    alertViewController.titleColor = [UIColor colorWithRed:0.42f green:0.78 blue:0.32f alpha:1.0f];
    alertViewController.messageColor = [UIColor blackColor];
    
    alertViewController.buttonColor = [UIColor hx_colorWithHexRGBAString:COLOR_ALERT_BUTTON_COLOR];
    alertViewController.cancelButtonColor = [UIColor hx_colorWithHexRGBAString:COLOR_ALERT_BUTTON_COLOR];
    alertViewController.buttonTitleColor = [UIColor whiteColor];
    alertViewController.cancelButtonTitleColor = [UIColor whiteColor];
    
    UIPickerView * pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    self.arrayPickerView = arrayData;
    self.pickerViewString = [self.arrayPickerView objectAtIndex:0];
    alertViewController.alertViewContentView = pickerView;
    
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Выбрать", nil)
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(NYAlertAction *action) {
                                                              [button setTitle:self.pickerViewString
                                                                      forState:UIControlStateNormal];
                                                              [self dismissViewControllerAnimated:YES completion:nil];

                                                          }]];
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Отмена", nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(NYAlertAction *action) {
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

#pragma mark - Activiti

- (void) createActivitiIndicatorAlertWithView {
    
    self.activiti = [[UIActivityIndicatorView alloc]
                                          initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activiti.backgroundColor = [UIColor blackColor];
    self.activiti.backgroundColor = [self.activiti.backgroundColor colorWithAlphaComponent:0.5];
    CGRect frameForActiviti = CGRectZero;
    frameForActiviti.size = CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    self.activiti.frame = frameForActiviti;
    self.activiti.color = [UIColor whiteColor];
    [self.navigationController.view.window addSubview:self.activiti];
    [self.activiti startAnimating];
    
}

- (void) deleteActivitiIndicator {
    [self.activiti stopAnimating];
    [self.activiti removeFromSuperview];
    self.activiti = nil;
    
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.arrayPickerView.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row
                                                            forComponent:(NSInteger)component {
   return [self.arrayPickerView objectAtIndex:row];
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.pickerViewString = [self.arrayPickerView objectAtIndex:row];
}

#pragma mark - Other

- (NSString*) refactDateString: (NSDate*) date {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    NSString *newDate = [dateFormatter stringFromDate:date];
    
    return newDate;
}

- (void) pushCountryControllerWithIdentifier: (NSString*) identifier {
    UIViewController * detai = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    [self.navigationController pushViewController:detai animated:YES];
}

- (void) setCustomTitle: (NSString*) title
{
    UILabel * CustomText = [[UILabel alloc]initWithTitle:title];
    self.navigationItem.titleView = CustomText;
}

@end
