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
#import "PhonesTable.h"
#import "ProfessionsTable.h"
#import "UserInformationTable.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения



@interface PersonalDataController () <CountryViewControllerDelegate,
                                      ChooseProfessionViewControllerDelegate,
                                      HMImagePickerControllerDelegate>

@property (strong, nonatomic) NSArray * images;
@property (nonatomic) NSArray * selectedAssets;
@property (strong, nonatomic) HMImagePickerController * pickerAvatar; //Фото контроллер для выбора аватара
@property (strong, nonatomic) UIImage * imageAvatar; //Картинка аватара;
@property (strong, nonatomic) APIManger * apiManager;
@property (strong, nonatomic) NSMutableArray * profArray;

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
    self.apiManager = [[APIManger alloc] init];
    self.profArray = [NSMutableArray new];
   
    [self.apiManager getDataFromSeverWithMethod:@"account.getProfileInfo" andParams:nil andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
        }else{
            
            NSDictionary * respDict = [response objectForKey:@"response"];
            [self loadFromDb];
        }

        
    }];
   
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    
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
        [self.buttonCountry setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } else {
        [self.buttonCity setTitle:string forState:UIControlStateNormal];
        [self.buttonCity setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } 
}

#pragma mark - ChooseProfessionalViewControllerDelegate

- (void) setTitlForButtonDelegate: (ChooseProfessionViewController*) chooseProfessionViewController
                         withTitl: (NSString*) titl {
    
    [self.buttonProfession setTitle:titl forState:UIControlStateNormal];
    self.imageButtonProffecional.alpha = 0.f;
    
    
}

#pragma mark - LoadFromDB

- (void) setTitlForButtonWithTitle: (NSString*) title {
    
    [self.buttonProfession setTitle:title forState:UIControlStateNormal];
    self.imageButtonProffecional.alpha = 0.f;
    
    
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
                    [self.buttonCountry setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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
                    [self.buttonCity setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }
            }];
            
            
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
            NSLog(@"RESPONSEFOTO %@",response);
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
        
        for(int i=0; i<self.images.count; i++){
            NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     @"1",@"add_to_profile",nil];
            
            [self.apiManager postImageDataFromSeverWithMethod:@"photo.save" andParams:params andToken:[[SingleTone sharedManager] token] andImage:[self.images objectAtIndex:i] complitionBlock:^(id response) {
                NSLog(@"RESPONSEFOTO %@",response);
                if(![response isKindOfClass:[NSDictionary class]]){
                   
                    NSLog(@"Загрузить фото не удалось");
                }
            }];
        }
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
    [self showDataPickerBirthdayWithButton:sender];
}

- (IBAction)actionButtonQuestion:(UIButton *)sender {
    [self showAlertWithMessage:@"\nУкажите ваше имя и фамилию\nангл. буквами для правильного\n"
                               @"отображения в международном\nформате.\n"];
}

- (IBAction)actionButtonProfession:(UIButton *)sender {
    ChooseProfessionViewController * detai = [self.storyboard
                                                instantiateViewControllerWithIdentifier:@"ChooseProfessionViewController"];
    [[SingleTone sharedManager] setProfessionControllerCode:@"0"];
    detai.delegate = self;
    [self.navigationController pushViewController:detai animated:YES];
}

- (IBAction)actionButtonPhoto:(UIButton *)sender {
    HMImagePickerController *picker = [[HMImagePickerController alloc] initWithSelectedAssets:self.selectedAssets];
    picker.pickerDelegate = self;
    picker.targetSize = CGSizeMake(600, 600);
    picker.maxPickerCount = 10 - self.images.count;
    
    [self presentViewController:picker animated:YES completion:nil];

}

- (IBAction)actionButtonVideo:(UIButton *)sender {
    [self pushCountryControllerWithIdentifier:@"VideoViewController"];
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
    if(self.textFildName.text.length == 0){
        
        [self showAlertWithMessage:@"Заполните Ваше имя"];
        
    }else if(self.textFildLastName.text.length == 0){
        
        [self showAlertWithMessage:@"Заполните Вашу фамилию"];
        
    }else if(self.textFildEmail.text.length == 0){
        
        [self showAlertWithMessage:@"Заполните Ваш e-mail адрес"];
        
    }else if(self.textFildNameEN.text.length == 0){
        
        [self showAlertWithMessage:@"Заполните Ваше имя латиницей"];
    
    }else if(self.textFildLastNameEN.text.length == 0){
        
        [self showAlertWithMessage:@"Заполните Вашу фамилию латиницей"];
        
    }else if(self.textFildPhone1.text.length == 0){
        
        [self showAlertWithMessage:@"Заполните полет Телефон 1"];
    
    }else{
        PhonesTable * phonesTable = [[PhonesTable alloc] init];
        if(self.textFildPhone2.text.length !=0){
            [phonesTable insertDataIntoDataBaseWithName:@"2" andPhoneNumber:self.textFildPhone2.text];
        }
        
        [phonesTable insertDataIntoDataBaseWithName:@"1" andPhoneNumber:self.textFildPhone1.text];
        
        
    }
    NSLog(@"actionButtonNext");
    
}

#pragma mark - Other

- (void) pushCountryController {
    CountryViewController * detai = [self.storyboard instantiateViewControllerWithIdentifier:@"CountryViewController"];
    detai.delegate = self;
    [self.navigationController pushViewController:detai animated:YES];
}

@end
