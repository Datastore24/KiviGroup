//
//  VideoView.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 15.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <youtube-ios-player-helper/YTPlayerView.h>

@interface VideoView : UIView

- (instancetype)initCustonButtonAccessVideo;
- (instancetype)initWithHeight: (CGFloat) height andURLVideo: (NSString*) urlVideo;

@end
