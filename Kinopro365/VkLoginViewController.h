//
//  VkLoginViewController.h
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 21.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VkLoginViewController : UIViewController <UIWebViewDelegate> {
    
    id delegate;
    UIWebView *vkWebView;
    NSString *appID;
    
}
@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) UIWebView *vkWebView;
@property (nonatomic, retain) NSString *appID;

- (NSString*)stringBetweenString:(NSString*)start
                       andString:(NSString*)end
                     innerString:(NSString*)str;

@end
