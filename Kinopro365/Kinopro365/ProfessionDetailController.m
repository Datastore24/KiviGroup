//
//  ProfessionDetailController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 14.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "ProfessionDetailController.h"
#import "ProfessionDetailModel.h"
#import "AddParamsModel.h"
#import "PhotoView.h"
#import "VideoView.h"
#import "TextDataProfession.h"
#import "AddParamsProfession.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения
#import "PhotoDetailView.h"

@interface ProfessionDetailController () <ProfessionDetailModelDelegate,VideoViewDelegate, PhotoViewDelegate>

@property (assign, nonatomic) CGFloat maxHeightVideo; //параметр сохраняет конечное положение вью всех видео
@property (strong, nonatomic) ProfessionDetailModel * profDetailModel;

@property (strong, nonatomic) PhotoDetailView * imageView;

@end

@implementation ProfessionDetailController

- (void) loadView {
    [super loadView];
    
    //UIImageView For photo
    
    self.photoScrollView.showsHorizontalScrollIndicator = NO;
    UILabel * customText = [[UILabel alloc]initWithTitle:self.profName];
    self.navigationItem.titleView = customText;
    self.buttonPhoneOne.layer.cornerRadius = 5.f;
    self.buttonPhoneTwo.layer.cornerRadius = 5.f;
    
    self.shadowView.backgroundColor = [UIColor lightGrayColor];
    [self.shadowView.layer setShadowOffset:CGSizeMake(0, 3)];
    [self.shadowView.layer setShadowOpacity:0.7];
    [self.shadowView.layer setShadowRadius:2.0f];
    [self.shadowView.layer setShouldRasterize:YES];
    
    [self.shadowView.layer setCornerRadius:5.0f];
    
    //проверка на наличие нажатой кнопки награда и лайк
    
    self.buttonLike.isBool = NO;
    self.buttonStar.isBool = NO;
    
    if (self.buttonStar.isBool) {
        [self.buttonStar setImage:[UIImage imageNamed:@"isRewarImageOn"] forState:UIControlStateNormal];
    } else {
        [self.buttonStar setImage:[UIImage imageNamed:@"professionImageStar"] forState:UIControlStateNormal];
    }
    
    if (self.buttonLike.isBool) {
        [self.buttonLike setImage:[UIImage imageNamed:@"isLikeImageOn"] forState:UIControlStateNormal];
    } else {
        [self.buttonLike setImage:[UIImage imageNamed:@"professionImageLike"] forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.maxHeightVideo = 0.f;
    [self createActivitiIndicatorAlertWithView];
    self.profDetailModel = [[ProfessionDetailModel alloc] init];
    self.profDetailModel.delegate = self;
    [self.profDetailModel loadProfile:self.profileID andProffesionID:self.profID];
    
    self.imageView = [[PhotoDetailView alloc] initWithCustomFrame:
                      CGRectMake(0.f, 64.f, self.view.frame.size.width,
                                 self.view.frame.size.height - 64.f)];
    //    self.imageView.backgroundColor = [UIColor blueColor];
    self.imageView.imageViewDelete.backgroundColor = [UIColor blackColor];
    [self.imageView.imageViewDelete setContentMode:UIViewContentModeTop];
    [self.view addSubview:self.imageView];
    self.imageView.alpha = 0.f;
    
    
}

-(void) loadProfile:(NSDictionary *) profileDict{
    
    //Profile INFO
    
    NSURL *imgURL = [NSURL URLWithString:[profileDict objectForKey:@"photo_url"]];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:imgURL
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             // progression tracking code
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished,
                                    NSURL *imageURL) {
                            
                            if(image){
                                self.imageAvatar.contentMode = UIViewContentModeScaleAspectFill;
                                self.imageAvatar.clipsToBounds = YES;
                                self.imageAvatar.layer.cornerRadius = 5;
                                self.imageAvatar.image = image;
                                
                                
                            }else{
                                //Тут обработка ошибки загрузки изображения
                            }
                        }];
    
    self.labelName.text = [NSString stringWithFormat:@"%@ %@",
                           [profileDict objectForKey:@"first_name"],
                           [profileDict objectForKey:@"last_name"]];
    
    self.labelCountry.text = [NSString stringWithFormat:@"%@ %@",
                         [profileDict objectForKey:@"city_name"],
                         [profileDict objectForKey:@"country_name"]];
    
    self.labelAge.text = [NSString stringWithFormat:@"Возраст: %@",
                          [profileDict objectForKey:@"age"]];
    
    if([profileDict objectForKey:@"ex_height"]){
        self.labelGrowth.text = [NSString stringWithFormat:
                                 @"Рост: %@ см",[profileDict objectForKey:@"ex_height"]];
    }else{
        self.labelGrowth.alpha = 0.f;
    }
    
    self.labelLikeCount.text = [profileDict objectForKey:@"count_likes"];
    self.labelStarCount.text = [profileDict objectForKey:@"count_rewards"];
    
    if([[profileDict objectForKey:@"is_favourite"] integerValue]!=0){
        [self.buttonBookmark setImage:[UIImage imageNamed:@"professionImageBookmarkOn"] forState:UIControlStateNormal];
        self.buttonBookmark.isBool = YES;
    }else{
        [self.buttonBookmark setImage:[UIImage imageNamed:@"professionImageBookmark"] forState:UIControlStateNormal];
        self.buttonBookmark.isBool = NO;
    }
    
   

    BOOL openContact;
    if([[profileDict objectForKey:@"is_open_contacts"] integerValue] == 1){
        for (UIView * view in self.arrayCollectionYES) {
            view.alpha = 1;
        }
        for (UIView * view in self.arrayCollectionNo) {
            view.alpha = 0;
        }
        openContact = YES;
    }else{
        
        for (UIView * view in self.arrayCollectionYES) {
            view.alpha = 0;
        }
        for (UIView * view in self.arrayCollectionNo) {
            view.alpha = 1;
        }
        openContact = NO;
       
        
    }
    
    
    
    //
    
    
    //Scroll Photo-----------------------------------
    self.photoScrollView.contentSize = CGSizeMake(0, 0);
    
    NSInteger countPhoto = [[profileDict objectForKey:@"count_photos"] integerValue];
    
    if (countPhoto != 0)  {
        self.viewForPhoto.alpha = 0.f;
        
        [self.profDetailModel loadPhoto:self.profileID andOffset:@"0" andCount:@"1000" complitionBlock:^(id response) {
            NSArray * itemsArray = [response objectForKey:@"items"];
            
            
            for (int i = 0; i < itemsArray.count; i++) {
                NSDictionary * itemsDict = [itemsArray objectAtIndex:i];
                PhotoView * photoView = [[PhotoView alloc] initWithFrame:CGRectMake(21.f + 74.f * i, 7.f, 53.f, 80.f)
                                                      andWithImageButton:[itemsDict objectForKey:@"url"]];
                photoView.delegate = self;
                [self.photoScrollView addSubview:photoView];
            }
            
        }];
        
        
        self.photoScrollView.contentSize = CGSizeMake(21.f + 74.f * countPhoto, 0);
    }else{
        self.viewForPhoto.alpha = 1.f;
    }
    
    //ScrollVideo--------------------------------------
    
    
    
    NSInteger countVideo = [[profileDict objectForKey:@"count_videos"] integerValue]; //Колличество видео
    
    if(countVideo>0){
        [self.profDetailModel loadVideo:self.profileID andOffset:@"0" andCount:@"1000" complitionBlock:^(id response) {
            
            
            NSArray * itemsArray = [response objectForKey:@"items"];
            
            for (int i = 0; i < itemsArray.count; i++) {
                NSDictionary * itemDict = [itemsArray objectAtIndex:i];
                
                NSInteger startY;
                if(openContact){
                    startY = 342;
                }else{
                    startY = 270;
                }
                if(i==itemsArray.count -1){
                    VideoView * videoViewPlayer = [[VideoView alloc] initWithHeight:startY + 144 * i andURLVideo:[itemDict objectForKey:@"link"] lastObject:YES];
                    videoViewPlayer.delegate = self;
                    [self.mainScrollView addSubview:videoViewPlayer];
                    self.maxHeightVideo = CGRectGetMaxY(videoViewPlayer.frame);
                }else{
                    VideoView * videoViewPlayer = [[VideoView alloc] initWithHeight:startY + 144 * i andURLVideo:[itemDict objectForKey:@"link"] lastObject:NO];
                     videoViewPlayer.delegate = self;
                    [self.mainScrollView addSubview:videoViewPlayer];
                }
                
                
            }
            NSLog(@"PROFILEDICT %@",profileDict);
            [self loadMore:profileDict andOpenContact:openContact];
            
        }];
       
    }else{
        [self loadMore:profileDict andOpenContact:openContact];
        [self deleteActivitiIndicator];
        
    }
    
    
    
    
    
    
}

-(void) loadMore:(NSDictionary *) profileDict andOpenContact: (BOOL) openContact {
    //Отрисовка текстовых параметров------------------------
    if (self.maxHeightVideo == 0) {
        NSInteger startY;
        if(openContact){
            startY = 342;
        }else{
            startY = 270;
        }
        self.maxHeightVideo = startY - 26.f;
    }
    
    AddParamsModel * addParamsModel = [[AddParamsModel alloc] init];

    NSArray * profArray = [addParamsModel getParamsDict:[self.profID integerValue]];
    int i=0;
    for (NSString *key in profileDict) {
        NSDictionary * params = [addParamsModel getInformationDictionary:key andProfArray:profArray];
        NSLog(@"PARAMSKEY %@",key);
 
        if(params.count> 0){
            NSDictionary * finalInfoParams = [addParamsModel getNameByDictionary:[params objectForKey:@"array"] andFindID:[profileDict objectForKey:key]];
            NSLog(@"DICTFINAL %@",finalInfoParams);
            
//            NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                   key,@"additionalID",
//                                   [params objectForKey:@"title"],@"title",
//                                   [finalInfoParams objectForKey:@"name"], @"value",nil];
            
            
            TextDataProfession * textDataProfession = [[TextDataProfession alloc] initWithHeight:self.maxHeightVideo + 26.f + 25 * i
                                                                               antFirstTextLabel: [params objectForKey:@"title"]
                                                                              andSecondTextLabel:[finalInfoParams objectForKey:@"name"]];
            
           
            [self.mainScrollView addSubview:textDataProfession];

            i++;
            
            
        }
    }
    NSLog(@"LANGUAGE %@",[profileDict objectForKey:@"languages"]);
    
    NSArray * language = [profileDict objectForKey:@"languages"];
    
    NSMutableString * resultString = [NSMutableString new];
    
    for(int k=0; k<language.count; k++) {
        NSDictionary * langDict = [language objectAtIndex:k];
        NSDictionary * resLangDict =  [self getLanguageNameByID:[langDict objectForKey:@"language_id"]];
        NSLog(@"RESLANG %@",resLangDict);
        if(k==0){
            [resultString appendString:[resLangDict objectForKey:@"name"]];
        }else if(k>0){
            [resultString appendString:@", "];
            [resultString appendString:[resLangDict objectForKey:@"name"]];
        }
    }
    
   
    if(language.count>0){
        TextDataProfession * textDataProfession = [[TextDataProfession alloc] initWithHeight:self.maxHeightVideo + 26.f + 25 * i
                                                                           antFirstTextLabel: @"Языки"
                                                                          andSecondTextLabel:resultString];
        [self.mainScrollView addSubview:textDataProfession];
        
        i++;  
    }
     

    
    //Отрисовка доп параметров-----------------------------
    

    if ([profileDict objectForKey:@"user_comment"] == [NSNull null] || [[profileDict objectForKey:@"user_comment"] length] == 0) {
        self.mainScrollView.contentSize = CGSizeMake(0, self.maxHeightVideo + 46.f + 25 * i+1);
    } else {
        
        
        AddParamsProfession * addParamsView = [[AddParamsProfession alloc]
                                               initWithHeight:self.maxHeightVideo + 46.f + 25 * i+1
                                               andText:[profileDict objectForKey:@"user_comment"]];
        [self.mainScrollView addSubview:addParamsView];
        self.mainScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(addParamsView.frame));
        
        
        //Отрисовка тени-------------------------------------
        UIView * viewShadow = [[UIView alloc] initWithFrame:
                               CGRectMake(0, CGRectGetMinY(addParamsView.frame) - 2.f,
                                          CGRectGetWidth(self.view.bounds), 2)];
        viewShadow.backgroundColor = [UIColor whiteColor];
        viewShadow.layer.borderColor = [UIColor whiteColor].CGColor;
        viewShadow.layer.shadowRadius  = 1.5f;
        viewShadow.layer.shadowColor   = [UIColor darkGrayColor].CGColor;
        viewShadow.layer.shadowOffset  = CGSizeMake(0.0f, 2.0f);
        viewShadow.layer.shadowOpacity = 0.7f;
        viewShadow.layer.masksToBounds = NO;
        [self.mainScrollView addSubview:viewShadow];
        
        UIView * custView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(addParamsView.frame) - 3.f, CGRectGetWidth(self.view.bounds), 3.f)];
        custView.backgroundColor = [UIColor whiteColor];
        [self.mainScrollView addSubview:custView];
        
    }

}

#pragma mark - PhotoViewDelegate

- (void) actionCell: (PhotoView*) photoView withImageButton: (UIButton*) imageButton {
    [UIView animateWithDuration:0.3 animations:^{
        self.imageView.imageView.image = imageButton.imageView.image;
        self.imageView.alpha = 1.f;
    }];
}


#pragma mark - Actions

- (IBAction)actionButtonBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionButtonBookmark:(CustomButton*)sender {
    
    ProfessionDetailModel * profDetailModel = [[ProfessionDetailModel alloc] init];
    
    if (!sender.isBool) {
        
        [profDetailModel sendIsFavourite:NO andProfileID:self.profileID complitionBlock:^(id response) {
            [sender setImage:[UIImage imageNamed:@"professionImageBookmarkOn"]
                    forState:UIControlStateNormal];
            [self.buttonBookmarkBack setImage:[UIImage imageNamed:@"professionImageBookmarkOn"]
                                     forState:UIControlStateNormal];
            
            
            sender.isBool = YES;
        }];
        
    } else {
        [profDetailModel sendIsFavourite:YES andProfileID:self.profileID complitionBlock:^(id response) {
            [sender setImage:[UIImage imageNamed:@"professionImageBookmark"]
                    forState:UIControlStateNormal];
            [self.buttonBookmarkBack setImage:[UIImage imageNamed:@"professionImageBookmark"]
                                     forState:UIControlStateNormal];
            sender.isBool = NO;
        }];
        
    }
    
}

- (IBAction)actionButtonLike:(CustomButton*)sender {
    if (sender.isBool) {
        [sender setImage:[UIImage imageNamed:@"professionImageLike"] forState:UIControlStateNormal];
        NSInteger count = [self.labelLikeCount.text integerValue];
        count -= 1;
        self.labelLikeCount.text = [NSString stringWithFormat:@"%ld", count];
        sender.isBool = NO;
    } else {
        [sender setImage:[UIImage imageNamed:@"isLikeImageOn"] forState:UIControlStateNormal];
        NSInteger count = [self.labelLikeCount.text integerValue];
        count += 1;
        self.labelLikeCount.text = [NSString stringWithFormat:@"%ld", count];
        sender.isBool = YES;
    }
}

- (IBAction)actionButtomStar:(CustomButton*)sender {
    if (sender.isBool) {
        [sender setImage:[UIImage imageNamed:@"professionImageStar"] forState:UIControlStateNormal];
        NSInteger count = [self.labelStarCount.text integerValue];
        count -= 1;
        self.labelStarCount.text = [NSString stringWithFormat:@"%ld", count];
        sender.isBool = NO;
    } else {
        [sender setImage:[UIImage imageNamed:@"isRewarImageOn"] forState:UIControlStateNormal];
        NSInteger count = [self.labelStarCount.text integerValue];
        count += 1;
        self.labelStarCount.text = [NSString stringWithFormat:@"%ld", count];
        sender.isBool = YES;
    }
}

-(void) deleteActivitiIndicatorDelegate{
    [self deleteActivitiIndicator];
}

@end
