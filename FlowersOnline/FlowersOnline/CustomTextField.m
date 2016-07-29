//
//  CustomTextField.m
//  FlowersOnline
//
//  Created by Viktor on 02.05.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "CustomTextField.h"

@interface CustomTextField ()

@end

@implementation CustomTextField

- (instancetype)initWithCustomFrame: (CGRect) frame andText: (NSString*) text typeKeyBoardType: (UIKeyboardType) keyboard
{
    self = [super init];
    if (self) {
        self.frame = frame;
        self.text = text;
        self.keyboardType = keyboard;
        if (self.text.length != 0) {
        }
    }
    return self;
}

@end
