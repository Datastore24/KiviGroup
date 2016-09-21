//
//  RegistrationView.h
//  Sadovod
//
//  Created by Виктор Мишустин on 08/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegistrationViewDelegate;

@interface RegistrationView : UIView

@property (weak, nonatomic) id <RegistrationViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data;

@end

@protocol RegistrationViewDelegate <NSObject>

@required

- (void) backToMainView: (RegistrationView*) registrationView;

@end
