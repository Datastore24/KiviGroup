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
#import "AdditionalTable.h"
#import "UserInformationTable.h"
#import "KinoproSearchController.h"


@interface AddParamsController () <ChooseProfessionViewControllerDelegate, AddParamsViewDelegate>
@property (strong, nonatomic) NSMutableArray * fieldsArray;
@end

@implementation AddParamsController
@synthesize delegate;

- (void) loadView {
    [super loadView];
    
    [self.navigationController setNavigationBarHidden: NO animated:YES];
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Доп. параметры"];
    self.navigationItem.titleView = CustomText;
    
    self.buttonSave.layer.cornerRadius = 5.f;

    
    self.fieldsArray = [NSMutableArray new];
    
   
    
    AddParamsModel * addParamsModel = [[AddParamsModel alloc] init];
    
    NSArray * paramsArray =[addParamsModel loadParams:self.profArray];
    

     for(int i = 0; i<paramsArray.count; i++){
         
         NSDictionary * dictData = [paramsArray objectAtIndex:i];
       
         NSString * defValueIndex;
         if([[dictData objectForKey:@"defValueIndex"] length] != 0){
             defValueIndex = [dictData objectForKey:@"defValueIndex"];
         }else{
             defValueIndex = @"";
         }
         
       
             AddParamsView * view = [[AddParamsView alloc] initWithFrame:CGRectMake(0.f, 20 + 50 * i,
                                                                                    CGRectGetWidth(self.view.bounds), 30)
                                                                andTitle:[dictData objectForKey:@"title"]
                                                                 andType:[dictData objectForKey:@"type"]
                                                          andPlaceholder:[dictData objectForKey:@"placeholder"]
                                                                   andId:[dictData objectForKey:@"id"]
                                                        andDefValueIndex:defValueIndex
                                                            andArrayData:[dictData objectForKey:@"array"]
                                                             andIsSearch: self.isSearch];
             
             
             view.deleagte = self;
             
             [self.mainScrollView addSubview:view];
             self.mainScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(view.frame)+50);
             
             if(view.mainObject && view.mainDict){
                 NSDictionary * resultDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                              view.mainObject,@"object",
                                              view.mainDict,@"info", nil];
                 [self.fieldsArray addObject:resultDict];
             }
             
             
         
         
    
   
     }
    
    
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    NSMutableString * resultString = [NSMutableString new];
    if(!self.isSearch){
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"additionalID BEGINSWITH %@",
                             @"ex_languages"];
        
        RLMResults *outletTableDataArray = [AdditionalTable objectsWithPredicate:pred];
              if(outletTableDataArray.count>0){
            for(int i=0; i<outletTableDataArray.count; i++){
                AdditionalTable * addTable = [outletTableDataArray objectAtIndex:i];
                if ([resultString isEqualToString:@""]) {
                    [resultString appendString:addTable.additionalName];
                } else {
                    [resultString appendString:[NSString stringWithFormat:@", %@", addTable.additionalName]];
                }
                if(i==2){
                    [resultString appendString:@"..."];
                    break;
                }
            }
            
            CustomButton * customButton = [self.mainScrollView viewWithTag:999];
            customButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            [customButton setTitle: resultString forState: UIControlStateNormal];
            customButton.frame = CGRectMake(152.f, 0, 142.f, 40.f);
            //
            customButton.backgroundColor = [UIColor clearColor];
            [customButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"3D7FB4"] forState:UIControlStateNormal];
            
        }
    }else{
        if(self.langArray.count>0){
           
            for(int i=0; i<self.langArray.count; i++){
                NSDictionary * langDict = [self.langArray objectAtIndex:i];
                if ([resultString isEqualToString:@""]) {
                    [resultString appendString: [langDict objectForKey:@"name"]];
                } else {
                    [resultString appendString:[NSString stringWithFormat:@", %@", [langDict objectForKey:@"name"]]];
                }
                if(i==2){
                    [resultString appendString:@"..."];
                    break;
                }
            }
            
            CustomButton * customButton = [self.mainScrollView viewWithTag:999];
            customButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            [customButton setTitle: resultString forState: UIControlStateNormal];
            customButton.frame = CGRectMake(152.f, 0, 142.f, 40.f);
            //
            customButton.backgroundColor = [UIColor clearColor];
            [customButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"3D7FB4"] forState:UIControlStateNormal];
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



#pragma mark - ChooseProfessionalViewControllerDelegate

- (void) setTitlForButtonDelegate: (ChooseProfessionViewController*) chooseProfessionViewController
                         withTitl: (NSString*) titl {

    //[self.buttonLanguages setTitle:titl forState:UIControlStateNormal];

}

#pragma mark - AddParamsViewDelegate

- (void) actionButtonOn: (AddParamsView*) addParamsView andButton: (CustomButton*) button
     andArrayViewPicker: (NSArray*) array {
   
    [self showViewPickerWithButton:button andTitl:nil andArrayData:array andKeyTitle:@"name" andKeyID:@"id" andDefValueIndex: button.customName];
    
}

- (void) actionLangue: (AddParamsView*) addParamsView andButton: (CustomButton*) button andArrayViewPicker: (NSArray*) array{
    
    ChooseProfessionViewController * addParams = [self.storyboard instantiateViewControllerWithIdentifier:@"ChooseProfessionViewController"];
    addParams.mainArrayData =array;
    addParams.isLanguage = YES;
    if(self.isSearch){
            addParams.isSearch = YES;
    }
    
    [self.navigationController pushViewController:addParams animated:YES];
    
}

#pragma mark - Other

- (void) testMethod {
    [self deleteActivitiIndicator];
}

- (IBAction)actionButtonSave:(id)sender {
    
    RLMResults *profTableDataArray = [UserInformationTable allObjects];
    
    if(profTableDataArray.count>0){
        
        UserInformationTable * userTable = [profTableDataArray objectAtIndex:0];
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        userTable.isSendToServer = @"0";
        [realm commitWriteTransaction];
        
    }
    
    AdditionalTable * addTable = [[AdditionalTable alloc] init];
    NSMutableArray * arrayForDB = [NSMutableArray new];
    [arrayForDB removeAllObjects];
    int countError = 0;
    
    for (int i=0; i<self.fieldsArray.count; i++){
        NSDictionary * fields = [self.fieldsArray objectAtIndex:i];
        
        if([[fields objectForKey:@"object"] isKindOfClass:[UITextField class]]){
            UITextField * textFields = [fields objectForKey:@"object"];
            NSDictionary * information = [fields objectForKey:@"info"];
            if(textFields.text.length ==0 && !self.isSearch){
                countError = countError +1;
                NSString * alertMessage = [NSString stringWithFormat:@"Заполните поле: %@",[information objectForKey:@"title"]];
                [self showAlertWithMessage:alertMessage];
                
            }else{
                if(textFields.text.length !=0){
                NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       [information objectForKey:@"id"],@"additionalID",
                                       [information objectForKey:@"title"],@"additionalName",
                                       textFields.text,@"additionalValue", nil];
                
                [arrayForDB addObject:dict];
                }
            }
        }
        
        if([[fields objectForKey:@"object"] isKindOfClass:[CustomButton class]]){
            
            CustomButton * customButton = [fields objectForKey:@"object"];
            NSDictionary * information = [fields objectForKey:@"info"];
          
            if([[information objectForKey:@"type"] isEqualToString:@"MultiList"]){
                
                NSPredicate *pred = [NSPredicate predicateWithFormat:@"additionalID BEGINSWITH %@",
                                     @"ex_languages"];
                
                RLMResults *outletTableDataArray = [AdditionalTable objectsWithPredicate:pred];
                
                if(outletTableDataArray.count==0 && !self.isSearch){
                    countError = countError +1;
                    NSString * alertMessage = [NSString stringWithFormat:@"Заполните поле: %@",[information objectForKey:@"title"]];
                    [self showAlertWithMessage:alertMessage];
                }
            }else{
                if(customButton.customID.length ==0 && !self.isSearch){
                    countError = countError +1;
                    NSString * alertMessage = [NSString stringWithFormat:@"Заполните поле: %@",[information objectForKey:@"title"]];
                    [self showAlertWithMessage:alertMessage];
                    
                }else{
                    if(customButton.customID.length !=0){
                        NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                               [information objectForKey:@"id"],@"additionalID",
                                               [information objectForKey:@"title"],@"additionalName",
                                               customButton.customID,@"additionalValue",
                                               customButton.customName, @"additionalNameValue",nil];
                        
                        [arrayForDB addObject:dict];
                    }
                    
                    
                    
                }
            }
            
            
            
        }
        
        if([[fields objectForKey:@"object"] isKindOfClass:[UISwitch class]]){
            UISwitch * customSwitch = [fields objectForKey:@"object"];
            NSDictionary * information = [fields objectForKey:@"info"];
            
            if(customSwitch.isOn){
                
                NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       [information objectForKey:@"id"],@"additionalID",
                                       [information objectForKey:@"title"],@"additionalName",
                                       @"1",@"additionalValue", nil];
                
                [arrayForDB addObject:dict];
            }
            
            
            
        }
    }
    
   
    
    NSArray * resultArray = [NSArray arrayWithArray:arrayForDB];
    if(!self.isSearch){
        
        [addTable insertDataIntoDataBaseWithName:resultArray];
        if(countError==0){
            [self.navigationController popViewControllerAnimated:YES];
        }
        

    }else{
        
        if(self.langArray.count>0){
            NSDictionary * langDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       self.langArray,@"languages", nil];
            [arrayForDB addObject:langDict];
        }
        NSArray * resultArray = [NSArray arrayWithArray:arrayForDB];
        
       
        
         KinoproSearchController * kinosearch = [self.navigationController.viewControllers objectAtIndex:2];
        
        kinosearch.dopArray = resultArray;
        
        [self.navigationController popToViewController:kinosearch animated:YES];

    }
    
    
}
@end
