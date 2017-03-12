//
//  PhotoDetailView.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 2/6/17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "PhotoDetailView.h"


@implementation PhotoDetailView


- (instancetype)initWithImage: (NSString*) image andID: (NSString*) stringID andFrame: (CGRect) frame
{
    self = [super init];
    if (self) {
        self.frame = frame;
        
        
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: image]];
        UIImage * image = [UIImage imageWithData: imageData];
        
        self.buttonPhoto = [CustomButton buttonWithType:UIButtonTypeCustom];
        self.buttonPhoto.frame = self.bounds;
        [self.buttonPhoto setImage:image forState:UIControlStateNormal];
        self.buttonPhoto.isBool = NO;
        [self.buttonPhoto addTarget:self action:@selector(actionButtonPhoto:) forControlEvents:UIControlEventTouchUpInside];
        self.buttonPhoto.backgroundColor = [UIColor blueColor];
        [self addSubview:self.buttonPhoto];
        
        self.stringID = stringID;
        
        self.imageViewDelete = [[UIImageView alloc] initWithFrame:
                                CGRectMake(self.bounds.size.width - 30,
                                           self.bounds.size.height - 30, 25, 25)];
        self.imageViewDelete.image = [UIImage imageNamed:@"dell"];
        self.imageViewDelete.alpha = 0.f;
        [self addSubview:self.imageViewDelete];
        
    }
    return self;
}




- (instancetype)initWithCustomFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.frame = frame;
        
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imageView];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.frame.size.width - 40, 10, 30, 30);
        [button setImage:[UIImage imageNamed:@"ImageCancelNew"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
    return self;
}

#pragma mark - Actions

- (void) actionButtonPhoto: (CustomButton*) sender {
    
    [self.delegate actionView:self withButton:sender];
    
}

- (void) actionButton: (UIButton*) sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.f;
    }];
}

@end
