//
//  AddCastingController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 09.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "AddCastingController.h"
#import "AddCastingModel.h"
#import "HMImagePickerController.h"
#import "HexColors.h"
#import "CountryViewController.h"
#import "ChooseProfessionalModel.h"
#import "SingleTone.h"
#import "ChooseProfessionalModel.h"
#import "KinoproSearchModel.h"
#import "ViewForComment.h"
#import "CountryViewController.h"
#import "AddParamsController.h"
#import "ProfessionController.h"
#import "AddParamsModel.h"
#import "APIManger.h"
#import "DateTimeMethod.h"

@interface AddCastingController () <HMImagePickerControllerDelegate, CountryViewControllerDelegate, ViewForCommentDelegate>

@property (strong, nonatomic) HMImagePickerController * pickerCastings;
@property (strong, nonatomic) UIImage * imageVacancies;
@property (strong, nonatomic) NSArray * arrayProfessions;
@property (strong, nonatomic) NSArray * arrayData;
@property (strong, nonatomic) NSArray * arrayGender;

@property (strong, nonatomic) ViewForComment * viewComment;
@property (strong, nonatomic) ViewForComment * viewHideComment;

@property (strong, nonatomic) NSMutableArray * arrayViews;

@property (strong, nonatomic) NSString * photoID;



@end

@implementation AddCastingController

- (void) loadView {
    [super loadView];
    
    UILabel * customText = [[UILabel alloc]initWithTitle:@"Добавить кастинг"];
    self.navigationItem.titleView = customText;
    
    self.buttonCreate.layer.cornerRadius = 5.f;
    
    
    self.viewComment = [[ViewForComment alloc] initWithMainView:self.mainScrollView
                                                                  endHeight:CGRectGetMaxY(self.buttonAddParams.frame) + 26.f];
    self.viewComment.delegate = self;
    [self.mainScrollView addSubview:self.viewComment];
    
    
    self.viewHideComment = [[ViewForComment alloc] initHideWithMainView:self.mainScrollView
                                                              endHeight:CGRectGetMaxY(self.viewComment.frame)];
    self.viewHideComment.delegate = self;
    [self.mainScrollView addSubview:self.viewHideComment];
    [self.arrayViews addObject:self.viewHideComment];

    
    CGRect rectViewSave = self.viewSave.frame;
    rectViewSave.origin.y = CGRectGetMaxY(self.viewHideComment.frame);
    self.viewSave.frame = rectViewSave;
    self.mainScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.viewSave.frame));
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayProfessions = [ChooseProfessionalModel getArrayProfessionsForCastings];
    self.arrayData = [KinoproSearchModel setTestArray];
    self.arrayGender = [NSArray arrayWithObjects:@"Мужской", @"Женский", nil];
    self.arrayViews = [NSMutableArray array];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    NSLog(@"DOPPARAM %@",self.dopArray);
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showTextFildText:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Actions

- (IBAction)actionBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionButtonAddPhoto:(id)sender {
    
    self.pickerCastings = [[HMImagePickerController alloc] initWithSelectedAssets:nil];
    self.pickerCastings.pickerDelegate = self;
    self.pickerCastings.targetSize = CGSizeMake(600, 600);
    self.pickerCastings.maxPickerCount = 1;
    
    [self presentViewController:self.pickerCastings animated:YES completion:nil];
}

- (IBAction)actionButtonDate:(id)sender {
    [self showDataPickerBirthdayWithButton:sender endBool:YES];
}

- (IBAction)actionButtonCountry:(id)sender {
    NSLog(@"Выбор страны");
    [[SingleTone sharedManager] setCountry_citi:@"country"];
    [self pushCountryController];
}

- (IBAction)actionButtonCity:(id)sender {
    NSLog(@"Выбор города");
    if ([self.buttonCountry.titleLabel.text isEqualToString:@"Страна"]) {
        [self showAlertWithMessage:@"\nВведите страну!\n"];
    } else {
        [[SingleTone sharedManager] setCountry_citi:@"city"];
        [self pushCountryController];
    }
}

- (IBAction)actionButtonType:(id)sender {
    
    NSLog(@"Тип заявки...");
    
    AddParamsModel * addParamsModel = [[AddParamsModel alloc] init];

    
    NSArray * castingType = [addParamsModel getTypeCustings];
 
    
    [self showViewPickerWithButton:sender andTitl:@"Выберите тип кастинга" andArrayData:castingType andKeyTitle:@"name" andKeyID:@"id" andDefValueIndex:nil];
    
}

- (IBAction)actionButtonNeed:(id)sender {
    [self showViewPickerWithButton:sender andTitl:@"Выберите профессию" andArrayData:self.arrayProfessions andKeyTitle:@"name" andKeyID:@"id" andDefValueIndex:nil];
}

- (IBAction)actionButtonAgeFrom:(id)sender {
    [self showViewPickerWithButton:sender andTitl:@"Введите возраст" andArrayData:self.arrayData
                       andKeyTitle:nil andKeyID:nil andDefValueIndex:nil];
}

- (IBAction)actionButtonAgeTo:(id)sender {
    [self showViewPickerWithButton:sender andTitl:@"Введите возраст" andArrayData:self.arrayData
                       andKeyTitle:nil andKeyID:nil andDefValueIndex:nil];
}

- (IBAction)actionButtonGender:(id)sender {
    [self showViewPickerWithButton:sender andTitl:@"Введите пол" andArrayData:self.arrayGender
                       andKeyTitle:nil andKeyID:nil andDefValueIndex:nil];
}

- (IBAction)actionButtonAddParams:(id)sender {
    
    NSLog(@"Доп параметры");
    
    if([self.buttonNeed.titleLabel.text isEqualToString:@"Выбрать"]){
        [self showAlertWithMessage:@"Выберите профессию"];
    }else{
        NSLog(@"OPPP %@", self.buttonNeed.titleLabel.text);
        NSLog(@"CUSTOM %@", self.buttonNeed.customID);
            AddParamsController * addParamsController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddParamsController"];
            NSArray * searchArray = [[NSArray alloc] initWithObjects:@{@"professionID":self.buttonNeed.customID}, nil];
            addParamsController.profArray = searchArray;
            addParamsController.isCasting = YES;
            [self.navigationController pushViewController:addParamsController animated:YES];
    }
    


    
    
}

- (IBAction)actionButtonCreate:(id)sender {
    
    
    NSLog(@"описание %@", self.viewComment.textView.text);
    NSLog(@"скрытое окно %@", self.viewHideComment.textViewHide.text);
    
    
    NSDate * stringToDate = [DateTimeMethod convertStringToNSDate:self.buttonDate.titleLabel.text withFormatDate:@"dd MMMM yyyy"];
    NSString * unixTimeEndAt = [DateTimeMethod dateToTimestamp:stringToDate];
    
    
    NSDate * currentDate = [DateTimeMethod getLocalDateInFormat:@"dd MMMM yyyy"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    
    AddCastingModel * addVacanciesModel = [[AddCastingModel alloc] init];
    
    if(!self.isEditor){
        if(self.textFildName.text.length ==0){
            [self showAlertWithMessage:@"Введите название кастинга"];
        }else if(self.photoID.length == 0){
            [self showAlertWithMessage:@"Выберите фото кастинга"];
        }else if([unixTimeEndAt isEqualToString:@"0"]){
            [self showAlertWithMessage:@"Выберите дату приема заявок"];
        }else if([self.buttonDate.titleLabel.text isEqualToString:currentDateString]){
            [self showAlertWithMessage:@"Дата окончания не может быть\nв этот же день"];
        }else if([self.buttonDate.titleLabel.text integerValue] < [currentDateString integerValue]){
            [self showAlertWithMessage:@"Дата окончания не может быть\nв прошлом"];
        }else if([[SingleTone sharedManager] countrySearchID].length == 0){
            [self showAlertWithMessage:@"Выберите Страну"];
        }else if([[SingleTone sharedManager] citySearchID].length == 0){
            [self showAlertWithMessage:@"Выберите Город"];
        }else if(self.buttonType.customID.length == 0){
            [self showAlertWithMessage:@"Выберите тип кастинга"];
        }else if(self.buttonNeed.customID.length == 0){
            [self showAlertWithMessage:@"Выберите профессию"];
        }else if([self.buttonAgeFrom.titleLabel.text isEqualToString:@"От"]){
            [self showAlertWithMessage:@"Выберите возраст от"];
        }else if([self.buttonAgeTo.titleLabel.text isEqualToString:@"До"]){
            [self showAlertWithMessage:@"Выберите возраст до"];
        }else if([self.buttonGender.titleLabel.text isEqualToString:@"Выбрать"]){
            [self showAlertWithMessage:@"Выберите пол"];
        }else if(self.dopArray.count==0){
            [self showAlertWithMessage:@"Выберите дополнительные параметры"];
        }else if(self.viewComment.textView.text.length == 0){
            [self showAlertWithMessage:@"Заполните описание и типажи"];
        }else if(self.viewHideComment.textViewHide.text.length == 0){
            [self showAlertWithMessage:@"Заполните информацию для утверждения анкет"];
        }else{
            NSMutableDictionary * resultDict = [NSMutableDictionary new];
            [resultDict setObject:self.photoID forKey:@"logo_id"];
            [resultDict setObject:self.textFildName.text forKey:@"name"];
            [resultDict setObject:self.viewComment.textView.text forKey:@"description"];
            [resultDict setObject:[[SingleTone sharedManager] countrySearchID] forKey:@"country_id"];
            [resultDict setObject:[[SingleTone sharedManager] citySearchID] forKey:@"city_id"];
            [resultDict setObject:unixTimeEndAt forKey:@"end_at"];
            [resultDict setObject:self.buttonType.customID forKey:@"project_type_id"];
            [resultDict setObject:self.buttonNeed.customID forKey:@"profession_id"];
            [resultDict setObject:self.viewHideComment.textViewHide.text forKey:@"contact_info"];
            [resultDict setObject:self.buttonAgeTo.titleLabel.text forKey:@"age_from"];
            [resultDict setObject:self.buttonAgeTo.titleLabel.text forKey:@"age_to"];
            
            if([self.buttonGender.titleLabel.text isEqualToString:@"Мужской"]){
                [resultDict setObject:@"2" forKey:@"sex"];
            }else{
                [resultDict setObject:@"1" forKey:@"sex"];
            }
            
            for(int i=0; i<self.dopArray.count; i++){
                NSDictionary * dict = [self.dopArray objectAtIndex:i];
                NSLog(@"DICT %@",dict);
                
                if([[dict objectForKey:@"languages"] isKindOfClass:[NSArray class]]){
                        NSArray * language = [dict objectForKey:@"languages"];
                        if(language.count>0){
                            for(int k=0; k<language.count; k++){
                                NSDictionary * langDict = [language objectAtIndex:k];
                                NSString * langCountString = [NSString stringWithFormat:@"ex_languages[%d]",k];
                                [resultDict setObject:[langDict objectForKey:@"id"] forKey:langCountString];
                            }
                        }
                
                }else{
                    [resultDict setObject:[dict objectForKey:@"additionalValue"] forKey:[dict objectForKey:@"additionalID"]];
                }
                
            }
            NSLog(@"RESULTDICT %@",resultDict);
            [addVacanciesModel addCastingsParams:resultDict complitionBlock:^(id response) {
                NSLog(@"response %@",response);
                if([[response objectForKey:@"response"] integerValue] == 1){
                    [self showAlertWithMessageWithBlock:@"Вы создали кастинг" block:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                }
            }];
        
        }
    }else{
        
    }
    
    

}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

- (void) showTextFildText: (NSNotification*) notification {
    
    NSLog(@"%@", self.textFildName.text);
    
}



#pragma mark - HMImagePickerControllerDelegate
- (void)imagePickerController:(HMImagePickerController *)picker
      didFinishSelectedImages:(NSArray<UIImage *> *)images
               selectedAssets:(NSArray<PHAsset *> *)selectedAssets {
    
    self.imageVacancies = [images objectAtIndex:0];
    
    [self.buttonAddPhoto setImage: self.imageVacancies forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    APIManger * apiManager = [[APIManger alloc] init];
    [apiManager postImageDataFromSeverWithMethod:@"photo.save" andParams:nil andToken:[[SingleTone sharedManager] token] andImage:self.imageVacancies complitionBlock:^(id response) {
        
        NSLog(@"PHOTOSAVE %@",response);
        
        if(![response isKindOfClass:[NSDictionary class]]){
            
            NSLog(@"Загрузить фото не удалось");
        }else{
            NSDictionary * dictResponse = [response objectForKey:@"response"];
            
            self.photoID = [NSString stringWithFormat:@"%@",[dictResponse objectForKey:@"id"]];
            
            NSLog(@"PHOTOID %@",self.photoID);
            [self.buttonAddPhoto setImage:self.imageVacancies forState:UIControlStateNormal];
            self.buttonAddPhoto.layer.cornerRadius = 3.f;
            [self dismissViewControllerAnimated:YES completion:nil];
            
            
        }
        
    }];
    
    
}

#pragma mark - CountryViewControllerDelegate

- (void) changeButtonTextInSearch: (CountryViewController*) controller withString: (NSString*) string {
    
    if ([[[SingleTone sharedManager] country_citi] isEqualToString:@"country"]) {
        [self.buttonCountry setTitle:string forState:UIControlStateNormal];
        [self.buttonCity setTitle:@"Город" forState:UIControlStateNormal];
    } else {
        [self.buttonCity setTitle:string forState:UIControlStateNormal];
    }
}

#pragma mark - ViewForCommentDelegate

- (void) startTextView: (ViewForComment*) viewForComment endTextView: (UITextView*) textView {
    
    [self animationMethodWithBoolean:YES endView:viewForComment];
    
    
    
}
- (void) endTextView: (ViewForComment*) viewForComment endTextView: (UITextView*) textView {
    
    if ([viewForComment isEqual:self.viewComment]) {
        [self animationMethodWithBoolean:NO endView:self.viewComment];
    } else if ([viewForComment isEqual:self.viewHideComment]) {
        [self animationMethodWithBoolean:NO endView:self.viewHideComment];
    } else {
        NSLog(@"Шляпа");
    }

    
}

- (void) checkOnHeight: (UITextView*) textView {
    [UIView animateWithDuration:0.3 animations:^{
        self.mainScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.viewSave.frame) + (352 - 130));
        self.mainScrollView.contentOffset = CGPointMake(0, (CGRectGetMaxY(self.viewComment.frame) + 30 + (352 - 130)) - self.view.frame.size.height);
        [self animationViewsWithBool:YES];
    }];
    
}

- (void) checkOnHideHeight: (UITextView*) textView {
    [UIView animateWithDuration:0.3 animations:^{
        self.mainScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.viewSave.frame) + (352 - 130));
        self.mainScrollView.contentOffset = CGPointMake(0, (CGRectGetMaxY(self.viewHideComment.frame) + 30 + (352 - 130)) - self.view.frame.size.height);
        [self animationViewsWithBool:NO];
    }];
}

#pragma mark - Other
- (void) pushCountryController {
    CountryViewController * detai = [self.storyboard instantiateViewControllerWithIdentifier:@"CountryViewController"];
    detai.delegate = self;
    detai.isSearch = YES;
    [self.navigationController pushViewController:detai animated:YES];
}

#pragma mark - Animations

- (void) animationMethodWithBoolean: (BOOL) isBool endView: (UIView*) view {
    
    [UIView animateWithDuration:0.25 animations:^{

        if (isBool) {
            self.mainScrollView.contentSize = CGSizeMake(0, (CGRectGetMaxY(self.viewSave.frame)) + (352 - 130));
            self.mainScrollView.contentOffset =
            CGPointMake(0, ((CGRectGetMaxY(view.frame) + 30) + (352 - 130)) - self.view.frame.size.height);
        } else {
            self.mainScrollView.contentSize = CGSizeMake(0, (CGRectGetMaxY(self.viewSave.frame)));
        }

    }];
}

- (void) animationViewsWithBool: (BOOL) isBool {
    [UIView animateWithDuration:0.3 animations:^{
        
        if (isBool) {
            CGRect rect = self.viewHideComment.frame;
            rect.origin.y = CGRectGetMaxY(self.viewComment.frame);
            self.viewHideComment.frame = rect;
        }

        CGRect rectSave = self.viewSave.frame;
        rectSave.origin.y = CGRectGetMaxY(self.viewHideComment.frame);
        self.viewSave.frame = rectSave;
    }];
}




@end
