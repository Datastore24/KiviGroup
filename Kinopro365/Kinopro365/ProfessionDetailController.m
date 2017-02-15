//
//  ProfessionDetailController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 14.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "ProfessionDetailController.h"
#import "PhotoView.h"
#import "VideoView.h"
#import "TextDataProfession.h"
#import "AddParamsProfession.h"

@interface ProfessionDetailController ()

@property (assign, nonatomic) CGFloat maxHeightVideo; //параметр сохраняет конечное положение вью всех видео


@end

@implementation ProfessionDetailController

- (void) loadView {
    [super loadView];
    
    self.photoScrollView.showsHorizontalScrollIndicator = NO;
    UILabel * customText = [[UILabel alloc]initWithTitle:@"Актеры"];
    self.navigationItem.titleView = customText;
    self.buttonPhoneOne.layer.cornerRadius = 5.f;
    self.buttonPhoneTwo.layer.cornerRadius = 5.f;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.maxHeightVideo = 0.f;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    //Scroll Photo-----------------------------------
    self.photoScrollView.contentSize = CGSizeMake(0, 0);
    
    NSInteger countPhoto = 8;
    
    if (countPhoto != 0)  {
        self.viewForPhoto.alpha = 0.f;
        for (int i = 0; i < countPhoto; i++) {
            PhotoView * photoView = [[PhotoView alloc] initWithFrame:CGRectMake(21.f + 74.f * i, 7.f, 53.f, 80.f)
                                                  andWithImageButton:@"imagePhotoProf.png"];
            [self.photoScrollView addSubview:photoView];
        }
        self.photoScrollView.contentSize = CGSizeMake(21.f + 74.f * 8, 0);
    }
    
    //ScrollVideo--------------------------------------
    NSInteger countVideo = 0; //Колличество видео
    BOOL videoAccess = YES; //Доступ на видео
    

    NSArray * arrayURL = [NSArray arrayWithObjects:
                          @"https://www.youtube.com/watch?v=bn5aE_Bky04",
                          @"https://www.youtube.com/watch?v=LKyZRSh_fUI",
                          @"https://www.youtube.com/watch?v=V7YHyhNUiRo", nil]; //Массив URLов
    
    if (!videoAccess) {
        for (UIView * view in self.arrayCollectionNo) {
            view.alpha = 1;
        }
        VideoView * videoViewAccess = [[VideoView alloc] initCustonButtonAccessVideo];
        [self.mainScrollView addSubview:videoViewAccess];
        self.maxHeightVideo = CGRectGetMaxY(videoViewAccess.frame);
        
    } else {
        
        for (UIView * view in self.arrayCollectionYES) {
            view.alpha = 1;
        }
        for (int i = 0; i < countVideo; i++) {
            VideoView * videoViewPlayer = [[VideoView alloc] initWithHeight:342 + 144 * i andURLVideo:[arrayURL objectAtIndex:i]];
            [self.mainScrollView addSubview:videoViewPlayer];
            self.maxHeightVideo = CGRectGetMaxY(videoViewPlayer.frame);
        }
    }
    
    //Отрисовка текстовых параметров------------------------
    if (self.maxHeightVideo == 0) {
        self.maxHeightVideo = 342.f - 26.f;
    }

    NSArray * arrayTitles = [NSArray arrayWithObjects:
                             @"Телосложение", @"Размер одежды:", @"Цвет волос:", nil];
    
    
    NSArray * arrayTextParams = [NSArray arrayWithObjects:
                                 @"Спортивное", @"48", @"Темный", nil];
    
    for (int i = 0; i < arrayTitles.count; i ++) {
        TextDataProfession * textDataProfession = [[TextDataProfession alloc] initWithHeight:self.maxHeightVideo + 26.f + 25 * i
                                                                           antFirstTextLabel:[arrayTitles objectAtIndex:i]
                                                                          andSecondTextLabel:[arrayTextParams objectAtIndex:i]];
        [self.mainScrollView addSubview:textDataProfession];
    }
    
    //Отрисовка доп параметров-----------------------------
    BOOL isAddParams = YES; //Если ли доп параметры ?
    
    if (!isAddParams) {
        self.mainScrollView.contentSize = CGSizeMake(0, self.maxHeightVideo + 36.f + 25 * arrayTitles.count);
    } else {
        
        
        AddParamsProfession * addParamsView = [[AddParamsProfession alloc]
                                               initWithHeight:self.maxHeightVideo + 36.f + 25 * arrayTitles.count
                                               andText:@"Езжу на лыжах,хорошо стреляю из ружья, арбалета. Кручу сальто назад.Езжу на лыжах,хорошо стреляю из ружья, арбалета."];
        [self.mainScrollView addSubview:addParamsView];
        self.mainScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(addParamsView.frame));
        
        
        //Отрисовка тени-------------------------------------
        UIView * viewShadow = [[UIView alloc] initWithFrame:
                               CGRectMake(0, self.maxHeightVideo + 36.f + 25 * arrayTitles.count,
                                          CGRectGetWidth(self.view.bounds), 2)];
        viewShadow.backgroundColor = [UIColor whiteColor];
        viewShadow.layer.borderColor = [UIColor whiteColor].CGColor;
        viewShadow.layer.shadowRadius  = 1.5f;
        viewShadow.layer.shadowColor   = [UIColor blackColor].CGColor;
        viewShadow.layer.shadowOffset  = CGSizeMake(0.0f, 2.0f);
        viewShadow.layer.shadowOpacity = 0.7f;
        viewShadow.layer.masksToBounds = NO;

        [self.mainScrollView addSubview:viewShadow];
        
    }
}

#pragma mark - Actions

- (IBAction)actionButtonBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionButtonBookmark:(CustomButton*)sender {
    
    if (sender.isBool) {
        [sender setImage:[UIImage imageNamed:@"professionImageBookmarkOn"] forState:UIControlStateNormal];
        sender.isBool = NO;
    } else {
        [sender setImage:[UIImage imageNamed:@"professionImageBookmark"] forState:UIControlStateNormal];
        sender.isBool = YES;
    }
    
}

- (IBAction)actionButtonLike:(id)sender {
}

- (IBAction)actionButtomStar:(id)sender {
}
@end
