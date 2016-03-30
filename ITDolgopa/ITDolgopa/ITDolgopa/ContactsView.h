//
//  ContactsView.h
//  ITDolgopa
//
//  Created by Viktor on 30.03.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ContactsView : UIView

@property (strong, nonatomic) MKMapView * mapView;

- (instancetype)initBackgroundWithView: (UIView*) view;
- (instancetype)initWithView: (UIView*) view;

@end
