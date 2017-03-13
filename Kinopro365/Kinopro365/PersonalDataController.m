//
//  PersonalDataController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 11.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "PersonalDataController.h"
#import "CountryViewController.h"
#import "ChooseProfessionViewController.h"
#import "AddInfoemationController.h"
#import "AddParamsController.h"
#import "CoutryModel.h"
#import "SingleTone.h"
#import "ChooseProfessionalModel.h"
#import "HMImagePickerController.h"
#import "VideoViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "APIManger.h"
#import "KinoproViewController.h"
#import "VideoDetailsController.h"
#import "PhotoDetailsController.h"

#import "PhonesTable.h"
#import "ProfessionsTable.h"
#import "UserInformationTable.h"
#import "AdditionalTable.h"

#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения
#import "AddParamsModel.h"
#import "DateTimeMethod.h"
#import "AddParamsModel.h"



@interface PersonalDataController () <CountryViewControllerDelegate,
                                      ChooseProfessionViewControllerDelegate,
                                      HMImagePickerControllerDelegate>

@property (strong, nonatomic) NSArray * images;
@property (nonatomic) NSArray * selectedAssets;
@property (strong, nonatomic) HMImagePickerController * pickerAvatar; //Фото контроллер для выбора аватара
@property (strong, nonatomic) UIImage * imageAvatar; //Картинка аватара;
@property (strong, nonatomic) APIManger * apiManager;
@property (strong, nonatomic) NSMutableArray * profArray;
@property (strong, nonatomic) NSString * sex;

@property (assign, nonatomic) BOOL isBool; //Параметр для изменения свойств кнопки roundButton

@end

@implementation PersonalDataController

- (void) loadView {
    [super loadView];


    self.mainTopView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.mainTopView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.mainTopView.layer.shadowOpacity = 1.0f;
    self.mainTopView.layer.shadowRadius = 4.0f;
    self.buttonNext.layer.cornerRadius = 5.f;
    
    self.buttonAvatar.layer.borderColor = [UIColor hx_colorWithHexRGBAString:COLOR_BORDER_AVATAR].CGColor;
    self.buttonAvatar.layer.borderWidth = 1.f;
    self.buttonAvatar.layer.cornerRadius = 5.f;
    self.buttonAvatar.clipsToBounds = YES;
    
    [self hideAllTextFildWithMainView:self.mainTopView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sex = @"2";
    self.apiManager = [[APIManger alloc] init];
    self.profArray = [NSMutableArray new];
    [self checkProffesion];
    
    self.isBool = YES;
    
    RLMResults *userTableDataArray = [UserInformationTable allObjects];
    
    if(userTableDataArray.count>0){
        
        UserInformationTable * userTable = [userTableDataArray objectAtIndex:0];
        
        if([userTable.isSendToServer integerValue] == 0){
            
            
            [self showAlertWithMessageWithTwoBlock:@"Имеются неотправленные на сервера данные.\nЗагрузить данные с сервера или продолжить редактирование?" nameButtonOK:@"С сервера" blockOK:^{
                NSLog(@"BLOCKOK");
                [self.apiManager getDataFromSeverWithMethod:@"account.getProfileInfo" andParams:nil andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
                    
                    if([response objectForKey:@"error_code"]){
                        
                        NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                              [response objectForKey:@"error_msg"]);
                        NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
                    }else{
                        
                        NSDictionary * respDict = [response objectForKey:@"response"];
                        NSLog(@"PROFILE %@",respDict);
                        
                        
                        [self loadFromServer:respDict];
                    }
                    
                    
                }];
            } nameButtonCancel:@"Продолжить" blockCancel:^{
                [self loadFromDb];
            }];
            
            
            
        }else{
           
              [self loadFromDb];
            
        }
    }
   
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if (self.navigationController.navigationBarHidden == NO) {
        [self.navigationController setNavigationBarHidden: YES animated:YES];
    }    
}

#pragma mark - UITextFieldDelegate


#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField.keyboardType == UIKeyboardTypeNumberPad) {
        if ([textField.text isEqualToString:@""]) {
            textField.text = @"+";
        }
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.keyboardType == UIKeyboardTypeNumberPad) {
        if ([textField.text isEqualToString:@"+"]) {
            textField.text = @"";
        }
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    
    RLMResults *profTableDataArray = [UserInformationTable allObjects];
    
    if(profTableDataArray.count>0){
        
        UserInformationTable * userTable = [profTableDataArray objectAtIndex:0];
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        userTable.isSendToServer = @"0";
        [realm commitWriteTransaction];
        
    }
    
    if (textField.keyboardType == UIKeyboardTypeNumberPad) {
        
        return [textField checkForPhoneWithTextField:textField shouldChangeCharactersInRange:range replacementString:string complitionBlock:^(NSString *response) {
        }];
    }
    
    if (textField.keyboardType == UIKeyboardTypeNumbersAndPunctuation) {
        return [textField checkForNamberPhoneWithTextField:textField shouldChangeCharactersInRange:range
                                                                                 replacementString:string];
    } else if ([textField isEqual:self.textFildName] || [textField isEqual:self.textFildLastName]) {
        return [textField checkForRussianWordsWithTextField:textField withString:string];
    } else if ([textField isEqual:self.textFildNameEN] || [textField isEqual:self.textFildLastNameEN]) {
        return [textField checkForEnglishWordsWithTextField:textField withString:string];
    } else {
        return [textField validationEmailFor:textField replacementString:string];
    }
    
    

    return YES;
}

#pragma mark - CountryViewControllerDelegate

- (void) changeButtonText: (CountryViewController*) controller withString: (NSString*) string {
    
    if ([[[SingleTone sharedManager] country_citi] isEqualToString:@"country"]) {
        [self.buttonCountry setTitle:string forState:UIControlStateNormal];
        [self.buttonCountry setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        [self.buttonCity setTitle:string forState:UIControlStateNormal];
        [self.buttonCity setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } 
}

#pragma mark - ChooseProfessionalViewControllerDelegate

- (void) setTitlForButtonDelegate: (ChooseProfessionViewController*) chooseProfessionViewController
                         withTitl: (NSString*) titl {
    
    [self.buttonProfession setTitle:titl forState:UIControlStateNormal];
    self.imageButtonProffecional.alpha = 0.f;
    [self checkProffesion];
    
    
    
    
}

#pragma mark - LoadFromDB

- (void) setTitlForButtonWithTitle: (NSString*) title {
    
    [self.buttonProfession setTitle:title forState:UIControlStateNormal];
    self.imageButtonProffecional.alpha = 0.f;
    
    
}

-(void) checkProffesion{
    [self.profArray removeAllObjects];
    RLMResults *profTableDataArray = [ProfessionsTable allObjects];
    
    if(profTableDataArray.count>0){
        for(int i=0; i<profTableDataArray.count; i++){
            ProfessionsTable * profTable = [profTableDataArray objectAtIndex:i];
           
            NSDictionary * resultDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                         profTable.professionID, @"professionID",
                                         profTable.professionName,@"professionName", nil];
            [self.profArray addObject:resultDict];
            
            if(self.profArray.count>0){
                AddParamsModel * addParamsModel = [[AddParamsModel alloc] init];
                NSArray * params = [addParamsModel loadParams:self.profArray];
                if(params.count == 0){
                    self.dopLabelOne.alpha = 0.f;
                    self.dopLabelTwo.alpha = 0.f;
                    self.buttonAddParams.userInteractionEnabled = NO;
                    self.buttonAddParams.alpha = 0.f;
                }else{
                    self.dopLabelOne.alpha = 1.f;
                    self.dopLabelTwo.alpha = 1.f;
                    self.buttonAddParams.userInteractionEnabled = YES;
                    self.buttonAddParams.alpha = 1.f;
                }
            }else{
                self.dopLabelOne.alpha = 0.f;
                self.dopLabelTwo.alpha = 0.f;
                self.buttonAddParams.userInteractionEnabled = NO;
                self.buttonAddParams.alpha = 0.f;
                
            }
            
            
        }
    }else{
        self.dopLabelOne.alpha = 0.f;
        self.dopLabelTwo.alpha = 0.f;
        self.buttonAddParams.userInteractionEnabled = NO;
        self.buttonAddParams.alpha = 0.f;
    }
    
    
}

-(void) loadFromServer:(NSDictionary * ) userInfo {
    
    RLMResults *userTableDataArray = [UserInformationTable allObjects];
    
    if(userTableDataArray.count>0){
        
        UserInformationTable * userTable = [userTableDataArray objectAtIndex:0];
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        
//        NSString * birthday = [DateTimeMethod convertDateStringToFormat:self.buttonBirthday.titleLabel.text
//                                                            startFormat:@"dd MMMM yyyy" endFormat:@"yyyy-MM-dd"];
        
        if([userInfo objectForKey:@"birthday"] != [NSNull null ]){
             userTable.birthday = [userInfo objectForKey:@"birthday"];
        }else{
            userTable.birthday = @"";
        }
       

        
        if([[userInfo objectForKey:@"city"] isKindOfClass:[NSDictionary class]]){
            if([userInfo objectForKey:@"city"] != [NSNull null ]){
             userTable.city_id = [[userInfo objectForKey:@"city"] objectForKey:@"id"];
            }else{
                userTable.city_id = @"";
            }
        }else{
            userTable.city_id = @"";
        }
        
        if([[userInfo objectForKey:@"country"] isKindOfClass:[NSDictionary class]]){
            if([userInfo objectForKey:@"country"] != [NSNull null ]){
                userTable.country_id = [[userInfo objectForKey:@"country"] objectForKey:@"id"];
            }else{
                userTable.city_id = @"";
            }
        }else{
            userTable.city_id = @"";
        }
        
        
            userTable.email = [self checkIdToNull:
                               [userInfo objectForKey:@"email"]] ;
            userTable.first_name = [self checkIdToNull:
                                    [userInfo objectForKey:@"first_name"]];
            userTable.first_name_inter = [self checkIdToNull:
                                          [userInfo objectForKey:@"first_name_inter"]];
        NSString * stringIsPublicContact = [self checkIdToNull:
                                            [userInfo objectForKey:@"is_public_contacts"]];
            if( stringIsPublicContact.length == 0){
              userTable.is_public_contacts = @"0";
            }else{
              userTable.is_public_contacts = [userInfo objectForKey:@"is_public_contacts"];
            }
            
            userTable.last_name = [self checkIdToNull:
                                   [userInfo objectForKey:@"last_name"]];
            userTable.last_name_inter = [self checkIdToNull:
                                         [userInfo objectForKey:@"last_name_inter"]];
            userTable.sex = [self checkIdToNull:
                             [userInfo objectForKey:@"sex"]];
        
            userTable.isSendToServer = @"1";
        
        
        if([[userInfo objectForKey:@"photo"] isKindOfClass:[NSDictionary class]]){
            if([userInfo objectForKey:@"photo"] != [NSNull null ]){
                userTable.photo = [[userInfo objectForKey:@"photo"] objectForKey:@"id"];
            }else{
                userTable.photo = @"";
            }
        }else{
            userTable.photo = @"";
        }

            userTable.user_comment = [self checkIdToNull: [userInfo objectForKey:@"user_comment"]];
         [realm commitWriteTransaction];
        
        AdditionalTable * addTable = [[AdditionalTable alloc] init];
        if([[userInfo objectForKey:@"languages"] isKindOfClass:[NSArray class]]){
            NSMutableArray * resultLanguages = [NSMutableArray new];
            NSArray * languages = [userInfo objectForKey:@"languages"];
            if(languages.count>0){
                RLMResults *addTableDataArray = [AdditionalTable allObjects];

                [[RLMRealm defaultRealm] beginWriteTransaction];
                [[RLMRealm defaultRealm] deleteObjects:addTableDataArray];
                [[RLMRealm defaultRealm] commitWriteTransaction];
                
                for(int i = 0; i< languages.count; i++){
                    NSDictionary * langDict = [languages objectAtIndex:i];
                    
                    NSDictionary * langFromArray = [self getLanguageNameByID:[langDict objectForKey:@"language_id"]];
                    
                    NSString * resultName = [NSString stringWithFormat:@"ex_languages[%@]",[langDict objectForKey:@"language_id"]];
                    
                    NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                           resultName,@"additionalID",
                                           [langFromArray objectForKey:@"name"],@"additionalName",
                                           [langDict objectForKey:@"language_id"],@"additionalValue",
                                           @"", @"additionalNameValue",nil];
                    
                    [resultLanguages addObject:dict];
                    
                    
                }
                
            }
            
            if(resultLanguages.count>0){
                NSArray * fullResultLanguagesArray = [NSArray arrayWithArray:resultLanguages];
                [addTable insertDataIntoDataBaseWithName:fullResultLanguagesArray];
            }
            
        }
        
       
        
        NSMutableArray * profMutableArray = [NSMutableArray new];
        NSMutableArray * resultMutProfArray = [NSMutableArray new];
        if([[userInfo objectForKey:@"professions"] isKindOfClass:[NSArray class]]){
            ProfessionsTable * profTable = [[ProfessionsTable alloc] init];
            NSArray * professions = [userInfo objectForKey:@"professions"];
            if(professions.count>0){
                RLMResults *addTableDataArray = [ProfessionsTable allObjects];
                
                [[RLMRealm defaultRealm] beginWriteTransaction];
                [[RLMRealm defaultRealm] deleteObjects:addTableDataArray];
                [[RLMRealm defaultRealm] commitWriteTransaction];
                
                for(int i = 0; i< professions.count; i++){
                    NSDictionary * profDict = [professions objectAtIndex:i];
                    NSDictionary * profDictForDB = [NSDictionary dictionaryWithObjectsAndKeys:
                                                    [profDict objectForKey:@"profession_id"],@"profession_id", nil];
                    [profMutableArray addObject:profDictForDB];
                    
                    NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                           [profDict objectForKey:@"profession_id"],@"additionalID",
                                           @"",@"additionalName",nil];
                    
                    [resultMutProfArray addObject:dict];
                    

                    
                }
                
                if(resultMutProfArray.count>0){
                    NSArray * fullResultArray = [NSArray arrayWithArray:resultMutProfArray];
                    [profTable insertDataIntoDataBaseWithName:fullResultArray];
                }
            }
            
        }
        
        NSArray * resultProfArray = [NSArray arrayWithArray:profMutableArray];
        
        NSDictionary * additional = [self getAdditionalArrayFromDictionary:userInfo];
        if(additional.count >0){
            
            NSMutableArray * resultArray = [NSMutableArray new];
            AddParamsModel * addParamsModel = [[AddParamsModel alloc] init];
            for (NSString *key in additional) {
                
                NSArray * loadParams = [addParamsModel loadParamsFromServerProfArray:resultProfArray];
                
                if(loadParams.count > 0){
                   
                    NSDictionary * params = [addParamsModel getInformationDictionary:key andProfArray:loadParams];
                    
                    if(params.count> 0){
                        NSDictionary * finalInfoParams = [addParamsModel getNameByDictionary:[params objectForKey:@"array"] andFindID:[additional objectForKey:key]];
                        NSLog(@"KEY %@ - PRO ARRAY %@",key,finalInfoParams);
                        NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                               key,@"additionalID",
                                               [params objectForKey:@"title"],@"additionalName",
                                               [additional objectForKey:key],@"additionalValue",
                                               [finalInfoParams objectForKey:@"name"], @"additionalNameValue",nil];
                        
                        [resultArray addObject:dict];
                        
                        
                    }
                }
                
                
                
            }
            if(resultArray.count>0){
                NSArray * fullResultArray = [NSArray arrayWithArray:resultArray];
                [addTable insertDataIntoDataBaseWithName:fullResultArray];
            }
            
            
        }
        
        if([[userInfo objectForKey:@"phones"] isKindOfClass:[NSArray class]]){
            PhonesTable * phoneTable = [[PhonesTable alloc] init];
            NSArray * phones = [userInfo objectForKey:@"phones"];
            if(phones.count>0){
                RLMResults *addTableDataArray = [PhonesTable allObjects];
                
                [[RLMRealm defaultRealm] beginWriteTransaction];
                [[RLMRealm defaultRealm] deleteObjects:addTableDataArray];
                [[RLMRealm defaultRealm] commitWriteTransaction];
                
                for(int i = 0; i< phones.count; i++){
                    NSDictionary * phoneDict = [phones objectAtIndex:i];
                    NSString * resultID = [NSString stringWithFormat:@"%d",i+1];
                    [phoneTable insertDataIntoDataBaseWithName:resultID andPhoneNumber:[phoneDict objectForKey:@"phone_number"]];
                    
                }
                
            }
            
        }
        
        
    
       
    }
    [self loadFromDb];

}


//Нахождение дополнительный параметров по ключу ex_
-(NSDictionary *) getAdditionalArrayFromDictionary: (NSDictionary *) dict{
    NSMutableDictionary* result = [NSMutableDictionary new];
    for (NSString* key in  dict) {
        if ([key hasPrefix:@"ex_"]) {
            [result setObject:[dict objectForKey:key] forKey:key];
        }
    }
    NSDictionary * resultDict = [NSDictionary dictionaryWithDictionary:result];
    return resultDict;
    
 
}



-(void) loadFromDb{
   
    
    RLMResults *profTableDataArray = [ProfessionsTable allObjects];
    NSMutableString * resultString = [NSMutableString new];
    if(profTableDataArray.count>0){
        for(int i=0; i<profTableDataArray.count; i++){
            ProfessionsTable * profTable = [profTableDataArray objectAtIndex:i];
            if ([resultString isEqualToString:@""]) {
                [resultString appendString:profTable.professionName];
            } else {
                [resultString appendString:[NSString stringWithFormat:@"/%@", profTable.professionName]];
            }
            
            NSDictionary * resultDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                         profTable.professionID, @"professionID",
                                         profTable.professionName,@"professionName", nil];
            [self.profArray addObject:resultDict];
            if(self.profArray.count>0){
                AddParamsModel * addParamsModel = [[AddParamsModel alloc] init];
                NSArray * params = [addParamsModel loadParams:self.profArray];

                if(params.count == 0){
                    self.dopLabelOne.alpha = 0.f;
                    self.dopLabelTwo.alpha = 0.f;
                    self.buttonAddParams.userInteractionEnabled = NO;
                    self.buttonAddParams.alpha = 0.f;
                }else{
                    self.dopLabelOne.alpha = 1.f;
                    self.dopLabelTwo.alpha = 1.f;
                    self.buttonAddParams.userInteractionEnabled = YES;
                    self.buttonAddParams.alpha = 1.f;
                }
            }else{
                self.dopLabelOne.alpha = 0.f;
                self.dopLabelTwo.alpha = 0.f;
                self.buttonAddParams.userInteractionEnabled = NO;
                self.buttonAddParams.alpha = 0.f;
                
            }
            
            
        }
        [self setTitlForButtonWithTitle:resultString];
    }
    
    RLMResults *userTableDataArray = [UserInformationTable allObjects];
    
    if(userTableDataArray.count>0){
        UserInformationTable * userTable = [userTableDataArray objectAtIndex:0];
        if(userTable.photo.length !=0){
            NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     userTable.photo,@"id", nil];
            [self.apiManager getDataFromSeverWithMethod:@"photo.getById" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
                if([response objectForKey:@"error_code"]){
                    
                    NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                          [response objectForKey:@"error_msg"]);
                    NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
                }else{
                    
                    NSDictionary * respDict = [response objectForKey:@"response"];
                    
                    NSURL *imgURL = [NSURL URLWithString:[respDict objectForKey:@"url"]];
                    SDWebImageManager *manager = [SDWebImageManager sharedManager];
                    [manager downloadImageWithURL:imgURL
                                          options:0
                                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                             // progression tracking code
                                         }
                                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished,
                                                    NSURL *imageURL) {
                                            
                                            if(image){
                                                
                                                [self.buttonAvatar setImage:image forState:UIControlStateNormal];
                                                self.textFildName.text = userTable.first_name;
                                                self.textFildLastName.text = userTable.last_name;
                                                self.textFildEmail.text = userTable.email;
                                                self.textFildNameEN.text = userTable.first_name_inter;
                                                self.textFildLastNameEN.text = userTable.last_name_inter;
                                                NSString * birthday = [DateTimeMethod convertDateStringToFormat:userTable.birthday
                                                                                            startFormat:@"yyyy-MM-dd" endFormat:@"dd MMMM yyyy"];
                                                self.buttonBirthday.titleLabel.text = birthday;
                                                [self.buttonBirthday setTitle:birthday forState:UIControlStateNormal];
                                                [self.buttonBirthday setTitleColor:[UIColor blackColor]
                                                            forState:UIControlStateNormal];
                                                
                                                if([userTable.sex integerValue] == 2){
                                                    [self.buttonGenderMale setImage:[UIImage imageNamed:@"mailImageOn"] forState:UIControlStateNormal];
                                                    [self.buttonGenderFemale setImage:[UIImage imageNamed:@"femaleImageOff"] forState:UIControlStateNormal];

                                                }else if ([userTable.sex integerValue] == 1){
                                                    [self.buttonGenderMale setImage:[UIImage imageNamed:@"mailImageOff"] forState:UIControlStateNormal];
                                                    [self.buttonGenderFemale setImage:[UIImage imageNamed:@"femaleImageOn"] forState:UIControlStateNormal];

                                                }else{
                                                    [self.buttonGenderMale setImage:[UIImage imageNamed:@"mailImageOn"] forState:UIControlStateNormal];
                                                    [self.buttonGenderFemale setImage:[UIImage imageNamed:@"femaleImageOff"] forState:UIControlStateNormal];
                                                }
                                                
                                                
                                                if ([userTable.is_public_contacts integerValue] == 0) {
                                                    [UIView animateWithDuration:0.3 animations:^{
                                                        self.imageForButtonRound.alpha = 1.f;
                                                    }];
                                                    
                                                    self.isBool = NO;
                                                    
                                                    
                                                } else {
                                                    [UIView animateWithDuration:0.3 animations:^{
                                                        self.imageForButtonRound.alpha = 0.f;
                                                    }];
                                                   
                                                    self.isBool = YES;
                                                }
                                                
                                                
                                            }else{
                                                //Тут обработка ошибки загрузки изображения
                                            }
                                        }];

                    
                    
                }

            }];
        }
        
        if(userTable.country_id.length !=0){
            NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     userTable.country_id,@"id", nil];
            [self.apiManager getDataFromSeverWithMethod:@"info.getCountryById" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
                if([response objectForKey:@"error_code"]){
                    
                    NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                          [response objectForKey:@"error_msg"]);
                    NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
                }else{
                    NSDictionary * respDict = [response objectForKey:@"response"];
                    [self.buttonCountry setTitle:[respDict objectForKey:@"name"] forState:UIControlStateNormal];
                    [[SingleTone sharedManager] setCountryID:[respDict objectForKey:@"id"]];
                    [self.buttonCountry setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
            }];
           
            
        }
        
        if(userTable.city_id.length !=0){
            NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     userTable.city_id,@"id", nil];
            [self.apiManager getDataFromSeverWithMethod:@"info.getCityById" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
                if([response objectForKey:@"error_code"]){
                    
                    NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                          [response objectForKey:@"error_msg"]);
                    NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
                }else{
                    NSDictionary * respDict = [response objectForKey:@"response"];
                    
                    [self.buttonCity setTitle:[respDict objectForKey:@"name"] forState:UIControlStateNormal];
                    [self.buttonCity setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
            }];
            
            
        }
        
        RLMResults *phoneTableDataArray = [PhonesTable allObjects];
       
        if(phoneTableDataArray.count>0){
            for(int k=0; k<phoneTableDataArray.count; k++){
                NSLog(@"PHONE k = %d",k);
                if(k==0){
                    PhonesTable * profTableOne = [phoneTableDataArray objectAtIndex:0];
                    self.textFildPhone1.text = profTableOne.phoneNumber;
                    
                }
                if(k==1){
                    PhonesTable * profTableTwo = [phoneTableDataArray objectAtIndex:1];
                    self.textFildPhone2.text = profTableTwo.phoneNumber;
                }
            }
            
            
            
            [self setTitlForButtonWithTitle:resultString];
        }
        

     
    }
}

#pragma mark - HMImagePickerControllerDelegate
- (void)imagePickerController:(HMImagePickerController *)picker
      didFinishSelectedImages:(NSArray<UIImage *> *)images
               selectedAssets:(NSArray<PHAsset *> *)selectedAssets {
    
    if ([picker isEqual:self.pickerAvatar]) {
        self.imageAvatar = [images objectAtIndex:0];
        NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"0",@"add_to_profile",nil];
        
        [self.apiManager postImageDataFromSeverWithMethod:@"photo.save" andParams:params andToken:[[SingleTone sharedManager] token] andImage:self.imageAvatar complitionBlock:^(id response) {
            if([response isKindOfClass:[NSDictionary class]]){
                NSDictionary * dictResp = [response objectForKey:@"response"];
                if([[dictResp objectForKey:@"url"] length] != 0){
                    [self.buttonAvatar setImage:self.imageAvatar forState:UIControlStateNormal];
                    
                    RLMResults *profTableDataArray = [UserInformationTable allObjects];
                    
                    if(profTableDataArray.count>0){
                        
                        UserInformationTable * userTable = [profTableDataArray objectAtIndex:0];
                        RLMRealm *realm = [RLMRealm defaultRealm];
                        [realm beginWriteTransaction];
                        userTable.photo = [NSString stringWithFormat:@"%@",[dictResp objectForKey:@"id"]];
                        [realm commitWriteTransaction];

                    }
                    
                    

                }
            }else{
                [self showAlertWithMessage:@"Загрузить аватар не удалось"];
            }
        }];
        
        
        
    } else {
        self.images = images;
        self.selectedAssets = selectedAssets;
        self.labelCountPhoto.text = [NSString stringWithFormat:@"%lu из 10", (unsigned long)self.images.count];
        
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Action

- (IBAction)actionButtonAvatar:(UIButton *)sender {
    self.pickerAvatar = [[HMImagePickerController alloc] initWithSelectedAssets:nil];
    self.pickerAvatar.pickerDelegate = self;
    self.pickerAvatar.targetSize = CGSizeMake(600, 600);
    self.pickerAvatar.maxPickerCount = 1;
    
    [self presentViewController:self.pickerAvatar animated:YES completion:nil];
}

- (IBAction)actionButtonCountry:(UIButton *)sender {
    [[SingleTone sharedManager] setCountry_citi:@"country"];
    [self pushCountryController];
}

- (IBAction)actionButtonCity:(UIButton *)sender {
    if ([self.buttonCountry.titleLabel.text isEqualToString:@"Страна"]) {
        [self showAlertWithMessage:@"\nВведите страну!\n"];
    } else {
        [[SingleTone sharedManager] setCountry_citi:@"city"];
        [self pushCountryController];
    }
}

- (IBAction)actionButtonBirthday:(UIButton *)sender {
    [self showDataPickerBirthdayWithButton:sender endBool:NO];
}

- (IBAction)actionButtonQuestion:(UIButton *)sender {
    [self showAlertWithMessage:@"\nУкажите ваше имя и фамилию\nлатинскими буквами для\nправильного "
                               @"отображения\nв международном формате.\n"];
}

- (IBAction)actionButtonProfession:(UIButton *)sender {
    ChooseProfessionViewController * detai = [self.storyboard
                                                instantiateViewControllerWithIdentifier:@"ChooseProfessionViewController"];
    [[SingleTone sharedManager] setProfessionControllerCode:@"0"];
    detai.delegate = self;
    [self.navigationController pushViewController:detai animated:YES];
}

- (IBAction)actionButtonPhoto:(UIButton *)sender {
    
    [self pushCountryControllerWithIdentifier:@"PhotoDetailsController"];

}

- (IBAction)actionButtonVideo:(UIButton *)sender {

    [self pushCountryControllerWithIdentifier:@"VideoDetailsController"];

}

- (IBAction)actionButtonAddInfo:(UIButton *)sender {
    [self pushCountryControllerWithIdentifier:@"AddInfoemationController"];
}

- (IBAction)actionButtonAddParams:(UIButton *)sender {
    AddParamsController * addParams = [self.storyboard instantiateViewControllerWithIdentifier:@"AddParamsController"];
    addParams.profArray = [NSArray arrayWithArray:self.profArray];
    [self.navigationController pushViewController:addParams animated:YES];

}

- (IBAction)actionButtonNext:(UIButton *)sender {
    RLMResults *profTableDataArray = [ProfessionsTable allObjects];
    
    AddParamsModel * addParamsModel = [[AddParamsModel alloc] init];
    NSArray * params = [addParamsModel loadParams:self.profArray];
   
    if(self.textFildName.text.length == 0){
        
        [self showAlertWithMessage:@"Заполните Ваше имя"];
        
    }else if(self.textFildLastName.text.length == 0){
        
        [self showAlertWithMessage:@"Заполните Вашу фамилию"];
        
    }else if ([self.buttonBirthday.titleLabel.text isEqualToString:@"Дата рождения"]){
        
        [self showAlertWithMessage:@"Выберите дату Вашего рождения"];
        
    }else if(self.textFildEmail.text.length == 0){
        
        [self showAlertWithMessage:@"Заполните Ваш e-mail адрес"];
        
    }else if(self.textFildNameEN.text.length == 0){
        
        [self showAlertWithMessage:@"Заполните Ваше имя латиницей"];
    
    }else if(self.textFildLastNameEN.text.length == 0){
        
        [self showAlertWithMessage:@"Заполните Вашу фамилию латиницей"];
        
    }else if(self.textFildPhone1.text.length == 0){
        
        [self showAlertWithMessage:@"Заполните полет Телефон 1"];
    }else if(profTableDataArray.count==0){
        [self showAlertWithMessage:@"Выберите хотя бы одну профессию"];
    }else if(params.count == 0){
        [self showAlertWithMessage:@"Заполните дополнительные параметры"];
    }else{
        PhonesTable * phonesTable = [[PhonesTable alloc] init];
        if(self.textFildPhone2.text.length !=0){
            [phonesTable insertDataIntoDataBaseWithName:@"2" andPhoneNumber:self.textFildPhone2.text];
        }
        
        [phonesTable insertDataIntoDataBaseWithName:@"1" andPhoneNumber:self.textFildPhone1.text];
        
        RLMResults *userTableDataArray = [UserInformationTable allObjects];
        
        if(userTableDataArray.count>0){
            
            UserInformationTable * userTable = [userTableDataArray objectAtIndex:0];
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            
            NSString * birthday = [DateTimeMethod convertDateStringToFormat:self.buttonBirthday.titleLabel.text
                                                                    startFormat:@"dd MMMM yyyy" endFormat:@"yyyy-MM-dd"];
            
            userTable.first_name = self.textFildName.text;
            userTable.last_name = self.textFildLastName.text;
            userTable.email = self.textFildEmail.text;
            userTable.first_name_inter = self.textFildNameEN.text;
            userTable.last_name_inter = self.textFildLastNameEN.text;
            userTable.sex = self.sex;
            userTable.birthday = birthday;
            userTable.isSendToServer = 0;
            
           
            [realm commitWriteTransaction];
    
            
            NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                            [self checkStringToNull:userTable.last_name],@"last_name",
                                            [self checkStringToNull:userTable.first_name],@"first_name",
                                            [self checkStringToNull:userTable.last_name_inter],@"last_name_inter",
                                            [self checkStringToNull:userTable.first_name_inter],@"first_name_inter",
                                            [self checkStringToNull:userTable.sex],@"sex",
                                            [self checkStringToNull:userTable.email],@"email",
                                            [self checkStringToNull:userTable.user_comment],@"user_comment",
                                            [self checkStringToNull:userTable.is_public_contacts],@"is_public_contacts",
                                            [self checkStringToNull:userTable.country_id],@"country_id",
                                            [self checkStringToNull:userTable.city_id],@"city_id",
                                            [self checkStringToNull:userTable.birthday],@"birthday",
                                            [self checkStringToNull:userTable.photo],@"photo_id",nil];
            
            RLMResults *phoneTableDataArray = [PhonesTable allObjects];
            for(int p = 0; p<phoneTableDataArray.count; p++){
                PhonesTable * phoneTableDb = [phoneTableDataArray objectAtIndex:p];
                NSString * phoneResult = [NSString stringWithFormat:@"phones[%@]",phoneTableDb.phoneID];
                [params setValue:phoneTableDb.phoneNumber forKey:phoneResult];
            }
            
            RLMResults *proffesionTableDataArray = [ProfessionsTable allObjects];
            for(int pro = 0; pro<proffesionTableDataArray.count; pro++){
                ProfessionsTable * profTableDb = [proffesionTableDataArray objectAtIndex:pro];
                NSString * profResult = [NSString stringWithFormat:@"professions[%d]",pro];
                [params setValue:profTableDb.professionID forKey:profResult];
            }
            
            RLMResults *addTableDataArray = [AdditionalTable allObjects];
            int lang = 0;
            for(int add = 0; add<addTableDataArray.count; add++){
                AdditionalTable * profTableDb = [addTableDataArray objectAtIndex:add];
                
               if ([profTableDb.additionalID rangeOfString:@"ex_languages"].location != NSNotFound) {
                   NSError *error;
                   NSString *pattern = @"(.*)\\[(.*)\\]";
                   NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                                          options:NSRegularExpressionCaseInsensitive
                                                                                            error:&error];
                   NSString *resultLanguage = [regex stringByReplacingMatchesInString:profTableDb.additionalID
                                                                  options:0
                                                                    range:NSMakeRange(0, [profTableDb.additionalID length])
                                                             withTemplate:[NSString stringWithFormat:@"$1[%d]",lang]];
                   [params setValue:profTableDb.additionalValue forKey:resultLanguage];
                   lang = lang+1;
                   
               }else{
                   [params setValue:profTableDb.additionalValue forKey:profTableDb.additionalID];
               }
                
            }
                    [self.apiManager postDataFromSeverWithMethod:@"account.saveProfileInfo" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
                        NSLog(@"RESPONSE %@",response);
                        if([response objectForKey:@"error_code"]){
                            [self deleteActivitiIndicator];
                            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                                  [response objectForKey:@"error_msg"]);
                            NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
 
                        }else{
                            if([response isKindOfClass:[NSDictionary class]]){
                                NSDictionary * dict = [response objectForKey:@"response"];
                                NSString * status = [dict objectForKey:@"status"];
                                if([status integerValue] == 10){
                                    NSLog(@"SEND OK");
                                    [realm beginWriteTransaction];
                                    userTable.isSendToServer = @"1";
                                    [realm commitWriteTransaction];
                                    UIViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"KinoproViewController"];
                                    [self.navigationController pushViewController:detail animated:YES];
                                }
                            }

                        }
                    }];
        }

    }
}

- (IBAction)actionButtonMale:(id)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.buttonGenderMale setImage:[UIImage imageNamed:@"mailImageOn"] forState:UIControlStateNormal];
        [self.buttonGenderFemale setImage:[UIImage imageNamed:@"femaleImageOff"] forState:UIControlStateNormal];
    }];
    self.sex = @"2";
    self.buttonGenderMale.userInteractionEnabled = NO;
    self.buttonGenderFemale.userInteractionEnabled = YES;
    
}

- (IBAction)actionButtonFemale:(id)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.buttonGenderMale setImage:[UIImage imageNamed:@"mailImageOff"] forState:UIControlStateNormal];
        [self.buttonGenderFemale setImage:[UIImage imageNamed:@"femaleImageOn"] forState:UIControlStateNormal];
    }];
    self.sex = @"1";
    self.buttonGenderMale.userInteractionEnabled = YES;
    self.buttonGenderFemale.userInteractionEnabled = NO;
    
}

- (IBAction)actionButtonRound:(id)sender {
    RLMResults *profTableDataArray = [UserInformationTable allObjects];
            UserInformationTable * userTable = [profTableDataArray objectAtIndex:0];
            RLMRealm *realm = [RLMRealm defaultRealm];
    

    if (self.isBool) {
        [UIView animateWithDuration:0.3 animations:^{
            self.imageForButtonRound.alpha = 1.f;
        }];
        self.isBool = NO;
        [realm beginWriteTransaction];
        userTable.is_public_contacts = @"0";
        [realm commitWriteTransaction];
        
        
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.imageForButtonRound.alpha = 0.f;
        }];
        [realm beginWriteTransaction];
        userTable.is_public_contacts = @"1";
        [realm commitWriteTransaction];
        self.isBool = YES;
    }
    
}

#pragma mark - Other

- (void) pushCountryController {
    CountryViewController * detai = [self.storyboard instantiateViewControllerWithIdentifier:@"CountryViewController"];
    detai.delegate = self;
    [self.navigationController pushViewController:detai animated:YES];
}

@end
