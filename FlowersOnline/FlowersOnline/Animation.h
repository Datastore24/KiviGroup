//
//  Animation.h
//  Lesson1
//
//  Created by Viktor on 12.09.15.
//  Copyright (c) 2015 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Animation : NSObject

+ (void) anitetionView: (UIView *) view withColor: (UIColor*) color;

+ (void) animateTextInLabel: (UILabel *) label withText: (NSString* ) text;

+ (void) animateFrameView: (UIView*) view withFrame: (CGRect) rect;

+ (void)animateTransformView:(UIView*)view withScale:(CGFloat)scale move_X:(CGFloat)moveX move_Y:(CGFloat)moveY alpha:(CGFloat)alpha delay:(CGFloat)delay andBlock: (void(^)(void)) block;

+ (void) animationImageView: (UIImageView*) imageView image: (UIImage*) image;



+ (void) animationTestView:(UIView*)view move_Y: (CGFloat)moveY andBlock: (void (^) (void)) block;
+ (void) animatioMoveXWithView:(UIView*)view move_X: (CGFloat)moveX andBlock: (void (^) (void)) block;

@end
