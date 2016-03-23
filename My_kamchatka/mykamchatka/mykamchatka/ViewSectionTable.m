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


@implementation ViewSectionTable

- (instancetype)initWithImageURL: (NSString*) imageUrl andView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 180, 180);
        self.layer.cornerRadius = 5.0;
        self.clipsToBounds = NO;
        
                __block UIImageView * imageViewChat = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180, 180)];
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
                                                imageViewChat.contentMode=UIViewContentModeScaleAspectFill;
                                                imageViewChat.layer.cornerRadius = 5.0;
                                                imageViewChat.layer.masksToBounds = YES;
                                            } completion:nil];
                                        }
                                    }];
                [self addSubview:imageViewChat];
    }
    return self;
}

- (instancetype)initSharesWithImageURL: (NSString*) imageUrl andView: (UIView*) view
{
    self = [super init];
    if (self) {
                self.frame = CGRectMake(0, 0, 250, 250);
                self.layer.cornerRadius = 30.0;
                self.clipsToBounds = NO;
                
                __block UIImageView * imageViewShares = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
                //imageView.center = CGPointMake(cell.center.x, cell.center.y);
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
                                            
                                            [UIView transitionWithView:imageViewShares duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                                                imageViewShares.image = image;
                                                imageViewShares.contentMode=UIViewContentModeScaleAspectFill;
                                                imageViewShares.layer.cornerRadius = 30.0;
                                                imageViewShares.layer.masksToBounds = YES;

                                            } completion:nil];
                                        }
                                    }];
        
        imageViewShares.backgroundColor = [UIColor whiteColor];
                [self addSubview:imageViewShares];
    }
    return self;
}

@end
