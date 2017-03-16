//
//  PhotoView.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 15.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "PhotoView.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения

@implementation PhotoView

- (instancetype)initWithFrame:(CGRect)frame andWithImageButton: (NSString*) imageButton endTag: (NSInteger) customtag {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView * viewShadow = [[UIView alloc] initWithFrame:self.bounds];
        viewShadow.backgroundColor = [UIColor groupTableViewBackgroundColor];
        viewShadow.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        [viewShadow.layer setShadowOffset:CGSizeMake(0, 3)];
        [viewShadow.layer setShadowOpacity:0.7];
        [viewShadow.layer setShadowRadius:2.0f];
        [viewShadow.layer setShouldRasterize:YES];
        
        [viewShadow.layer setCornerRadius:5.0f];
        
        [self addSubview:viewShadow];
        
        self.customTag = customtag;
        
        self.buttonImage = [UIButton buttonWithType:UIButtonTypeCustom];
        self.buttonImage.frame = self.bounds;
       
        
        NSURL *imgURL = [NSURL URLWithString:imageButton];
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:imgURL
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 // progression tracking code
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished,
                                        NSURL *imageURL) {
                                
                                if(image){
                                    [[self.buttonImage imageView]
                                     setContentMode:UIViewContentModeScaleAspectFill];
                                    [[self.buttonImage imageView] setClipsToBounds:YES];
                                    [[[self.buttonImage imageView] layer] setCornerRadius:5.f];
                                    
                                    [self.buttonImage setImage:image forState:UIControlStateNormal];
                                    
                                    
                                    
                                }else{
                                    //Тут обработка ошибки загрузки изображения
                                }
                                [self.delegate loadImage:self endImage:image];
                            }];
        [self.buttonImage addTarget:self action:@selector(actionButtonImage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.buttonImage];
        
        
    }
    return self;
}

#pragma mark - Actions

- (void) actionButtonImage: (UIButton*) sender {
    
    [self.delegate actionCell:self withImageButton:sender];
    
}

@end
