//
//  VideoDetailsView.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 2/7/17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <youtube-ios-player-helper/YTPlayerView.h>
#import <UIKit/UIKit.h>
#import "CustomButton.h"

@protocol VideoDetailsViewDelegate;


@interface VideoDetailsView : YTPlayerView

@property (strong, nonatomic) UIImageView * imageViewDelete;
@property (strong, nonatomic) NSString * stringID;
@property (weak, nonatomic) id <VideoDetailsViewDelegate> delegateView;
@property (strong,nonatomic) CustomButton * button;

- (instancetype)initWithCustonFrame: (CGRect) frame andID: (NSString*) stringID andURL: (NSString*) url;

@end

@protocol VideoDetailsViewDelegate <NSObject>

- (void) actionButton: (VideoDetailsView*) videoDetailsView andButton: (CustomButton*) button;
- (void) desableActivityIndicator;

@end


