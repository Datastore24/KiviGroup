//
//  UIImage+BagroungImage.m
//  Sadovod
//
//  Created by Виктор Мишустин on 30/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "UIImage+BagroungImage.h"

@implementation UIImage (BagroungImage)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
