//
//  ChatViewPush.m
//  ITDolgopa
//
//  Created by Viktor on 25.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "ChatViewPush.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@interface ChatViewPush()

@end

@implementation ChatViewPush
{
    UIButton * sendButton;
    UILabel * labelPlaceHolder;
    
}

- (instancetype)initWhithView: (UIView*) view andFrame: (CGRect) frame
{
    self = [super init];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor colorWithHexString:MAINBACKGROUNDCOLOR];
        
        UIView * viewFone = [[UIView alloc] initWithFrame:CGRectMake(30, 20, self.frame.size.width - 60, 40)];
        viewFone.backgroundColor = [UIColor whiteColor];
        viewFone.layer.cornerRadius = 20.f;
        [self addSubview:viewFone];
        
        sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sendButton.frame = CGRectMake(viewFone.frame.size.width - 40, 2, 36, 36);
        sendButton.layer.cornerRadius = 18;
        sendButton.backgroundColor = [UIColor redColor];
        [sendButton addTarget:self action:@selector(tuchGreen) forControlEvents:UIControlEventTouchDown];
        [sendButton addTarget:self action:@selector(tuchRead) forControlEvents:UIControlEventTouchUpInside];
        [sendButton addTarget:self action:@selector(tuchRead) forControlEvents:UIControlEventTouchDragOutside];
        [viewFone addSubview:sendButton];
        
        labelPlaceHolder = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, viewFone.frame.size.width - 70, 40)];
        labelPlaceHolder.text = @"Введите сообщение...";
        labelPlaceHolder.font = [UIFont fontWithName:FONTLITE size:12];
        labelPlaceHolder.tag = 502;
        [viewFone addSubview:labelPlaceHolder];
        
        UITextField * textFildText = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, viewFone.frame.size.width - 70, 40)];
        textFildText.font = [UIFont fontWithName:FONTLITE size:12];
        textFildText.tag = 501;
        [viewFone addSubview:textFildText];
        
        
    }
    return self;
}

#pragma mark - Buttons Methods

- (void) tuchGreen
{
    [UIView animateWithDuration:0.2 animations:^{
        sendButton.backgroundColor = [UIColor greenColor];
    }];
}

- (void) tuchRead
{
    [UIView animateWithDuration:0.2 animations:^{
        sendButton.backgroundColor = [UIColor redColor];
    }];
}

@end
