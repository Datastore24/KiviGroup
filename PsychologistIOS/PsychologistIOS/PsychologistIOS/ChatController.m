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

@interface ChatController ()
{
    BOOL _played;
    NSString *_totalTime;
    NSDateFormatter *_dateFormatter;
    NSDictionary * dictResponse;
}

@property (nonatomic ,strong) AVPlayer *player;
@property (nonatomic ,strong) AVPlayerItem *playerItem;
@property (weak, nonatomic) IBOutlet PlayerView *playerView;

@property (nonatomic ,strong) UIButton *stateButton;
@property (nonatomic ,strong) UILabel *timeLabel;
@property (nonatomic ,strong) id playbackTimeObserver;
@property (nonatomic ,strong) UISlider *videoSlider;
@property (nonatomic ,strong) UIProgressView *videoProgress;

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
    
#pragma mark - VideoElements
    
    [self getAPIWithBlock:^{
        
        NSLog(@"%@", dictResponse);
        
        
        NSURL *videoUrl = [NSURL URLWithString:@"http://mirror.cessen.com/blender.org/peach/trailer/trailer_iphone.m4v"];
        self.playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
        [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
        self.playerView.player = _player;
        self.playerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 140);
        if (isiPhone5) {
            self.playerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 90);
        }
        
        
        if ([[dictResponse objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary * mainDict = [dictResponse objectForKey:@"data"];
            [[SingleTone sharedManager] setPostID:[mainDict objectForKey:@"id"]];
            //Основной контент-----------------------------------------
            ChatView * openDetailsView = [[ChatView alloc] initWithView:self.view andDict:mainDict];
            [self.view addSubview:openDetailsView];
        } else {
            NSLog(@"Не дикшенери");
        }
        
        NSString * stringText = @"У вас 5 новых уведомлений в разделе";
        NSString * stringTitle = @"\"Женские секреты\"";
        
        ViewNotification * viewNotification = [[ViewNotification alloc] initWithView:self.view andIDDel:self andTitleLabel:stringTitle andText:stringText];
        [self.view addSubview:viewNotification];
        
        self.stateButton.enabled = NO;
        self.stateButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.stateButton.frame = CGRectMake(5, self.playerView.frame.size.height + 10, 50, 20);
        [self.stateButton setTitle:@"Play" forState:UIControlStateNormal];
        [self.stateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.stateButton addTarget:self action:@selector(stateButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.stateButton];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.playerView.frame.size.width - 70, self.playerView.frame.size.height + 10, 70, 20)];
        self.timeLabel.text = @"Time";
        self.timeLabel.font = [UIFont fontWithName:FONTREGULAR size:10];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:self.timeLabel];
        
        self.videoProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(self.stateButton.frame.size.width + 5, self.playerView.frame.size.height + 20, 200, 20)];
        self.videoProgress.progressTintColor = [UIColor blackColor];
        [self.view addSubview:self.videoProgress];
        
        self.videoSlider = [[UISlider alloc] initWithFrame:CGRectMake(self.stateButton.frame.size.width + 5, self.playerView.frame.size.height + 11.2, 200, 20)];
        [self.videoSlider addTarget:self action:@selector(videoSliderAction:) forControlEvents:UIControlEventValueChanged];
        [self.videoSlider addTarget:self action:@selector(videoSliderActionAnd:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:self.videoSlider];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
        
    }];
    
}

- (void) pushNotificationWithNotification
{
    NotificationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationController"];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - DEALLOC

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    [self.playerView.player removeTimeObserver:self.playbackTimeObserver];
}

#pragma mark - ACTION METHODS

//Метод нотификации о выборе картинки--------------------------
- (void) notifictionActionChooseImage
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        picker.allowsEditing = NO;
        [self presentViewController:picker animated:true completion:nil];
        
    }
    
}

// IMAGE PICKER DELEGATE =================
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SEND_IMAGE_FOR_CHAT_VIEW object:image];
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - VideoAction

- (void)monitoringPlayback:(AVPlayerItem *)playerItem {
    
    __weak typeof(self) weakSelf = self;
    self.playbackTimeObserver = [self.playerView.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        CGFloat currentSecond = playerItem.currentTime.value/playerItem.currentTime.timescale;// 计算当前在第几秒
        [weakSelf.videoSlider setValue:currentSecond animated:YES];
        NSString *timeString = [self convertTime:currentSecond];
        weakSelf.timeLabel.text = [NSString stringWithFormat:@"%@/%@",timeString,_totalTime];
    }];
}

// KVO方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
//            NSLog(@"AVPlayerStatusReadyToPlay");
            self.stateButton.enabled = YES;
            CMTime duration = self.playerItem.duration;// 获取视频总长度
            CGFloat totalSecond = playerItem.duration.value / playerItem.duration.timescale;// 转换成秒
            _totalTime = [self convertTime:totalSecond];// 转换成播放时间
            [self customVideoSlider:duration];// 自定义UISlider外观
//            NSLog(@"movie total duration:%f",CMTimeGetSeconds(duration));
            [self monitoringPlayback:self.playerItem];// 监听播放状态
        } else if ([playerItem status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
//        NSLog(@"Time Interval:%f",timeInterval);
        CMTime duration = _playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        [self.videoProgress setProgress:timeInterval / totalDuration animated:YES];
    }
}

- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[self.playerView.player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

- (void)customVideoSlider:(CMTime)duration {
    self.videoSlider.maximumValue = CMTimeGetSeconds(duration);
    UIGraphicsBeginImageContextWithOptions((CGSize){ 1, 1 }, NO, 0.0f);
    UIImage *transparentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.videoSlider setMinimumTrackImage:transparentImage forState:UIControlStateNormal];
    [self.videoSlider setMaximumTrackImage:transparentImage forState:UIControlStateNormal];
}

- (void) stateButtonAction {
    if (!_played) {
        [self.playerView.player play];
        [self.stateButton setTitle:@"Stop" forState:UIControlStateNormal];
    } else {
        [self.playerView.player pause];
        [self.stateButton setTitle:@"Play" forState:UIControlStateNormal];
    }
    _played = !_played;
}

- (void) videoSliderAction:(id)sender {
    UISlider *slider = (UISlider *)sender;
//    NSLog(@"value change:%f",slider.value);
    
    if (slider.value == 0.000000) {
        __weak typeof(self) weakSelf = self;
        [self.playerView.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
            [weakSelf.playerView.player play];
        }];
    }
}

- (void) videoSliderActionAnd:(id)sender {
    UISlider *slider = (UISlider *)sender;
//    NSLog(@"value end:%f",slider.value);
    CMTime changedTime = CMTimeMakeWithSeconds(slider.value, 1);
    
    __weak typeof(self) weakSelf = self;
    [self.playerView.player seekToTime:changedTime completionHandler:^(BOOL finished) {
        [weakSelf.playerView.player play];
        [weakSelf.stateButton setTitle:@"Stop" forState:UIControlStateNormal];
    }];
}

- (void)updateVideoSlider:(CGFloat)currentSecond {
    [self.videoSlider setValue:currentSecond animated:YES];
}


- (void)moviePlayDidEnd:(NSNotification *)notification {
//    NSLog(@"Play end");
    
    __weak typeof(self) weakSelf = self;
    [self.playerView.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        [weakSelf.videoSlider setValue:0.0 animated:YES];
        [weakSelf.stateButton setTitle:@"Play" forState:UIControlStateNormal];
    }];
}

- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    if (second/3600 >= 1) {
        [[self dateFormatter] setDateFormat:@"HH:mm:ss"];
    } else {
        [[self dateFormatter] setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [[self dateFormatter] stringFromDate:d];
    return showtimeNew;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}


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



@end
