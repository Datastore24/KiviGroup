//
//  HelloView.h
//  Sadovod
//
//  Created by Виктор Мишустин on 22.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HelloViewDelegate;

@interface HelloView : UIView

@property (weak, nonatomic) id <HelloViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view;

@end

@protocol HelloViewDelegate <NSObject>

@required

- (void) pushToQuestion: (HelloView*) helloView;

@end
