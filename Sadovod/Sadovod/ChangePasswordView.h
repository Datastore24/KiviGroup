//
//  ChangePasswordView.h
//  Sadovod
//
//  Created by Виктор Мишустин on 20.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangePasswordViewDelegate;

@interface ChangePasswordView : UIView

@property (weak, nonatomic) id <ChangePasswordViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data;

@end

@protocol ChangePasswordViewDelegate <NSObject>

@required

-(void) getApiPassword: (ChangePasswordView*) changePasswordView andblock:(void (^)(void))block
              andEmail: (NSString *) email;
- (void) buttonBackActionDelegate:(ChangePasswordView*) changePasswordView;


@end
