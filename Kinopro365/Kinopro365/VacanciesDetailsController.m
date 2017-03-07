//
//  VacanciesDetailsController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 02.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "VacanciesDetailsController.h"
#import "VacanciesDetailsModel.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения
#import "DateTimeMethod.h"
#import <VK-ios-sdk/VKSdk.h>
#import "ChooseProfessionalModel.h"

@interface VacanciesDetailsController () <VacanciesDetailsModelDelegate,VKSdkDelegate,VKSdkUIDelegate>
@property (strong, nonatomic) VacanciesDetailsModel * vacanciesDetailModel;

@end

@implementation VacanciesDetailsController{
    FBSDKShareButton * FBbutton;
}

- (void) loadView {
    [super loadView];
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Вакансии"];
    self.navigationItem.titleView = CustomText;
    
    
    
    self.twoWithView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.twoWithView.layer.shadowOffset = CGSizeMake(0.0f, -1.0f);
    self.twoWithView.layer.shadowOpacity = 1.0f;
    self.twoWithView.layer.shadowRadius = 4.0f;
    self.buttonApply.layer.cornerRadius = 5;
    
    self.vacanciesDetailModel = [[VacanciesDetailsModel alloc] init];
    self.vacanciesDetailModel.delegate = self;
    [self.vacanciesDetailModel loadVacancies:self.vacancyID];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[VKSdk initializeWithAppId:@"5910248"] registerDelegate:self];
    [[VKSdk initializeWithAppId:@"5910248"] setUiDelegate:self];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    CGFloat textFloat = [self getLabelHeight:self.mainTextLabel];
    
    if (textFloat > 80.f) {
        [self animationViewForHeightText:textFloat];
    }
    
    
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];

    
    
}

-(void) loadMyVacancies:(NSDictionary *) vacanciesDict{
    NSLog(@"RESP %@",vacanciesDict);
    
    self.mainTextLabel.text = [vacanciesDict objectForKey:@"description"];
    self.nameLabel.text =[vacanciesDict objectForKey:@"name"];
    
    NSDate * endDate = [DateTimeMethod timestampToDate:[vacanciesDict objectForKey:@"end_at"]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM"];
    NSString *stringDate = [dateFormatter stringFromDate:endDate];
    self.activeLabel.text = [NSString stringWithFormat:@"Активно до: %@ ",stringDate];
    self.cityLabel.text = [NSString stringWithFormat:@"Город: %@",[vacanciesDict objectForKey:@"city_name"]];
    self.counterLabel.text =[NSString stringWithFormat:@"Подано заявок: %@",[vacanciesDict objectForKey:@"count_offer"]];
    
    NSArray * professionArray = [ChooseProfessionalModel getArrayProfessions];
    
    NSArray *filtered = [professionArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(id == %@)", [vacanciesDict objectForKey:@"profession_id"]]];
    NSDictionary *item;
    if(filtered.count>0){
        item = [filtered objectAtIndex:0];
    }
    
    
    if([item objectForKey:@"name"]){
        self.ProffesionLabel.text = [NSString stringWithFormat:@"Профессия: %@",[item objectForKey:@"name"]];
    }else{
        self.ProffesionLabel.text = @"Профессия";
    }
    

    
    NSURL *imgURL = [NSURL URLWithString:[vacanciesDict objectForKey:@"logo_url"]];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:imgURL
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             // progression tracking code
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished,
                                    NSURL *imageURL) {
                            
                            if(image){
                                self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
                                self.avatarImageView.clipsToBounds = YES;
                                self.avatarImageView.layer.cornerRadius = 5;
                                self.avatarImageView.image = image;
                                
                                
                            }else{
                                //Тут обработка ошибки загрузки изображения
                            }
                        }];


}

#pragma mark - Actions

- (IBAction)actionButtonBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionButtonVK:(id)sender {
    
    NSLog(@"Поделить Вконтакте");
    VKShareDialogController * shareDialog = [VKShareDialogController new];
    
    shareDialog.text = [NSString stringWithFormat:@"В приложение CINARTA разместили вакансию: %@",
                        self.vacancyName];
    shareDialog.shareLink = [[VKShareLink alloc] initWithTitle:@"Скачать приложение"
                                                          link:[NSURL URLWithString:@"https://radioversta.ru"]];
    shareDialog.uploadImages = @[[VKUploadImage uploadImageWithImage:self.vacancyImage
                                                           andParams:[VKImageParameters jpegImageWithQuality:100.f]]];
    
    [shareDialog setCompletionHandler:^(VKShareDialogController * dialog, VKShareDialogControllerResult result) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
   
    [self presentViewController:shareDialog animated:YES completion:nil];
    
}


- (IBAction)actionButtonFacebook:(id)sender {
        FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
        content.contentURL = [NSURL
                              URLWithString:@"http://radioversta.ru"];
        content.contentTitle = @"Приложение CINARTA";
    content.contentDescription = [NSString stringWithFormat:@"В приложение CINARTA разместили вакансию: %@",
                                  self.vacancyName];
        content.imageURL = [NSURL URLWithString:self.vacancyURL];
    
        FBbutton = [[FBSDKShareButton alloc] init];
        FBbutton.shareContent = content;
        FBbutton.center= self.view.center;
        FBbutton.alpha = 0.f;
        [self.view addSubview:FBbutton];

    
    NSLog(@"Поделить в фэйсбуке");
    [FBbutton sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)actionButtonApply:(id)sender {
    
    NSLog(@"Принять заявку");
    [self.vacanciesDetailModel sendVacancy:self.vacancyID complitionBlock:^(id response) {
        
        if([[response objectForKey:@"response"] integerValue] == 1){
            [self showAlertWithMessageWithBlock:@"Ваша заявка принята" block:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else if([[response objectForKey:@"error_code"] integerValue] == 683){
            [self showAlertWithMessageWithBlock:@"Заявка уже была подана" block:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else if([[response objectForKey:@"error_code"] integerValue] == 681){
            [self showAlertWithMessageWithBlock:@"Вакансия не найдена" block:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else if([[response objectForKey:@"error_code"] integerValue] == 682){
            [self showAlertWithMessageWithBlock:@"Нельзя подать заявку\nна свою вакансию" block:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            [self showAlertWithMessageWithBlock:@"Заявку принять не удалось" block:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];
    
    
    
}

#pragma mark - Animations

- (void) animationViewForHeightText: (CGFloat) heightText {
    

        
        CGRect frameForTextView = self.viewForMainText.frame;
        frameForTextView.size.height += (heightText - 80);
        self.viewForMainText.frame = frameForTextView;
        
        
        for (UIView * view in self.arrayForAnimation) {
            CGRect rectForView = view.frame;
            rectForView.origin.y += (heightText - 80);
            view.frame = rectForView;
        }
        
        self.mainScrollView.contentSize = CGSizeMake(0, self.view.frame.size.height + (heightText - 80 - 64));
        

    
    
}

#pragma mark - Other

- (CGFloat)getLabelHeight:(UILabel*)label
{
    CGSize constraint = CGSizeMake(label.frame.size.width, CGFLOAT_MAX);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:label.font}
                                                  context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.height;
}

#pragma mark - VKSDK

- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result{
    if (result.token) {
        [self actionButtonFacebook:nil];
    } else if (result.error) {
        // Пользователь отменил авторизацию или произошла ошибка
    }
}

- (void)vkSdkUserAuthorizationFailed{
    
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"vkauthorize://"]]) {
        
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    
    VKCaptchaViewController * vc = [VKCaptchaViewController captchaControllerWithError:captchaError];
    [vc presentIn:self];
}
@end
