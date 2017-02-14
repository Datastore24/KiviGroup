//
//  ViewForScroll.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 13.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewForScrollDelegate;

@interface ViewForScroll : UIView

@property (weak, nonatomic) id <ViewForScrollDelegate> delegate;
@property (strong, nonatomic) NSMutableArray * arayButtons;

- (instancetype)initWithCustonView: (UIView*) view andRect: (CGRect) frame andCountScrolls: (NSInteger) countScrolls;

@end

@protocol ViewForScrollDelegate <NSObject>

- (void) actionMoveLeftWithView: (ViewForScroll*) viewForScroll andButton: (UIButton*) sender
                andArrayButtons: (NSMutableArray*) arrayButtons;
- (void) actionMoveRightWithView: (ViewForScroll*) viewForScroll andButton: (UIButton*) sender
                 andArrayButtons: (NSMutableArray*) arrayButtons;
- (void) actionButtonLablCount: (ViewForScroll*) viewForScroll andButton: (UIButton*) sender;

@end
