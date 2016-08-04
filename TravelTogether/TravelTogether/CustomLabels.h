//
//  CustomLabels.h
//  FlowersOnline
//
//  Created by Виктор Мишустин on 10.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomLabels : UILabel

- (instancetype)initLabelWithWidht: (CGFloat) widht
                             andHeight: (CGFloat) height
                              andColor: (NSString*) hexColor
                               andText: (NSString*) text
                           andTextSize: (NSInteger) textSize
                        andLineSpacing: (CGFloat) lineSpacing
                              fontName: (NSString*) font;

- (instancetype)initLabelTableWithWidht: (CGFloat) widht
                              andHeight: (CGFloat) height
                           andSizeWidht: (CGFloat) sizeWidht
                          andSizeHeight: (CGFloat) sizeHeight
                               andColor: (NSString*) hexColor
                                andText: (NSString*) text;

+ (UILabel*) labelWithWidht: (CGFloat) widht
                  andHeight: (CGFloat) height
                   andColor: (NSString*) hexColor
                    andText: (NSString*) text
                andTextSize: (NSInteger) textSize
             andLineSpacing: (CGFloat) lineSpacing
                   fontName: (NSString*) font;



@end
