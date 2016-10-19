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
                     andData: (NSDictionary*) data;

@end

@protocol AuthorizationViewDelegate <NSObject>

@required

- (void) methodInput: (AuthorizationView*) authorizationView;
- (void) methodRegistration: (AuthorizationView*) authorizationView;
- (void) pushChangePassWork: (AuthorizationView*) authorizationView;
- (void) getApiAutorisation: (AuthorizationView*) registrationView andblock:(void (^)(void))block
                  andEmail: (NSString *) email
               andPassword: (NSString *) password;
-(void) getUserInfo:(AuthorizationView*) authorizationView andName:(NSString *) name andblock:(void (^)(void))block;
-(void) getUserInfo:(AuthorizationView*) authorizationView andPassword:(NSString *) password andblock:(void (^)(void))block;
-(void) getUserInfo:(AuthorizationView*) authorizationView andPay:(NSString *) pay andblock:(void (^)(void))block;

@end
