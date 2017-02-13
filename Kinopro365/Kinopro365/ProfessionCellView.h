//
//  ProfessionCellView.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 13.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfessionCellView : UIView

- (instancetype)initCellProfessionWithMainView: (UIView*) view andHeight: (CGFloat) height andOrignX: (CGFloat) orgnX
                                 andImageAvart: (NSString*) imageAvatar andNameText: (NSString*) name
                                andCountryText: (NSString*) country andAgeText: (NSString*) age
                                 andGrowthText: (NSString*) growth andStarsNumber: (NSString*) starsNumber
                                 andLikeNumber: (NSString*) likeNumber;

@end
