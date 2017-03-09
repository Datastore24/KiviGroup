//
//  ViewForComment.h
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 09.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"

@protocol ViewForCommentDelegate;

@interface ViewForComment : UIView

@property (weak, nonatomic) id <ViewForCommentDelegate> delegate;

- (instancetype)initWithMainView: (UIView*) view endHeight: (CGFloat) height;
- (instancetype)initHideWithMainView: (UIView*) view endHeight: (CGFloat) height;



@end

@protocol ViewForCommentDelegate <NSObject>

- (void) startTextView: (ViewForComment*) viewForComment endTextView: (UITextView*) textView;
- (void) endTextView: (ViewForComment*) viewForComment endTextView: (UITextView*) textView;
- (void) checkOnHeight: (UITextView*) textView;
- (void) checkOnHideHeight: (UITextView*) textView;

@end
