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
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Создать вакансию"];
    self.navigationItem.titleView = CustomText;
    
    self.viewForComment.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"4682AC"].CGColor;
    self.viewForComment.layer.borderWidth = 1.f;
    self.viewForComment.layer.cornerRadius = 5.f;
    
    self.mainScrollView.userInteractionEnabled = YES;
    
    self.buttonCreate.layer.cornerRadius = 5.f;
    
    self.textView.placeholder = @"Какая концепция проекта? Кто нужен для проекта? Что нужно делать? Сколько платят?";
    self.textView.placeholderColor = [[UIColor hx_colorWithHexRGBAString:@"517BA2"] colorWithAlphaComponent:0.45];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.heightForText = 55;
    
    self.arrayProfessions = [ChooseProfessionalModel getArrayProfessions];
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
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
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

    NSLog(@"currentDate %@", currentDateString);
    
    CustomButton * prof = [self.view viewWithTag:5000];
    
    NSLog(@"Имя:%@\nТекст:%@\nОкончание:%@\nСтрана:%@\nГород:%@\nPHOTOID:%@\nPROFID:%@",self.textFildName.text,self.textView.text,unixTimeEndAt, [[SingleTone sharedManager] countrySearchID],[[SingleTone sharedManager] citySearchID],self.photoID,prof.customID);
    
    
    if(self.textFildName.text.length ==0){
        [self showAlertWithMessage:@"Введите название вакансии"];
    }else if(self.photoID.length == 0){
        [self showAlertWithMessage:@"Выберите фото вакансии"];
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
        AddVacanciesModel * addVacanciesModel = [[AddVacanciesModel alloc] init];
        [addVacanciesModel addVacanciesName:self.textFildName.text andLogoID:self.photoID andEndAt:unixTimeEndAt andProfessionID:prof.customID andCountryID:[[SingleTone sharedManager] countrySearchID] andCityID:[[SingleTone sharedManager] citySearchID] andDescription:self.textView.text complitionBlock:^(id response) {
            NSLog(@"response %@",response);
            if([[response objectForKey:@"response"] integerValue] == 1){
                    [self showAlertWithMessageWithBlock:@"Вы создали вакансию" block:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
            }
            
        }];
    }
    
    
    

    
}

#pragma mark - Notifications

- (void) keyboardWillShow: (NSNotification*) notification {
    
    self.dictKeyboard = [self paramsKeyboardWithNotification:notification];
}

- (void) keyboardWillHide: (NSNotification*) notification {
    
    self.dictKeyboard = [self paramsKeyboardWithNotification:notification];
}

#pragma mark - UITextViewDelegate


- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self animationMethodWithDictParams:self.dictKeyboard];
    
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    [self animationMethodWithDictParams:self.dictKeyboard];

}

- (void)textViewDidChange:(UITextView *)textView {
    
    CGFloat textHeight = [self getLabelHeight:textView];
    NSLog(@"%@", textView.text);
    
    if (textHeight >= 55) {
        [self animationsForViewWithTextHeight:textHeight];
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

- (NSDictionary*) paramsKeyboardWithNotification: (NSNotification*) notification {
    
    CGFloat animationDuration = [[notification.userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    NSValue* keyboardFrameBegin = [notification.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    CGFloat heightValue = keyboardFrameBeginRect.origin.y;
    CGFloat heightCount = keyboardFrameBeginRect.size.height;
    
    NSDictionary * dictParams = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithFloat:animationDuration], @"animation",
                                 [NSNumber numberWithFloat:heightValue], @"height",
                                 [NSNumber numberWithFloat:heightCount], @"count", nil];
    
    NSLog(@"Hello2");
    return dictParams;
}

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

- (void) animationMethodWithDictParams: (NSDictionary*) dict{
    
    [UIView animateWithDuration:[[dict objectForKey:@"animation"] floatValue] animations:^{
        CGRect newRect = self.view.frame;
        newRect.origin.y = [[dict objectForKey:@"height"] floatValue] - (CGRectGetHeight(newRect));
        self.view.frame = newRect;
    }];
}

- (void) animationsForViewWithTextHeight: (CGFloat) textHeight {
    
    static CGFloat constHeight;
    
    if (textHeight > self.heightForText) {
        constHeight = 18.f;
    } else if (textHeight < self.heightForText) {
        constHeight = -18.f;
    }
   
    if (textHeight != self.heightForText) {
        [UIView animateWithDuration:0.3 animations:^{
            
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            
            CGRect rectForView = self.viewForComment.frame;
            CGRect rectForText = self.textView.frame;
            CGRect rectForButton = self.buttonCreate.frame;
            
            rectForView.size.height += constHeight;
            rectForText.size.height += constHeight;
            rectForButton.origin.y += constHeight;
            self.mainScrollView.contentSize = CGSizeMake(0, self.view.bounds.size.height + (constHeight - 64));
            self.mainScrollView.contentOffset = CGPointMake(0, self.mainScrollView.contentOffset.y + constHeight);
            
            self.viewForComment.frame = rectForView;
            self.textView.frame = rectForText;
            self.buttonCreate.frame = rectForButton;
            
        } completion:^(BOOL finished) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            self.heightForText = textHeight;
        }];
    }

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
            self.buttonAddImage.layer.cornerRadius = 3.f;
            [self dismissViewControllerAnimated:YES completion:nil];
            
            
        }
        
    }];
  

}

#pragma mark - CountryViewControllerDelegate

- (void) changeButtonTextInSearch: (CountryViewController*) controller withString: (NSString*) string {
    
    if ([[[SingleTone sharedManager] country_citi] isEqualToString:@"country"]) {
        [self.buttonCountry setTitle:string forState:UIControlStateNormal];
    } else {
        [self.buttonCity setTitle:string forState:UIControlStateNormal];
    }
}



@end
