//
//  VideoDetailsView.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 2/7/17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "VideoDetailsView.h"

@implementation VideoDetailsView

- (instancetype)initWithCustonFrame: (CGRect) frame andID: (NSString*) stringID andURL: (NSString*) url
{
    self = [super init];
    if (self) {
        self.frame = frame;
        [self loadWithVideoId:[self createIDYouTubeWithURL:url]];
        
        self.stringID = stringID;
        
        CustomButton * button = [CustomButton buttonWithType:UIButtonTypeSystem];
        button.frame = self.bounds;
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        self.imageViewDelete = [[UIImageView alloc] initWithFrame:
                                CGRectMake(self.bounds.size.width - 30,
                                           self.bounds.size.height - 30, 25, 25)];
        self.imageViewDelete.image = [UIImage imageNamed:@"dell"];
        self.imageViewDelete.alpha = 0.f;
        [self addSubview:self.imageViewDelete];
        
        

    }
    return self;
}

#pragma mark - Actions

- (void) actionButton: (CustomButton*) sender {
    [self.delegateView actionButton:self andButton:sender];
}

#pragma mark - Other 

- (NSString*) createIDYouTubeWithURL: (NSString*) url {
    
    NSString* str= url;
    NSRange range= [str rangeOfString: @"watch?v=" options: NSBackwardsSearch];
    NSString* finalStr = [str substringFromIndex: range.location + range.length];
    
    return finalStr;
    
    
    
}



@end
