//
//  AddParamsController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 20.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "AddParamsController.h"
#import "AddParamsModel.h"
#import "ChooseProfessionViewController.h"
#import "SingleTone.h"
#import "AddParamsView.h"


@interface AddParamsController () <ChooseProfessionViewControllerDelegate, AddParamsViewDelegate>
@property (strong, nonatomic) NSMutableArray * fieldsArray;
@end

@implementation AddParamsController

- (void) loadView {
    [super loadView];
    
    [self.navigationController setNavigationBarHidden: NO animated:YES];
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Доп. параметры"];
    self.navigationItem.titleView = CustomText;
    
    NSLog(@"RESPROF %@",self.profArray);
    
    self.fieldsArray = [NSMutableArray new];
    
    AddParamsModel * addParamsModel = [[AddParamsModel alloc] init];
    
    NSArray * paramsArray =[addParamsModel loadParams:self.profArray];
     for(int i; i<paramsArray.count; i++){
         
         NSDictionary * dictData = [paramsArray objectAtIndex:i];
         
         AddParamsView * view = [[AddParamsView alloc] initWithFrame:CGRectMake(0.f, 20 + 50 * i,
                                                                                CGRectGetWidth(self.view.bounds), 30)
                                                andTitle:[dictData objectForKey:@"title"]
                                                andType:[dictData objectForKey:@"type"]
                                                andPlaceholder:[dictData objectForKey:@"placeholder"]
                                                               andId:[dictData objectForKey:@"id"]
                                                andArrayData:[dictData objectForKey:@"array"]];
         
        
         view.deleagte = self;
         
         self.mainScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(view.frame)+50);
         [self.mainScrollView addSubview:view];
         
         if(view.mainObject && view.mainDict){
             NSDictionary * resultDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                          view.mainObject,@"object",
                                          view.mainDict,@"info", nil];
            [self.fieldsArray addObject:resultDict];
         }
         
         
         
     }
    
   

    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)actionBackBarButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//- (IBAction)actionButtonsChooseParams:(UIButton *)sender {
//    
//    for (int i = 0; i < self.buttonsChooseParams.count; i++) {
//       
//        UIButton * buttonParams = [self.buttonsChooseParams objectAtIndex:i];
//        if ([buttonParams isEqual:sender]) {
//            NSArray * needArray = [[AddParamsModel setArrayHeight] objectAtIndex:i];
//            NSString * alertTitl = [[AddParamsModel setArrayTitl] objectAtIndex:i];
//            [self showViewPickerWithButton:sender andTitl:alertTitl andArrayData:needArray];
//        }
//    }
//}
//
//- (IBAction)actionButtonLanguages:(UIButton *)sender {
//    
//    ChooseProfessionViewController * detai = [self.storyboard
//                                              instantiateViewControllerWithIdentifier:@"ChooseProfessionViewController"];
//    detai.mainArrayData = [AddParamsModel setArrayData];
//    [[SingleTone sharedManager] setProfessionControllerCode:@"1"];
//    detai.delegate = self;
//    [self.navigationController pushViewController:detai animated:YES];
//    
//}

//- (IBAction)actionButtonInternationalPass:(id)sender {
//    
//    for (UIButton * button in self.buttonsInternationalPass) {
//        if ([button isEqual:sender]) {
//            [UIView animateWithDuration:0.3 animations:^{
//                button.titleLabel.font = [UIFont fontWithName:FONT_ISTOK_BOLD size:button.titleLabel.font.pointSize];
//                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//                button.userInteractionEnabled = NO;
//            }];
//        } else {
//            [UIView animateWithDuration:0.3 animations:^{
//                button.titleLabel.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:button.titleLabel.font.pointSize];
//                [button setTitleColor:[UIColor hx_colorWithHexRGBAString:COLOR_PLACEHOLDER] forState:UIControlStateNormal];
//                button.userInteractionEnabled = YES;
//            }];
//        }
//    }
//}

//- (IBAction)actionButtonSave:(UIButton *)sender {
//    [self createActivitiIndicatorAlertWithView];
//    [self performSelector:@selector(testMethod) withObject:nil afterDelay:3.f];
//}

#pragma mark - ChooseProfessionalViewControllerDelegate

//- (void) setTitlForButtonDelegate: (ChooseProfessionViewController*) chooseProfessionViewController
//                         withTitl: (NSString*) titl {
//    
//    [self.buttonLanguages setTitle:titl forState:UIControlStateNormal];    
//    
//}

#pragma mark - AddParamsViewDelegate

- (void) actionButtonOn: (AddParamsView*) addParamsView andButton: (CustomButton*) button andArrayViewPicker: (NSArray*) array {

    [self showViewPickerWithButton:button andTitl:nil andArrayData:array andKeyTitle:@"name" andKeyID:@"id"];
    
}

#pragma mark - Other

- (void) testMethod {
    [self deleteActivitiIndicator];
}

- (IBAction)actionButtonSave:(id)sender {
    
    NSLog(@"self main %@",self.fieldsArray);
    
    for (int i=0; i<self.fieldsArray.count; i++){
        NSDictionary * fields = [self.fieldsArray objectAtIndex:i];
        
        if([[fields objectForKey:@"object"] isKindOfClass:[UITextField class]]){
            UITextField * textFields = [fields objectForKey:@"object"];
            NSDictionary * information = [fields objectForKey:@"info"];
            if(textFields.text.length ==0){
                
                NSString * alertMessage = [NSString stringWithFormat:@"Заполните поле: %@",[information objectForKey:@"title"]];
                [self showAlertWithMessage:alertMessage];
            }else{
               NSLog(@"TEXT %@",textFields.text);
            }
        }
        
        if([[fields objectForKey:@"object"] isKindOfClass:[CustomButton class]]){
            CustomButton * customButton = [fields objectForKey:@"object"];
            NSDictionary * information = [fields objectForKey:@"info"];
            if(customButton.customName.length ==0){
                NSString * alertMessage = [NSString stringWithFormat:@"Заполните поле: %@",[information objectForKey:@"title"]];
                [self showAlertWithMessage:alertMessage];
            }else{
                NSLog(@"PICKER %@",customButton.customName);
            }
            
           
        }
    }
    
}
@end
