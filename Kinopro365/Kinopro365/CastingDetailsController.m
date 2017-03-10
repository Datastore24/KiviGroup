//
//  CastingDetailsController.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 07.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "CastingDetailsController.h"
#import "ViewForCastingParams.h"
#import "CastingDetailsModel.h"
#import "DateTimeMethod.h"
#import <VK-ios-sdk/VKSdk.h>
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения

@interface CastingDetailsController () <CastingDetailsModelDelegate,VKSdkDelegate,VKSdkUIDelegate>

@property (assign, nonatomic) CGFloat starHeightViewForParams;
@property (assign, nonatomic) CGFloat heightForAnimation;
@property (assign, nonatomic) CGFloat heightHide;
@property (strong, nonatomic) CastingDetailsModel * castingDetailModel;

@end

@implementation CastingDetailsController{
    FBSDKShareButton * FBbutton;
}


- (void) loadView {
    [super loadView];
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@""];
    self.navigationItem.titleView = CustomText;
    
    self.viewForShare.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.viewForShare.layer.shadowOffset = CGSizeMake(0.0f, -1.0f);
    self.viewForShare.layer.shadowOpacity = 1.0f;
    self.viewForShare.layer.shadowRadius = 4.0f;
    
    self.starHeightViewForParams = CGRectGetHeight(self.viewForParams.bounds);
    

    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
//    //Скрытие скрытых парамтеров--------------------------
//    self.heightHide = self.viewForHide.frame.size.height;
//    CGRect rectForHide = self.viewForHide.frame;
//    rectForHide.size.height = 0;
//    self.viewForHide.frame = rectForHide;
//    [self animationWithHeigthAnimathion:self.heightHide endType:2];
    
    self.castingDetailModel = [[CastingDetailsModel alloc] init];
    self.castingDetailModel.delegate = self;
    [self.castingDetailModel loadCasting:self.castingID];
    
    
    //Обновление окна параметров
    for (UIView * view in self.viewForParams.subviews) {
        [view removeFromSuperview];
    }
    CGRect rect = self.viewForParams.frame;
    rect.size.height = self.starHeightViewForParams;
    self.viewForParams.frame = rect;
    
    
    NSArray * arrayString = [NSArray arrayWithObjects:
                             @"Город: Москва", @"Требуется: Актер",
                             @"Пол: Жен", @"Возраст: от 25 до 30",
                             @"Рост: 145 - 160", nil];
    
    for (int i = 0; i < arrayString.count; i++) {
        ViewForCastingParams * view = [[ViewForCastingParams alloc] initWithMainView:self.viewForParams endHeight:0 + 16 * i endText:[arrayString objectAtIndex:i]];
        [self.viewForParams addSubview:view];
    }
    CGRect newRect = self.viewForParams.frame;
    newRect.size.height = 20 + 16 * arrayString.count;
    self.viewForParams.frame = newRect;
    
    self.heightForAnimation = self.viewForParams.frame.size.height - self.starHeightViewForParams;
    
    [self animationWithHeigthAnimathion:self.heightForAnimation endType:1];
    self.mainScrollView.contentSize = CGSizeMake(0, self.view.bounds.size.height + self.heightForAnimation - 64 - self.heightHide);

}

-(void) loadCasting: (NSDictionary *) catingDict{
    
    self.labelDescription.text = [catingDict objectForKey:@"description"];
    self.labelTitle.text =[catingDict objectForKey:@"name"];
    self.labelBidCount.text = [catingDict objectForKey:@"count_offer"];
    
    NSDate * endDate = [DateTimeMethod timestampToDate:[catingDict objectForKey:@"end_at"]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM"];
    NSString *stringDate = [dateFormatter stringFromDate:endDate];
    self.labelActively.text = [NSString stringWithFormat:@"Активно до: %@ ",stringDate];
    
    //СКРЫТОЕ ПОЛЕ
    self.openHideLabel = NO;
    if(self.openHideLabel){
        self.labelForHide.text = [catingDict objectForKey:@"contact_info"];
    }else{
        self.labelForHide.text = [catingDict objectForKey:@""];
        self.heightHide = 0.f;
    }
    
    
    if(![[catingDict objectForKey:@"logo_url"] isEqual:[NSNull null]]){
        NSURL *imgURL = [NSURL URLWithString:[catingDict objectForKey:@"logo_url"]];
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:imgURL
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 // progression tracking code
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished,
                                        NSURL *imageURL) {
                                
                                if(image){
                                    self.mainImage.contentMode = UIViewContentModeScaleAspectFill;
                                    self.mainImage.clipsToBounds = YES;
                                    self.mainImage.layer.cornerRadius = 5;
                                    self.mainImage.image = image;
                                    
                                    
                                }else{
                                    //Тут обработка ошибки загрузки изображения
                                }
                            }];
        
    }
    
    
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

#pragma mark - Actions

- (IBAction)actionBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionButtonVK:(id)sender {
    
    NSLog(@"Поделиться в контакте");
    VKShareDialogController * shareDialog = [VKShareDialogController new];
    
    shareDialog.text = [NSString stringWithFormat:@"В приложение CINARTA разместили Кастинг: %@",
                        self.castingName];
    shareDialog.shareLink = [[VKShareLink alloc] initWithTitle:@"Скачать приложение"
                                                          link:[NSURL URLWithString:@"https://radioversta.ru"]];
    shareDialog.uploadImages = @[[VKUploadImage uploadImageWithImage:self.castingImage
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
    
    content.contentDescription = [NSString stringWithFormat:@"В приложение CINARTA разместили Кастинг: %@",
                                  self.castingName];
    content.imageURL = [NSURL URLWithString:self.castingURL];
    
    FBbutton = [[FBSDKShareButton alloc] init];
    FBbutton.shareContent = content;
    FBbutton.center= self.view.center;
    FBbutton.alpha = 0.f;
    [self.view addSubview:FBbutton];
    
    
    NSLog(@"Поделить в фэйсбуке");
    [FBbutton sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)actionButtonAddBit:(id)sender {
    NSLog(@"Подать заявку");
    [self.castingDetailModel sendCastings:self.castingID complitionBlock:^(id response) {
        if([[response objectForKey:@"response"] integerValue] == 1){
            [self showAlertWithMessageWithBlock:@"Ваша заявка принята" block:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else if([[response objectForKey:@"error_code"] integerValue] == 781){
            [self showAlertWithMessageWithBlock:@"Кастинг не найден" block:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else if([[response objectForKey:@"error_code"] integerValue] == 782){
            [self showAlertWithMessageWithBlock:@"Нельзя подать заявку на свой кастинг" block:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else if([[response objectForKey:@"error_code"] integerValue] == 783){
            [self showAlertWithMessageWithBlock:@"Заявка уже была подана" block:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            [self showAlertWithMessageWithBlock:@"Заявку принять не удалось" block:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        
    }];
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

#pragma mark - Animathion

- (void) animationWithHeigthAnimathion: (CGFloat) heightAnimation endType: (NSInteger) type {
    
    for (int i = 0; i < self.arrayViews.count; i++) {
        UIView * view = [self.arrayViews objectAtIndex:i];
        
        if (type == 1) {
            if (i == 1 || i == 2) {
               CGRect rectView = view.frame;
                rectView.origin.y = rectView.origin.y + heightAnimation - self.heightHide;
               view.frame = rectView;
            }
        } if (type == 2) {
            if (i == 0 || i == 3) {
                CGRect rectView = view.frame;
                rectView.origin.y -= heightAnimation;
                view.frame = rectView;
            }
        }
    }
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
