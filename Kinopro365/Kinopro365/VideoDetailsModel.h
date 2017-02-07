//
//  VideoDetailsModel.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 2/6/17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIManger.h"
#import "SingleTone.h"

@protocol VideoDetailsModelDelegate <NSObject>

@required

- (void) loadVideo: (NSArray *) array;
- (void) desableActivityIndicator;
- (void) loadViewCustom;

@end

@interface VideoDetailsModel : NSObject

@property (assign, nonatomic) id <VideoDetailsModelDelegate> delegate;

- (void) getVideoArrayWithOffset: (NSString *) offset andCount: (NSString *) count;
- (void) deleteVideos:(NSMutableArray *) arrayView;

@end
