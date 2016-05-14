//
//  VkontakteDelegate.h
//  PsychologistIOS
//
//  Created by Viktor on 13.05.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VkontakteDelegate : NSObject


@property NSString *username, *realName, *ID, *link, *email, *access_token;
@property UIImage* photo;

+ (id)sharedInstance;
-(void) loginWithParams: (NSMutableDictionary*) params;
-(void) postToWall;

@end
