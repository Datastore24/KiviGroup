//
//  ViewSectionTable.m
//  Sadovod
//
//  Created by Viktor on 17.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

//Создание изображения товара

#import "ViewSectionTable.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения
#import "UIImage+Resize.h"//Ресайз изображения
#import "Macros.h"


@implementation ViewSectionTable

- (instancetype)initWithImageURL: (NSString*) imageUrl andView: (UIView*) view andContentMode: (UIViewContentMode) contentMode
{
    self = [super init];
    if (self) {
            self.frame = CGRectMake(0, 0, 96, 96);
        if (isiPhone6) {
            self.frame = CGRectMake(0, 0, 88, 88);
        } else if (isiPhone5) {
            self.frame = CGRectMake(0, 0, 78, 78);
        }
        

        self.clipsToBounds = NO;
        
        
                __block UIImageView * imageViewChat = [[UIImageView alloc] initWithFrame:CGRectMake(16, 0, 96, 96)];
        if (isiPhone6) {
            imageViewChat.frame = CGRectMake(0, 0, 88, 88);
        } else if (isiPhone5) {
            imageViewChat.frame = CGRectMake(0, 0, 78, 78);        }

                NSURL *imgURL = [NSURL URLWithString:imageUrl];
        
                //SingleTone с ресайз изображения
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                [manager downloadImageWithURL:imgURL
                                      options:0
                                     progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                         // progression tracking code
                                     }
                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                        if(image){
        
                                            [UIView transitionWithView:imageViewChat duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                                                imageViewChat.image = image;
                                                imageViewChat.contentMode=contentMode;
                                                imageViewChat.layer.masksToBounds = YES;
                                            } completion:nil];
                                        }
                                    }];
                [self addSubview:imageViewChat];
    }
    return self;
}

- (instancetype)initImageWithImageURL: (NSString*) imageURL
                          andMainView: (UIView*) view
                             andFrame: (CGRect) frame
{
    self = [super init];
    if (self) {
        self.frame = frame;
        
        __block UIImageView * imageViewChat = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
        NSURL *imgURL = [NSURL URLWithString:imageURL];
        
        //SingleTone с ресайз изображения
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:imgURL
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 // progression tracking code
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                if(image){
                                    
                                    [UIView transitionWithView:imageViewChat duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                                        imageViewChat.image = image;
                                        imageViewChat.layer.masksToBounds = YES;
                                    } completion:nil];
                                }
                            }];
        [self addSubview:imageViewChat];
    }
    return self;
}





@end
