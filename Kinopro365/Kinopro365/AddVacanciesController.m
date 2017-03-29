//
//  AddVacanciesController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 02.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "AddVacanciesController.h"
#import "AddVacanciesModel.h"
#import "HexColors.h"
#import "HMImagePickerController.h"
#import "APIManger.h"
#import "SingleTone.h"
#import "CountryViewController.h"
#import "ChooseProfessionalModel.h"
#import "DateTimeMethod.h"

@interface AddVacanciesController () <UITextFieldDelegate, UITextViewDelegate, HMImagePickerControllerDelegate, CountryViewControllerDelegate>

@property (strong, nonatomic) NSDictionary * dictKeyboard;
@property (assign, nonatomic) CGFloat heightForText;
@property (strong, nonatomic) HMImagePickerController * pickerVacencies;
@property (strong, nonatomic) UIImage * imageVacancies;
@property (strong, nonatomic) NSString * photoID;

@property (strong, nonatomic) NSArray * arrayProfessions;


@end

@implementation AddVacanciesController

- (void) loadView {
    [super loadView];
    UILabel * CustomText;
    if(!self.isEditor){
            CustomText = [[UILabel alloc]initWithTitle:@"Создать вакансию"];
    }else{
            CustomText = [[UILabel alloc]initWithTitle:@"Редактировать вакансию"];
        self.textView.text = self.textViewVacancy;
        CGFloat textHeight = [self getLabelHeight:self.textView];
        if (textHeight > 55) {
            [self animationsForViewWithTextHeight:textHeight endBool:NO endStartAnim:YES];
        } else {
            [self animationsForViewWithTextHeight:textHeight endBool:YES endStartAnim:YES];
        }
        self.textFildName.text = self.nameVacancy;
        [self.buttonCity setTitle:self.cityNameVacancy forState:UIControlStateNormal];
        [self.buttonCountry setTitle:self.countryNameVacancy forState:UIControlStateNormal];
        if(self.mainImageVacancy){
            [self.buttonAddImage setImage:self.mainImageVacancy forState:UIControlStateNormal];
        }
        
        self.buttonAddImage.layer.cornerRadius = 5.f;
        self.buttonAddImage.clipsToBounds = YES;
       
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy"];
        NSString *yearString = [formatter stringFromDate:[NSDate date]];
        NSString * addYear = [NSString stringWithFormat:@"%@.%@",self.endAtVacancy,yearString];
        NSString * endAt = [DateTimeMethod convertDateStringToFormat:addYear startFormat:@"dd.MM.yyyy" endFormat:@"dd MMMM yyyy"];
        [self.buttonDate setTitle:endAt forState:UIControlStateNormal];
        [self.buttonProfession setTitle:self.professionNameVacancy forState:UIControlStateNormal];
        [self.createButton setTitle:@"Изменить" forState:UIControlStateNormal];
        
        
    }
    
    self.navigationItem.titleView = CustomText;
    
    self.textView.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"4682AC"].CGColor;
    self.textView.layer.borderWidth = 1.f;
    self.textView.layer.cornerRadius = 5.f;
    self.textView.scrollEnabled = NO;
    
    self.mainScrollView.userInteractionEnabled = YES;
    
    self.buttonCreate.layer.cornerRadius = 5.f;
    
    self.textView.placeholder = @"Какая концепция проекта? Кто нужен для проекта? Что нужно делать? Сколько платят?";
    self.textView.placeholderColor = [[UIColor hx_colorWithHexRGBAString:@"517BA2"] colorWithAlphaComponent:0.45];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[SingleTone sharedManager] setCountrySearchID:@""];
    [[SingleTone sharedManager] setCitySearchID:@""];
    
    self.heightForText = 55;
    
    self.arrayProfessions = [ChooseProfessionalModel getArrayProfessionsForVacancy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showTextFildText:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
    
    
    
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

- (void) showTextFildText: (NSNotification*) notification {
    
    NSLog(@"%@", self.textFildName.text);
    
}

#pragma mark - Action

- (IBAction)actionButtonBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionButtonAddImage:(id)sender {
    self.pickerVacencies = [[HMImagePickerController alloc] initWithSelectedAssets:nil];
    self.pickerVacencies.pickerDelegate = self;
    self.pickerVacencies.targetSize = CGSizeMake(600, 600);
    self.pickerVacencies.maxPickerCount = 1;
    
    [self presentViewController:self.pickerVacencies animated:YES completion:nil];
}

- (IBAction)actionButtonDate:(id)sender {
    [self showDataPickerBirthdayWithButton:sender endBool:YES];
}

- (IBAction)actionButtonProfession:(CustomButton *)sender {
    [self showViewPickerWithButton:sender andTitl:@"Выберите профессию" andArrayData:self.arrayProfessions andKeyTitle:@"name" andKeyID:@"id" andDefValueIndex:nil];
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

#pragma mark - Other
- (void) pushCountryController {
    CountryViewController * detai = [self.storyboard instantiateViewControllerWithIdentifier:@"CountryViewController"];
    detai.delegate = self;
    detai.isSearch = YES;
    [self.navigationController pushViewController:detai animated:YES];
}

- (IBAction)actionButtonCreate:(id)sender {
    
    NSDate * stringToDate = [DateTimeMethod convertStringToNSDate:self.buttonDate.titleLabel.text withFormatDate:@"dd MMMM yyyy"];
    NSString * unixTimeEndAt = [DateTimeMethod dateToTimestamp:stringToDate];
    
    
    NSDate * currentDate = [DateTimeMethod getLocalDateInFormat:@"dd MMMM yyyy"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    
    CustomButton * prof = [self.view viewWithTag:5000];
    
    
    AddVacanciesModel * addVacanciesModel = [[AddVacanciesModel alloc] init];
    if(!self.isEditor){
        if(self.textFildName.text.length ==0){
            [self showAlertWithMessage:@"Введите название вакансии"];
        }else if([unixTimeEndAt isEqualToString:@"0"]){
            [self showAlertWithMessage:@"Выберите дату приема заявок"];
        }else if([self.buttonDate.titleLabel.text isEqualToString:currentDateString]){
            [self showAlertWithMessage:@"Дата окончания не может быть\nв этот же день"];
        }else if([self.buttonDate.titleLabel.text integerValue] < [currentDateString integerValue]){
            [self showAlertWithMessage:@"Дата окончания не может быть\nв прошлом"];
        }else if(prof.customID.length == 0){
            [self showAlertWithMessage:@"Выберите профессию"];
        }else if([[SingleTone sharedManager] countrySearchID].length == 0){
            [self showAlertWithMessage:@"Выберите Страну"];
        }else if([[SingleTone sharedManager] citySearchID].length == 0){
            [self showAlertWithMessage:@"Выберите Город"];
        }else if(self.textView.text.length == 0){
            [self showAlertWithMessage:@"Введите описание вакансии"];
        }else{
            [addVacanciesModel addVacanciesName:self.textFildName.text andLogoID:self.photoID andEndAt:unixTimeEndAt andProfessionID:prof.customID andCountryID:[[SingleTone sharedManager] countrySearchID] andCityID:[[SingleTone sharedManager] citySearchID] andDescription:self.textView.text complitionBlock:^(id response) {
                NSLog(@"response %@",response);
                if([[response objectForKey:@"response"] integerValue] == 1){
                    [self showAlertWithMessageWithBlock:@"Вы создали вакансию" block:^{
                        [[SingleTone sharedManager] setCountrySearchID:@""];
                        [[SingleTone sharedManager] setCitySearchID:@""];
                        
                        NSLog(@"PIZDEC2 %@,%@",[[SingleTone sharedManager] countrySearchID],[[SingleTone sharedManager] citySearchID]);
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                }
                
            }];
        }
        
    }else{
      
        if(self.textFildName.text.length ==0){
            [self showAlertWithMessage:@"Введите название вакансии"];
        }else if([unixTimeEndAt isEqualToString:@"0"]){
            [self showAlertWithMessage:@"Выберите дату приема заявок"];
        }else if([self.buttonDate.titleLabel.text isEqualToString:currentDateString]){
            [self showAlertWithMessage:@"Дата окончания не может быть\nв этот же день"];
        }else if([self.buttonDate.titleLabel.text integerValue] < [currentDateString integerValue]){
            [self showAlertWithMessage:@"Дата окончания не может быть\nв прошлом"];
        }else if(self.professionIDVacancy.length == 0){
            [self showAlertWithMessage:@"Выберите профессию"];
        }else if(self.countryNameVacancy.length == 0 || [self.buttonCountry.titleLabel.text isEqualToString:@"Страна"]){
            [self showAlertWithMessage:@"Выберите Страну"];
        }else if(self.cityNameVacancy.length == 0 || [self.buttonCity.titleLabel.text isEqualToString:@"Город"]){
            [self showAlertWithMessage:@"Выберите Город"];
        }else if(self.textView.text.length == 0){
            [self showAlertWithMessage:@"Введите описание вакансии"];
        }else{
            NSLog(@"PROFID %@",prof.customID);
            if(prof.customID.length !=0){
                self.professionIDVacancy = prof.customID;
            }
            
            if([[[SingleTone sharedManager] countrySearchID] length] != 0){
                self.countryIDVacancy = [[SingleTone sharedManager] countrySearchID];
            }
            
            if([[[SingleTone sharedManager] citySearchID] length] != 0){
                self.cityIDVacancy = [[SingleTone sharedManager] citySearchID];
            }
            
            
            NSString * photo;
            if(self.photoID.length !=0){
                photo = self.photoID;
            }else{
                photo = @"";
            }
            
            
            [addVacanciesModel editVacanciesName:self.textFildName.text andLogoID:photo andEndAt:unixTimeEndAt andProfessionID:self.professionIDVacancy andCountryID:self.countryIDVacancy andCityID:self.cityIDVacancy andDescription:self.textView.text andVacancyID:self.vacancyID complitionBlock:^(id response) {
                NSLog(@"response %@",response);
                if([[response objectForKey:@"response"] integerValue] == 1){
                    
                    
                    [self showAlertWithMessageWithBlock:@"Вакансия успешно изменена" block:^{
                        
                        [[SingleTone sharedManager] setCountrySearchID:@""];
                        [[SingleTone sharedManager] setCitySearchID:@""];
                        
                        NSLog(@"PIZDEC2 %@,%@",[[SingleTone sharedManager] countrySearchID],[[SingleTone sharedManager] citySearchID]);
                        
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                }
            }];
        }
    
    }

}

#pragma mark - UITextViewDelegate


- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self animationMethodWithBool:YES];
    
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    [self animationMethodWithBool:NO];

}

- (void)textViewDidChange:(UITextView *)textView {
    
    CGFloat textHeight = [self getLabelHeight:textView];
    NSLog(@"%f", textHeight);
    
    if (textHeight > 55) {
        [self animationsForViewWithTextHeight:textHeight endBool:NO endStartAnim:NO];
    } else {
        [self animationsForViewWithTextHeight:textHeight endBool:YES endStartAnim:NO];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


#pragma mark - Other

- (CGFloat)getLabelHeight:(UITextView*)textView
{
    CGSize constraint = CGSizeMake(textView.frame.size.width - 10, CGFLOAT_MAX);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [textView.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:textView.font}
                                                  context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.height;
}

#pragma mark - Animations

- (void) animationMethodWithBool: (BOOL) isBool {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        if (isBool) {
            self.mainScrollView.contentSize = CGSizeMake(0, (CGRectGetMaxY(self.buttonCreate.frame) + 14) + (352 - 130));
            self.mainScrollView.contentOffset =
            CGPointMake(0, ((CGRectGetMaxY(self.buttonCreate.frame) + 14) + (352 - 130)) - self.view.frame.size.height);
        } else {
            self.mainScrollView.contentSize = CGSizeMake(0, (CGRectGetMaxY(self.buttonCreate.frame) + 14));
        }
        
    }];
}

- (void) animationsForViewWithTextHeight: (CGFloat) textHeight endBool: (BOOL) isBool endStartAnim: (BOOL) startAnim {

    
    CGFloat duraction;
    if (startAnim) {
        duraction = 0.f;
    } else {
        duraction = 0.3f;
    }
        [UIView animateWithDuration:duraction animations:^{
            CGRect textViewRect = self.textView.frame;
            if (!isBool) {
                textViewRect.size.height = textHeight + 25;
            } else {
                textViewRect.size.height = 80;
                if (isiPhone6) {
                    textViewRect.size.height = 96;
                } else if (isiPhone6Plus) {
                    textViewRect.size.height = 104;
                }
            }
            self.textView.frame = textViewRect;
            
            CGRect buttonRect = self.buttonCreate.frame;
            buttonRect.origin.y = CGRectGetMaxY(self.textView.frame) + 10;
            self.buttonCreate.frame = buttonRect;
            
            if (startAnim) {
                self.mainScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.buttonCreate.frame) + 14);
//                self.mainScrollView.contentOffset = CGPointMake(0, (CGRectGetMaxY(self.buttonCreate.frame) + 14 + 64) - self.view.frame.size.height);
            } else {
            self.mainScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.buttonCreate.frame) + 14 + (352 - 130));
            self.mainScrollView.contentOffset = CGPointMake(0, (CGRectGetMaxY(self.buttonCreate.frame) + 14 + (352 - 130)) - self.view.frame.size.height);
        }
         
        }];


}

#pragma mark - HMImagePickerControllerDelegate
- (void)imagePickerController:(HMImagePickerController *)picker
      didFinishSelectedImages:(NSArray<UIImage *> *)images
               selectedAssets:(NSArray<PHAsset *> *)selectedAssets {
    
    self.imageVacancies = [images objectAtIndex:0];
    
    APIManger * apiManager = [[APIManger alloc] init];
    [apiManager postImageDataFromSeverWithMethod:@"photo.save" andParams:nil andToken:[[SingleTone sharedManager] token] andImage:self.imageVacancies complitionBlock:^(id response) {
        
        NSLog(@"PHOTOSAVE %@",response);
        
        if(![response isKindOfClass:[NSDictionary class]]){
            
            NSLog(@"Загрузить фото не удалось");
        }else{
            NSDictionary * dictResponse = [response objectForKey:@"response"];
            
            self.photoID = [NSString stringWithFormat:@"%@",[dictResponse objectForKey:@"id"]];
            
            NSLog(@"PHOTOID %@",self.photoID);
            [self.buttonAddImage setImage:self.imageVacancies forState:UIControlStateNormal];
            self.buttonAddImage.layer.cornerRadius = 5.f;
            self.buttonAddImage.clipsToBounds = YES;
            
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



@end
