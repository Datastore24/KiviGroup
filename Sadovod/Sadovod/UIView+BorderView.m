//
//  UIView+BorderView.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 02/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "UIView+BorderView.h"
#import "HexColors.h"

@implementation UIView (BorderView)

+ (void) borderViewWithHeight: (CGFloat) height
                    andWight: (CGFloat) wight
                         andView: (UIView*) view
                        andColor: (NSString*) color
{
    UIView * borderView = [[UIView alloc] initWithFrame: CGRectMake(wight, height, view.frame.size.width - wight * 2, 0.5f)];
     borderView.backgroundColor = [UIColor hx_colorWithHexRGBAString:color];
    [view addSubview:borderView];
    
}

+ (void) backgroundViewWithView: (UIView*) view
                      andImageName: (NSString*) imageName
{
    UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    UIImageView * backgroundImage = [[UIImageView alloc] initWithFrame:backgroundView.frame];
    backgroundImage.image = [UIImage imageNamed:imageName];
    [backgroundView addSubview:backgroundImage];
    [view addSubview:backgroundView];
}

@end
