//
//  GaleryView.h
//  Sadovod
//
//  Created by Виктор Мишустин on 23.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GaleryViewDelegate;

@interface GaleryView : UIView

@property (weak, nonatomic) id <GaleryViewDelegate> delegate;

- (instancetype)initWithView: (UIView*) view andData: (NSDictionary *) data;

@end

@protocol GaleryViewDelegate <NSObject>

@required

- (void) hideGaleryView: (GaleryView*) galeryView;

@end
