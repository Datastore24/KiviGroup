//
//  SettingsView.h
//  TravelTogether
//
//  Created by Виктор Мишустин on 29/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsViewDelegate;

@interface SettingsView : UIView

@property (weak, nonatomic) id <SettingsViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data;

@end

@protocol SettingsViewDelegate <NSObject>

@required

- (void) pushToMessegerController: (SettingsView*) settingsView;

- (void) pushToLikedController: (SettingsView*) settingsView;

- (void) pushTuConnectWithUs: (SettingsView*) settingsView;

@end
