//
//  VideoView.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 15.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "VideoView.h"
#import "HexColors.h"
#import "Macros.h"
#import "MainViewController.h"

@interface VideoView() <YTPlayerViewDelegate>

@end

@implementation VideoView
@synthesize delegate;
- (instancetype)initCustonButtonAccessVideo {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(13.f, 269.f, 296, 123);
        self.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"E6F3FB"];
        self.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"3F658D"].CGColor;
        self.layer.borderWidth = 2.f;
        self.layer.cornerRadius = 5.f;
        
        UIImageView * imageViewPlay = [[UIImageView alloc] initWithFrame:CGRectMake(131.f, 15.f, 32.f, 42.f)];
        imageViewPlay.image = [UIImage imageNamed:@"imageButtonPlay"];
        [self addSubview:imageViewPlay];
        
        UILabel * labeltext = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 66, CGRectGetWidth(self.bounds), 46.f)];
        labeltext.text = @"ВИДЕО БУДЕТ ДОСТУПНО\nПОСЛЕ ОТКРЫТИЯ КОНТАКТОВ";
        labeltext.numberOfLines = 2;
        labeltext.textColor = [UIColor hx_colorWithHexRGBAString:@"5581A8"];
        labeltext.textAlignment = NSTextAlignmentCenter;
        labeltext.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:16];
        [self addSubview:labeltext];
        
    }
    return self;
}

- (instancetype)initWithHeight: (CGFloat) height andURLVideo: (NSString*) urlVideo lastObject:(BOOL) lastObject
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(13.f, height, 296, 123);
        self.backgroundColor = [UIColor lightGrayColor];
        
        
        YTPlayerView * playerView = [[YTPlayerView alloc] initWithFrame:self.bounds];
        [playerView loadWithVideoId:[self createIDYouTubeWithURL:urlVideo]];
        playerView.delegate = self;
        if(lastObject){
            playerView.tag = 5000;
        }
        [self addSubview:playerView];
        
    }
    return self;
}

#pragma mark - Other

- (NSString*) createIDYouTubeWithURL: (NSString*) url {
    
    NSString* str= url;
    NSString *stringWithoutSpaces = [str
                                     stringByReplacingOccurrencesOfString:@"https://www.youtube.com/embed/" withString:@""];
    stringWithoutSpaces = [stringWithoutSpaces
                                     stringByReplacingOccurrencesOfString:@"https://m.youtube.com/watch?v=" withString:@""];
    
//    NSRange range= [str rangeOfString: @"https://www.youtube.com/embed/" options: NSBackwardsSearch];
//    NSString* finalStr = [str substringFromIndex: range.location + range.length];
    
    return stringWithoutSpaces;
}

#pragma mark - YTPlayerViewDelegate

- (void)playerViewDidBecomeReady:(nonnull YTPlayerView *)playerView{
    if(playerView.tag == 5000){
        NSLog(@"REDYPL");
        [self.delegate deleteActivitiIndicatorDelegate];
    }
    
}

@end
