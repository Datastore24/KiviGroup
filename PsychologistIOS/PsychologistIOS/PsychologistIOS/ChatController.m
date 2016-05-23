//
//  ChatController.m
//  PsychologistIOS
//
//  Created by Viktor on 16.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "ChatController.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "TitleClass.h"
#import "ChatView.h"
#import "OpenSubjectModel.h"
#import <AVFoundation/AVFoundation.h>
#import "PlayerView.h"
#import "ViewNotification.h"
#import "NotificationController.h"
#import "ChatView.h"
#import "APIGetClass.h"
#import "SingleTone.h"
#import "DiscussionsController.h"
#import "StringImage.h"
#import "KrVideoPlayerController.h"
#import "ViewSectionTable.h"
#import "StringImage.h"


@interface ChatController ()
{
    NSDictionary * dictResponse;
}
@property (nonatomic, strong) KrVideoPlayerController  *videoController;

@end

@implementation ChatController

- (void) viewDidLoad
{
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = NO;
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"ВЕБИНАР"];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"d46559"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToChat) name:NOTIFICATION_SEND_AUDIO_FOR_CHAT object:nil];
    
    
    
#pragma mark - VideoElements
    
    [self getAPIWithBlock:^{
        
        if ([[dictResponse objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary * mainDict = [dictResponse objectForKey:@"data"];
            [[SingleTone sharedManager] setPostID:[mainDict objectForKey:@"id"]];
            //Основной контент-----------------------------------------
            ChatView * openDetailsView = [[ChatView alloc] initWithView:self.view andDict:mainDict];
            [self.view addSubview:openDetailsView];
            NSLog(@"%@", dictResponse);
        } else {
            NSLog(@"Не дикшенери");
        }
        NSDictionary * mainDictionary = [dictResponse objectForKey:@"data"];
        NSDictionary * dictMedia = [mainDictionary objectForKey:@"other_media"];
        NSString * stringURL = [StringImage createStringImageURLWithString:[dictMedia objectForKey:@"path"]];
        
        [self playVideoWithURL:stringURL];
        if ([[dictMedia objectForKey:@"type"] isEqualToString:@"audio"]) {
            [self.videoController fullScreenHide];
            ViewSectionTable * imagePost = [[ViewSectionTable alloc] initWithPostImageURL:[StringImage createStringImageURLWithString:[mainDictionary objectForKey:@"media_path"]] andView:self.view andContentMode:UIViewContentModeScaleAspectFill];
            [self.view addSubview:imagePost];
        }
        
    }];
    
}

- (void)playVideoWithURL: (NSString*) myURL {
    NSURL *url = [NSURL URLWithString:myURL];
    [self addVideoPlayerWithURL:url];
}

- (void)addVideoPlayerWithURL:(NSURL *)url{
    if (!self.videoController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.videoController = [[KrVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, width, 200)];
        if (isiPhone5) {
            self.videoController.frame = CGRectMake(0, 0, width, 150);
        }
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController setWillBackOrientationPortrait:^{
            [weakSelf toolbarHidden:NO];
        }];
        [self.videoController setWillChangeToFullscreenMode:^{
            [weakSelf toolbarHidden:YES];
        }];
        [self.view addSubview:self.videoController.view];
    }
    self.videoController.contentURL = url;
    
}
//隐藏navigation tabbar 电池栏
- (void)toolbarHidden:(BOOL)Bool{
    self.navigationController.navigationBar.hidden = Bool;
    self.tabBarController.tabBar.hidden = Bool;
    [[UIApplication sharedApplication] setStatusBarHidden:Bool withAnimation:UIStatusBarAnimationFade];
}

- (void) pushNotificationWithNotification
{
    NotificationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationController"];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - DEALLOC

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];;
}

#pragma mark - ACTION METHODS

#pragma mark - API

- (void) getAPIWithBlock: (void (^)(void))block
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:[[SingleTone sharedManager] identifierSubjectModel], @"id",  nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"show_post" complitionBlock:^(id response) {
        
        dictResponse = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            block();
        }
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) pushToChat
{
    DiscussionsController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"DiscussionsController"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController) {
        [self.videoController dismiss];
    }
}



@end
