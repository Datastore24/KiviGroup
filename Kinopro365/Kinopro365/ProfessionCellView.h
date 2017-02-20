//
//  ProfessionCellView.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 13.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

@protocol ProfessionCellViewDelegate;

@interface ProfessionCellView : UIView

@property (weak, nonatomic) id <ProfessionCellViewDelegate> deleagte;

- (instancetype)initCellProfessionWithMainView: (UIView*) view andHeight: (CGFloat) height andOrignX: (CGFloat) orgnX
                                 andImageAvart: (NSString*) imageAvatar andNameText: (NSString*) name
                                andCountryText: (NSString*) country andAgeText: (NSString*) age
                                 andGrowthText: (NSString*) growth andStarsNumber: (NSString*) starsNumber
                                 andLikeNumber: (NSString*) likeNumber
                                  andProfileID: (NSString *) profileID;

@end

@protocol ProfessionCellViewDelegate <NSObject>

- (void) actionBookMark: (ProfessionCellView*) professionCellView withButton: (CustomButton*) button;
- (void) actionButtonCell: (ProfessionCellView*) professionCellView withButton: (CustomButton*) button;

@end
