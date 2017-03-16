//
//  PhotoView.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 15.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoViewDelegate;

@interface PhotoView : UIView

@property (weak,nonatomic) id <PhotoViewDelegate> delegate;
@property (assign, nonatomic) NSInteger customTag;
@property (strong, nonatomic) UIButton * buttonImage;


- (instancetype)initWithFrame:(CGRect)frame andWithImageButton: (NSString*) imageButton endTag: (NSInteger) customtag;

@end

@protocol PhotoViewDelegate <NSObject>

- (void) actionCell: (PhotoView*) photoView withImageButton: (UIButton*) imageButton;
- (void) loadImage: (PhotoView*) photoView endImage: (UIImage*) image;

@end
