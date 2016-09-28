//
//  AuthorizationView.h
//  Sadovod
//
//  Created by Виктор Мишустин on 08/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AuthorizationViewDelegate;

@interface AuthorizationView : UIView

@property (weak, nonatomic) id <AuthorizationViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data;

@end

@protocol AuthorizationViewDelegate <NSObject>

@required

- (void) methodInput: (AuthorizationView*) authorizationView;
- (void) methodRegistration: (AuthorizationView*) authorizationView;
- (void) pushChangePassWork: (AuthorizationView*) authorizationView;
- (void) getApiAutorisation: (AuthorizationView*) registrationView andblock:(void (^)(void))block
                  andEmail: (NSString *) email
               andPassword: (NSString *) password;

@end
