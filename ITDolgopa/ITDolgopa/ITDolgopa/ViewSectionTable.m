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
        self.frame = CGRectMake(view.frame.origin.x - 60, view.frame.origin.y - 5, 40, 40);
        self.layer.cornerRadius = 20.0;
//        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//        self.layer.shadowOffset = CGSizeMake(3, 3);
//        self.layer.shadowOpacity = 1;
//        self.layer.shadowRadius = 1.0;
        self.clipsToBounds = NO;
        
                __block UIImageView * imageViewChat = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
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
        
                                            [UIView transitionWithView:imageViewChat duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                                                imageViewChat.image = image;
                                                imageViewChat.contentMode=UIViewContentModeScaleAspectFill;
                                                imageViewChat.layer.cornerRadius = 20.0;
                                                imageViewChat.layer.masksToBounds = YES;
//                                                imageViewChat.layer.borderColor = [UIColor whiteColor].CGColor;
//                                                imageViewChat.layer.borderWidth = 3.0;
                                            } completion:nil];
                                        }
                                    }];
                [self addSubview:imageViewChat];
    }
    return self;
}

@end
