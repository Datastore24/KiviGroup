//
//  PhotoDetailView.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 2/6/17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

@protocol PhotoDetailViewDelegate;

@interface PhotoDetailView : UIView

@property (weak, nonatomic) id <PhotoDetailViewDelegate> delegate;
@property (strong, nonatomic) UIImageView * imageViewDelete;
@property (strong, nonatomic) NSString * stringID;

@property (strong, nonatomic) UIImageView * imageView;

- (instancetype)initWithImage: (NSString*) image andID: (NSString*) id andFrame: (CGRect) frame;
- (instancetype)initWithCustomFrame:(CGRect)frame;


@end

@protocol PhotoDetailViewDelegate <NSObject>

- (void) actionView: (PhotoDetailView*) photoDetailView withButton: (CustomButton*) sender;

@end


