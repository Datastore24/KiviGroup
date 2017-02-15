//
//  PhotoView.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 15.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "PhotoView.h"

@implementation PhotoView

- (instancetype)initWithFrame:(CGRect)frame andWithImageButton: (NSString*) imageButton {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton * buttonImage = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonImage.frame = self.bounds;
        [buttonImage setImage:[UIImage imageNamed:imageButton] forState:UIControlStateNormal];
        [buttonImage addTarget:self action:@selector(actionButtonImage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonImage];
        
        
    }
    return self;
}

#pragma mark - Actions

- (void) actionButtonImage: (UIButton*) sender {
    
    NSLog(@"Hello");
    
}

@end
