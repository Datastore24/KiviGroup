//
//  ChatCellView.m
//  ITDolgopa
//
//  Created by Viktor on 26.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "ChatCellView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@implementation ChatCellView
{
    UILabel * testLabel;
}

- (instancetype)initWhithFirstView: (UIView*) view
                      andDate: (NSString*) date
                andImagePhoto: (NSString*) imagePhoto
                     andFrame: (CGRect) frame
{
    self = [super init];
    if (self) {
        self.frame = frame;
        
    }
    return self;
}

@end
