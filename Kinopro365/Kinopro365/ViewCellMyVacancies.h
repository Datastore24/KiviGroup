//
//  ViewCellMyVacancies.h
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 06.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

@protocol ViewCellMyVacanciesDelegate;

@interface ViewCellMyVacancies : UIView

@property (strong, nonatomic) UILabel * numberRewar;
@property (strong, nonatomic) UILabel * numberLike;
@property (weak, nonatomic) id <ViewCellMyVacanciesDelegate> delegate;

- (instancetype)initWithMainView: (UIView*) mainView endHeight: (CGFloat) height endImageName: (NSString*) imageUrl endName: (NSString*) name
                      endCountry: (NSString*) country endAge: (NSString*) age endIsReward: (BOOL) isReward endRewardNumber: (NSString*) rewardNumber
                       endIsLike: (BOOL) isLike endLikeNumber: (NSString*) likeNumber endIsBookmark: (BOOL) isBookmark endPhoneOne: (NSString*) phoneOne
                     endPhoneTwo: (NSString*) phoneTwo endEmail: (NSString*) email endProfileID: (NSString*) profileID;

@end

@protocol ViewCellMyVacanciesDelegate <NSObject>

- (void) actionWith: (ViewCellMyVacancies*) viewCellMyVacancies endButtonImage: (CustomButton*) sender;

- (void) actionWith: (ViewCellMyVacancies*) viewCellMyVacancies endButtonReward: (CustomButton*) sender;

- (void) actionWith: (ViewCellMyVacancies*) viewCellMyVacancies endButtonLike: (CustomButton*) sender;

- (void) actionWith: (ViewCellMyVacancies*) viewCellMyVacancies endButtonBookmark: (CustomButton*) sender;

- (void) actionWith: (ViewCellMyVacancies*) viewCellMyVacancies endButtonPhoneOne: (CustomButton*) sender;

- (void) actionWith: (ViewCellMyVacancies*) viewCellMyVacancies endButtonPhoneTwo: (CustomButton*) sender;

- (void) actionWith: (ViewCellMyVacancies*) viewCellMyVacancies endButtonEmail: (CustomButton*) sender;
@end
