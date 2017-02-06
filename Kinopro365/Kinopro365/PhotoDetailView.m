//
//  PhotoDetailView.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 2/6/17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "PhotoDetailView.h"


@implementation PhotoDetailView


- (instancetype)initWithImage: (UIImage*) image andFrame: (CGRect) frame
{
    self = [super init];
    if (self) {
        self.frame = frame;
        CustomButton * buttonPhoto = [CustomButton buttonWithType:UIButtonTypeCustom];
        buttonPhoto.frame = self.bounds;
        [buttonPhoto setImage:image forState:UIControlStateNormal];
        buttonPhoto.isBool = NO;
        [buttonPhoto addTarget:self action:@selector(actionButtonPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonPhoto];
        
        self.imageViewDelete = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 30, self.bounds.size.height - 30, 25, 25)];
        self.imageViewDelete.image = [UIImage imageNamed:@"mark"];
        self.imageViewDelete.alpha = 0.f;
        [self addSubview:self.imageViewDelete];
        
    }
    return self;
}

#pragma mark - Actions

- (void) actionButtonPhoto: (CustomButton*) sender {
    
    [self.delegate actionView:self withButton:sender];
    
}

@end
