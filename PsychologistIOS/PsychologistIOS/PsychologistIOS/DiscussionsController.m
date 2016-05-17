//
//  DiscussionsController.m
//  PsychologistIOS
//
//  Created by Viktor on 07.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "DiscussionsController.h"
#import "TitleClass.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "DiscussionsView.h"
#import "OpenSubjectModel.h"
#import <AVFoundation/AVFoundation.h>
#import "APIGetClass.h"
#import "SingleTone.h"

@interface DiscussionsController () <AVAudioSessionDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@end

@implementation DiscussionsController
{
    NSURL *temporaryRecFile;
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
    NSData *audioData;
    NSDictionary * dictResponse;
    NSString * myURL;
    
    NSDictionary * dictResponseMessage;
}

- (void) viewDidLoad
{
#pragma mark - Header
    
    NSLog(@"userID %@", [[SingleTone sharedManager] userID]);
    NSLog(@"postID %@", [[SingleTone sharedManager] postID]);
    
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"ОБСУЖДЕНИЯ"];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"d46559"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
#pragma mark - Initialization
    
    [super viewDidLoad];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
    [recorder setDelegate:self];
    
    [self getAPIMessageWithBlock:^{
        if ([[dictResponseMessage objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
            NSArray * arrayMainResponce = [NSArray arrayWithArray:[dictResponseMessage objectForKey:@"data"]];
            NSLog(@"arrayMainResponce %@", arrayMainResponce);
            //Загрузка контента вью для контроллера---------------------
            DiscussionsView * contentDiscussions = [[DiscussionsView alloc] initWithView:self.view andArray:arrayMainResponce];
            [self.view addSubview:contentDiscussions];
        }
    }];
    

    
    //Диктофон--------------------------------------------------
    
    //Получаем нотификацию из вью о загрузке галереи------------
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifictionActionChooseImage) name:NOTIFICATION_REQUEST_IMAGE_FOR_DUSCUSSIONS object:nil];
    
    //Нотификации записи микрофона------------------------------
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startRecord) name:NOTIFICATION_AUDIO_START_RECORD object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopRecord) name:NOTIFICATION_AUDIO_STOP_RECORD object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postAudio) name:NOTIFICATION_AUDIO_POST object:nil];
    
    
}

- (void) startRecord
{
    NSError *error;
    // Recording settings
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    [settings setValue: [NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [settings setValue: [NSNumber numberWithFloat:8000.0] forKey:AVSampleRateKey];
    [settings setValue: [NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];
    [settings setValue: [NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [settings setValue: [NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    [settings setValue: [NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    [settings setValue:  [NSNumber numberWithInt: AVAudioQualityMax] forKey:AVEncoderAudioQualityKey];
    NSArray *searchPaths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath_ = [searchPaths objectAtIndex: 0];
    NSString *pathToSave = [documentPath_ stringByAppendingPathComponent:[self dateString]];
    // File URL
    NSURL *url = [NSURL fileURLWithPath:pathToSave];//FILEPATH];
    //Save recording path to preferences
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setURL:url forKey:@"Test1"];
    [prefs synchronize];
    
    
    // Create recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    [recorder prepareToRecord];
    [recorder record];
    
 
}

- (void) stopRecord
{
    [recorder stop];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    temporaryRecFile = [prefs URLForKey:@"Test1"];
}

- (void) postAudio
{
    [self getAPIWithBlock];
}

- (NSString *) dateString
{
    // return a formatted string for a file name
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"ddMMMYY_hhmmssa";
    return [[formatter stringFromDate:[NSDate date]] stringByAppendingString:@".aif"];
}

#pragma mark - DEALLOC

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SEND_IMAGE_FOR_DUSCUSSIONS_VIEW object:image];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void) getAPIWithBlock
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys: @"audio", @"type", nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithAudioParams:params andAudioURL:temporaryRecFile method:@"upload_media" complitionBlock:^(id response) {
        dictResponse = (NSDictionary*) response;
        NSLog(@"%@", response);
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            
            NSLog(@"Удачная отправка");
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"proverkaPeredachiZvuka" object:[dictResponse objectForKey:@"url"]];

        }
    }];
}

#pragma mark - API
- (void) getAPIMessageWithBlock: (void (^)(void))block
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             [[SingleTone sharedManager]postID], @"id_post",
                             [[SingleTone sharedManager]userID], @"id_user",nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"chat_show_message" complitionBlock:^(id response) {
        
        dictResponseMessage = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            block();
        }
    }];
}


@end
