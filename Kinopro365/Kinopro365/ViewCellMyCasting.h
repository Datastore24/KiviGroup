//
//  ViewCellMyCasting.h
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 08.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

@protocol ViewCellMyCastingDelegate;

@interface ViewCellMyCasting : UIView

@property (strong, nonatomic) UILabel * numberRewar;
@property (strong, nonatomic) UILabel * numberLike;
@property (weak, nonatomic) id <ViewCellMyCastingDelegate> delegate;

- (instancetype)initWithMainView: (UIView*) mainView endHeight: (CGFloat) height endImageName: (NSString*) imageUrl endName: (NSString*) name
                      endCountry: (NSString*) country endAge: (NSString*) age endIsReward: (BOOL) isReward endRewardNumber: (NSString*) rewardNumber
                       endIsLike: (BOOL) isLike endLikeNumber: (NSString*) likeNumber endIsBookmark: (BOOL) isBookmark
                    endProfileID: (NSString*) profileID enfGrowth: (NSString*) growth endApproved: (BOOL) approved;

@end

@protocol ViewCellMyCastingDelegate <NSObject>

- (void) actionWith: (ViewCellMyCasting*) viewCellMyCasting endButtonImage: (CustomButton*) sender;

- (void) actionWith: (ViewCellMyCasting*) viewCellMyCasting endButtonReward: (CustomButton*) sender;

- (void) actionWith: (ViewCellMyCasting*) viewCellMyCasting endButtonLike: (CustomButton*) sender;

- (void) actionWith: (ViewCellMyCasting*) viewCellMyCasting endButtonBookmark: (CustomButton*) sender;

- (void) actionWith: (ViewCellMyCasting*) viewCellMyCasting endButtonDelete: (CustomButton*) sender;

- (void) actionWith: (ViewCellMyCasting*) viewCellMyCasting endButtonConfirm: (CustomButton*) sender;




@end
