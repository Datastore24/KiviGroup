//
//  MainViewController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 08.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"
#import <NYAlertViewController/NYAlertViewController.h>
#import "UserInformationTable.h"
#import "UIPlaceHolderTextView.h"



@interface MainViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) UIActivityIndicatorView * activiti;

@property (strong, nonatomic) NSArray * arrayPickerView;
@property (strong, nonatomic) NSString * pickerViewString; //Сохраняет выбранный параметр в пикерВью
@property (strong, nonatomic) NSString * pickerViewStringID;
@property (strong, nonatomic) NSString * pickerViewStringValueID;
@property (strong, nonatomic) NSString * pickerDictKeyTitle; //Ключ для массива, где внутри коллекция
@property (strong, nonatomic) NSString * pickerDictKeyID; //Ключ для массива, где внутри коллекция






@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"FILE URL %@", [[RLMRealm defaultRealm] configuration].fileURL);

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

- (void) showAlertWithMessageWithBlock: (NSString*) message block: (void (^)(void)) compilationBack{
    
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
                                                              compilationBack();
                                                          }]];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

- (void) showAlertWithMessageWithTwoBlock: (NSString*) message
                                  blockOK: (void (^)(void)) compilationBackOk
                              blockCancel: (void (^)(void)) compilationBackCancel{
    
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
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:@"С сервера"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(NYAlertAction *action) {
                                                              
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                              compilationBackOk();
                                                          }]];
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Продолжить", nil)
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(NYAlertAction *action) {
                                                              
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                              compilationBackCancel();
                                                          }]];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
}



- (void) showDataPickerBirthdayWithButton: (UIButton*) button endBool: (BOOL) isBool {
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
    
    if (isBool) {
        datePicker.minimumDate = [NSDate date];
    }
    
    alertViewController.alertViewContentView = datePicker;
    
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Выбрать", nil)
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(NYAlertAction *action) {
                                                              [button setTitle:[self refactDateString:datePicker.date]
                                                                                             forState:UIControlStateNormal];
                                                              if (!isBool) {
                                                                  [button setTitleColor:[UIColor blackColor]
                                                                               forState:UIControlStateNormal];
                                                              }
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Отмена", nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(NYAlertAction *action) {
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    

    
    [self presentViewController:alertViewController animated:YES completion:nil];
}

- (void) showViewPickerWithButton: (CustomButton*) button andTitl: (NSString*) message andArrayData: (NSArray *) arrayData andKeyTitle:(NSString *) dictKeyTitle andKeyID:(NSString *) dictKeyID andDefValueIndex: (NSString *) defValueIndex{
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
    
    self.pickerDictKeyTitle = dictKeyTitle;
    self.pickerDictKeyID = dictKeyID;
    self.arrayPickerView = arrayData;
    NSString * defval;
    
    if(self.pickerDictKeyTitle.length !=0){
        if(defValueIndex.length !=0){
            //Поиск значения по умолчанию
            NSMutableArray * arrayIndex = [NSMutableArray new];
            
            for(int i=0; i<arrayData.count; i++){
                NSDictionary * dict = [self.arrayPickerView objectAtIndex:i];
                [arrayIndex addObject:[dict objectForKey:self.pickerDictKeyTitle]];
                
            }
            NSUInteger index = [arrayIndex indexOfObject:defValueIndex];
            //
            [pickerView selectRow:index inComponent:0 animated:YES];
            
            self.pickerViewString = defValueIndex;
            NSDictionary * pickerDict = [self.arrayPickerView objectAtIndex:index];
            self.pickerViewStringID = [pickerDict objectForKey:self.pickerDictKeyID];
        }else{
            NSDictionary * pickerDict = [self.arrayPickerView objectAtIndex:0];
         
            
            self.pickerViewString = [pickerDict objectForKey:self.pickerDictKeyTitle];
            self.pickerViewStringID = [pickerDict objectForKey:self.pickerDictKeyID];
        }
       
        
    }else{
        self.pickerViewString = [self.arrayPickerView objectAtIndex:[defval intValue]];
    }
    
    alertViewController.alertViewContentView = pickerView;
    
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Выбрать", nil)
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(NYAlertAction *action) {
                                                              [button setTitle:self.pickerViewString
                                                                      forState:UIControlStateNormal];
                                                              button.tag = 5000;
                                                              button.customID = self.pickerViewStringID;
                                                              button.customName = self.pickerViewString;
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
    
    if(self.pickerDictKeyTitle.length !=0){
        NSDictionary * pickerDict = [self.arrayPickerView objectAtIndex:row];
        
        return [pickerDict objectForKey:self.pickerDictKeyTitle];
    }else{
        return [self.arrayPickerView objectAtIndex:row];
    }
    
   
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    
    if(self.pickerDictKeyTitle.length !=0){
        NSDictionary * pickerDict = [self.arrayPickerView objectAtIndex:row];
        
        self.pickerViewString = [pickerDict objectForKey:self.pickerDictKeyTitle];
        self.pickerViewStringID = [pickerDict objectForKey:self.pickerDictKeyID];
    }else{
         self.pickerViewString = [self.arrayPickerView objectAtIndex:row];
    }

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

-(NSString *) checkStringToNull:(NSString *) string{
    if(string.length == 0){
        return @"";
    }else{
        return string;
    }
}

-(NSString *) checkIdToNull:(id) string{
    if(string == [NSNull null]){
        return @"";
    }else{
        return string;
    }
}



-(NSDictionary *) getLanguageNameByID:(NSString *) langID{
    NSArray * language = @[
                           [@{@"id":@"1",
                              @"name":@"китайский",
                              @"choose":[NSNumber numberWithBool:NO],
                              } mutableCopy],
                           [@{@"id":@"2",
                              @"name":@"испанский",
                              @"choose":[NSNumber numberWithBool:NO],
                              } mutableCopy],
                           [@{@"id":@"3",
                              @"name":@"английский",
                              @"choose":[NSNumber numberWithBool:NO],
                              }mutableCopy],
                           [@{@"id":@"4",
                              @"name":@"хинди",
                              @"choose":[NSNumber numberWithBool:NO],
                              } mutableCopy],
                           [@{@"id":@"5",
                              @"name":@"арабский",
                              @"choose":[NSNumber numberWithBool:NO],
                              } mutableCopy],
                           [@{@"id":@"6",
                              @"name":@"португальский",
                              @"choose":[NSNumber numberWithBool:NO],
                              } mutableCopy],
                           [@{@"id":@"7",
                              @"name":@"бенгальский",
                              @"choose":[NSNumber numberWithBool:NO],
                              } mutableCopy],
                           [@{@"id":@"8",
                              @"name":@"русский",
                              @"choose":[NSNumber numberWithBool:NO],
                              } mutableCopy],
                           [@{@"id":@"9",
                              @"name":@"японский",
                              @"choose":[NSNumber numberWithBool:NO],
                              }mutableCopy],
                           [@{@"id":@"10",
                              @"name":@"немецкий",
                              @"choose":[NSNumber numberWithBool:NO],
                              }mutableCopy],
                           [@{@"id":@"11",
                              @"name":@"корейский",
                              @"choose":[NSNumber numberWithBool:NO],
                              }mutableCopy],
                           [@{@"id":@"12",
                              @"name":@"французский",
                              @"choose":[NSNumber numberWithBool:NO],
                              }mutableCopy],
                           [@{@"id":@"13",
                              @"name":@"турецкий",
                              @"choose":[NSNumber numberWithBool:NO],
                              }mutableCopy],
                           [@{@"id":@"14",
                              @"name":@"тамильский",
                              @"choose":[NSNumber numberWithBool:NO],
                              }mutableCopy],
                           [@{@"id":@"15",
                              @"name":@"урду",
                              @"choose":[NSNumber numberWithBool:NO],
                              }mutableCopy],
                           [@{@"id":@"16",
                              @"name":@"итальянский",
                              @"choose":[NSNumber numberWithBool:NO],
                              }mutableCopy],
                           [@{@"id":@"17",
                              @"name":@"малайский",
                              @"choose":[NSNumber numberWithBool:NO],
                              }mutableCopy],
                           [@{@"id":@"18",
                              @"name":@"персидский",
                              @"choose":[NSNumber numberWithBool:NO],
                              }mutableCopy],
                           [@{@"id":@"19",
                              @"name":@"польский",
                              @"choose":[NSNumber numberWithBool:NO],
                              }mutableCopy],
                           [@{@"id":@"20",
                              @"name":@"нидерландский",
                              @"choose":[NSNumber numberWithBool:NO],
                              }mutableCopy],
                           [@{@"id":@"21",
                              @"name":@"греческий",
                              @"choose":[NSNumber numberWithBool:NO],
                              }mutableCopy],
                           [@{@"id":@"22",
                              @"name":@"украинский",
                              @"choose":[NSNumber numberWithBool:NO],
                              }mutableCopy],
                           [@{@"id":@"23",
                              @"name":@"армянский",
                              @"choose":[NSNumber numberWithBool:NO],
                              }mutableCopy],
                           [@{@"id":@"24",
                              @"name":@"грузинский",
                              @"choose":[NSNumber numberWithBool:NO],
                              }mutableCopy],
                           [@{@"id":@"25",
                              @"name":@"казахский",
                              @"choose":[NSNumber numberWithBool:NO],
                              }mutableCopy],
                           [@{@"id":@"26",
                              @"name":@"белорусский",
                              @"choose":[NSNumber numberWithBool:NO],
                              }mutableCopy]
                           ];
    
    NSArray *filtered = [language filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(id == %@)", langID]];
    NSDictionary *item = [filtered objectAtIndex:0];
    
    return item;
}





@end
