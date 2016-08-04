//
//  LoginView.h
//  TravelTogether
//
//  Created by Виктор Мишустин on 02/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewDelegate;

@interface LoginView : UIView

@property (weak, nonatomic) id <LoginViewDelegate> delegate;

- (instancetype)initMainViewMethodWithView: (UIView*) view
                                   andData: (NSArray*) data;


@end

@protocol LoginViewDelegate <NSObject>

- (void) buttonLoginActionWithLoginView: (LoginView*) loginView;
- (void) tapOnTermsOfUseWithLoginView: (LoginView*) loginView;
- (void) tapPrivacyPolicyWithLoginView: (LoginView*) loginView;

@end
