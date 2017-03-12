//
//  AddCastingController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 09.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "AddCastingController.h"
#import "HMImagePickerController.h"
#import "HexColors.h"
#import "CountryViewController.h"
#import "ChooseProfessionalModel.h"
#import "SingleTone.h"
#import "ChooseProfessionalModel.h"
#import "KinoproSearchModel.h"
#import "ViewForComment.h"

@interface AddCastingController () <HMImagePickerControllerDelegate, CountryViewControllerDelegate, ViewForCommentDelegate>

@property (strong, nonatomic) HMImagePickerController * pickerCastings;
@property (strong, nonatomic) UIImage * imageVacancies;
@property (strong, nonatomic) NSArray * arrayProfessions;
@property (strong, nonatomic) NSArray * arrayData;
@property (strong, nonatomic) NSArray * arrayGender;

@property (strong, nonatomic) ViewForComment * viewComment;
@property (strong, nonatomic) ViewForComment * viewHideComment;

@property (strong, nonatomic) NSMutableArray * arrayViews;



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
    
    self.arrayProfessions = [ChooseProfessionalModel getArrayProfessions];
    self.arrayData = [KinoproSearchModel setTestArray];
    self.arrayGender = [NSArray arrayWithObjects:@"Мужской", @"Женский", nil];
    self.arrayViews = [NSMutableArray array];
    
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
    
    
}

- (IBAction)actionButtonCreate:(id)sender {
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
    
//    APIManger * apiManager = [[APIManger alloc] init];
//    [apiManager postImageDataFromSeverWithMethod:@"photo.save" andParams:nil andToken:[[SingleTone sharedManager] token] andImage:self.imageVacancies complitionBlock:^(id response) {
//        
//        NSLog(@"PHOTOSAVE %@",response);
//        
//        if(![response isKindOfClass:[NSDictionary class]]){
//            
//            NSLog(@"Загрузить фото не удалось");
//        }else{
//            NSDictionary * dictResponse = [response objectForKey:@"response"];
//            
//            self.photoID = [NSString stringWithFormat:@"%@",[dictResponse objectForKey:@"id"]];
//            
//            NSLog(@"PHOTOID %@",self.photoID);
//            [self.buttonAddImage setImage:self.imageVacancies forState:UIControlStateNormal];
//            self.buttonAddImage.layer.cornerRadius = 3.f;
//            [self dismissViewControllerAnimated:YES completion:nil];
//            
//            
//        }
//        
//    }];
    
    
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