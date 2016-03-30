//
//  ContactsView.m
//  ITDolgopa
//
//  Created by Viktor on 30.03.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "ContactsView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import <MapKit/MapKit.h>
#import "ZSPinAnnotation.h"
#import "ZSAnnotation.h"

@interface ContactsView () <MKMapViewDelegate>

@end

@implementation ContactsView
{
    UIScrollView * mainScrollView;
}

- (instancetype)initBackgroundWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        self.backgroundColor = [UIColor colorWithHexString:MAINBACKGROUNDCOLOR];
    }
    return self;
}

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        mainScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        [self addSubview:mainScrollView];
        
        UILabel * phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 80, 40)];
        phoneLabel.text = @"Телефон:";
        phoneLabel.textColor = [UIColor whiteColor];
        phoneLabel.textAlignment = NSTextAlignmentRight;
        phoneLabel.font = [UIFont fontWithName:FONTBOLD size:16];
        if (isiPhone5) {
            phoneLabel.frame = CGRectMake(40, 25, 80, 30);
            phoneLabel.font = [UIFont fontWithName:FONTBOLD size:14];
        }
        [mainScrollView addSubview:phoneLabel];
        
        UILabel * labelPhoneActive = [[UILabel alloc] initWithFrame:CGRectMake(170, 30, 400, 40)];
        labelPhoneActive.font = [UIFont fontWithName:FONTLITE size:16];
        if (isiPhone5) {
            labelPhoneActive.frame = CGRectMake(150, 20, 400, 40);
            labelPhoneActive.font = [UIFont fontWithName:FONTLITE size:14];
        }
        labelPhoneActive.text = @"8 (499) 713-59-17 \n8 (499) 709-90-13";
        labelPhoneActive.numberOfLines = 0;
        labelPhoneActive.textColor = [UIColor whiteColor];
        
        [mainScrollView addSubview:labelPhoneActive];
        
        UILabel * labelEmail = [[UILabel alloc] initWithFrame:CGRectMake(60, 70, 80, 40)];
        labelEmail.text = @"E-mail:";
        labelEmail.textColor = [UIColor whiteColor];
        labelEmail.textAlignment = NSTextAlignmentRight;
        labelEmail.font = [UIFont fontWithName:FONTBOLD size:16];
        if (isiPhone5) {
            labelEmail.frame = CGRectMake(40, 60, 80, 30);
            labelEmail.font = [UIFont fontWithName:FONTBOLD size:14];
        }
        [mainScrollView addSubview:labelEmail];
        
        UILabel * labelEmailActive = [[UILabel alloc] initWithFrame:CGRectMake(170, 70, 400, 40)];
        labelEmailActive.text = @"co@datastore24.ru";
        labelEmailActive.textColor = [UIColor whiteColor];
        labelEmailActive.font = [UIFont fontWithName:FONTLITE size:16];
        if (isiPhone5) {
            labelEmailActive.frame = CGRectMake(150, 60, 400, 30);
            labelEmailActive.font = [UIFont fontWithName:FONTLITE size:14];
        }
        [mainScrollView addSubview:labelEmailActive];
        
        UILabel * isqLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 110, 80, 40)];
        isqLabel.text = @"ISQ:";
        isqLabel.textColor = [UIColor whiteColor];
        isqLabel.textAlignment = NSTextAlignmentRight;
        isqLabel.font = [UIFont fontWithName:FONTBOLD size:16];
        if (isiPhone5) {
            isqLabel.frame = CGRectMake(40, 90, 80, 30);
            isqLabel.font = [UIFont fontWithName:FONTBOLD size:14];
        }
        [mainScrollView addSubview:isqLabel];
        
        UILabel * isqPhoneActive = [[UILabel alloc] initWithFrame:CGRectMake(170, 110, 400, 40)];
        isqPhoneActive.text = @"322017797";
        isqPhoneActive.textColor = [UIColor whiteColor];
        isqPhoneActive.font = [UIFont fontWithName:FONTLITE size:16];
        if (isiPhone5) {
            isqPhoneActive.frame = CGRectMake(150, 90, 400, 30);
            isqPhoneActive.font = [UIFont fontWithName:FONTLITE size:14];
        }
        [mainScrollView addSubview:isqPhoneActive];
        
        UILabel * skypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 150, 80, 40)];
        skypeLabel.text = @"Skype:";
        skypeLabel.textColor = [UIColor whiteColor];
        skypeLabel.textAlignment = NSTextAlignmentRight;
        skypeLabel.font = [UIFont fontWithName:FONTBOLD size:16];
        if (isiPhone5) {
            skypeLabel.frame = CGRectMake(40, 120, 80, 30);
            skypeLabel.font = [UIFont fontWithName:FONTBOLD size:14];
        }
        [mainScrollView addSubview:skypeLabel];
        
        UILabel * skypeLabelActive = [[UILabel alloc] initWithFrame:CGRectMake(170, 150, 400, 40)];
        skypeLabelActive.text = @"RadioVm";
        skypeLabelActive.textColor = [UIColor whiteColor];
        skypeLabelActive.font = [UIFont fontWithName:FONTLITE size:16];
        if (isiPhone5) {
            skypeLabelActive.frame = CGRectMake(150, 120, 400, 30);
            skypeLabelActive.font = [UIFont fontWithName:FONTLITE size:14];
        }
        [mainScrollView addSubview:skypeLabelActive];
        
        UILabel * timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 190, 120, 40)];
        timeLabel.text = @"Время работы:";
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.font = [UIFont fontWithName:FONTBOLD size:16];
        if (isiPhone5) {
            timeLabel.frame = CGRectMake(0, 160, 120, 30);
            timeLabel.font = [UIFont fontWithName:FONTBOLD size:14];
        }
        [mainScrollView addSubview:timeLabel];
        
        UILabel * timeLabelActive = [[UILabel alloc] initWithFrame:CGRectMake(170, 190, 400, 60)];
        timeLabelActive.text = @"ПН-ПТ: с 10 до 20 \nСБ: с 10 до 17 \nВыходной воскресенье";
        timeLabelActive.numberOfLines = 0;
        timeLabelActive.textColor = [UIColor whiteColor];
        timeLabelActive.font = [UIFont fontWithName:FONTLITE size:14];
        if (isiPhone5) {
            timeLabelActive.frame = CGRectMake(150, 145, 400, 60);
            timeLabelActive.font = [UIFont fontWithName:FONTLITE size:12];
        }
        [mainScrollView addSubview:timeLabelActive];
        
        UILabel * adressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 250, mainScrollView.frame.size.width - 40, 20)];
        adressLabel.text = @"Адрес:";
        adressLabel.textColor = [UIColor whiteColor];
        adressLabel.textAlignment = NSTextAlignmentCenter;
        adressLabel.font = [UIFont fontWithName:FONTBOLD size:16];
        if (isiPhone5) {
            adressLabel.frame = CGRectMake(20, 210, mainScrollView.frame.size.width - 40, 20);
            adressLabel.font = [UIFont fontWithName:FONTBOLD size:14];
        }
        [mainScrollView addSubview:adressLabel];
        
        UILabel * adresLabelActive = [[UILabel alloc] initWithFrame:CGRectMake(20, 275, mainScrollView.frame.size.width - 40, 40)];
        adresLabelActive.numberOfLines = 0;
        adresLabelActive.text = @"Московская обл., г. Долгопрудный, проспект Пацаева д.7 к.6";
        adresLabelActive.textColor = [UIColor whiteColor];
        adresLabelActive.textAlignment = NSTextAlignmentCenter;
        adresLabelActive.font = [UIFont fontWithName:FONTLITE size:16];
        if (isiPhone5) {
            adresLabelActive.frame = CGRectMake(20, 230, mainScrollView.frame.size.width - 40, 40);
            adresLabelActive.font = [UIFont fontWithName:FONTLITE size:14];
        }
        [mainScrollView addSubview:adresLabelActive];
        
        self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(20, 330, mainScrollView.frame.size.width - 40, 255)];
        if (isiPhone5) {
            self.mapView.frame = CGRectMake(20, 275, mainScrollView.frame.size.width - 40, 220);
        }
        self.mapView.delegate = self;
        [mainScrollView addSubview:self.mapView];
        CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(55.94715726272423, 37.50159502029419);
        MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 600, 600)];
        [self.mapView setRegion:adjustedRegion animated:YES];
        
        ZSAnnotation * annotation = [ZSAnnotation new];
        annotation.coordinate = CLLocationCoordinate2DMake(55.94715726272423, 37.50159502029419);
        annotation.color = [UIColor blackColor];
        annotation.type = ZSPinAnnotationTypeDisc;
        annotation.title = @"DataStore24";
        [self.mapView addAnnotation:annotation];
        
        mainScrollView.contentSize = CGSizeMake(0, 565);

     }
    return self;
}

#pragma mark - MapKit

- (MKMapRect)makeMapRectWithAnnotations:(NSArray *)annotations {
    
    MKMapRect flyTo = MKMapRectNull;
    for (id <MKAnnotation> annotation in annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        } else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }
    
    return flyTo;
    
}


- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation {
    
    // Don't mess with user location
    if(![annotation isKindOfClass:[ZSAnnotation class]])
        return nil;
    
    ZSAnnotation *a = (ZSAnnotation *)annotation;
    static NSString *defaultPinID = @"StandardIdentifier";
    
    // Create the ZSPinAnnotation object and reuse it
    ZSPinAnnotation *pinView = (ZSPinAnnotation *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if (pinView == nil){
        pinView = [[ZSPinAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
    }
    
    // Set the type of pin to draw and the color
    pinView.annotationType = ZSPinAnnotationTypeTagStroke;
    pinView.annotationColor = a.color;
    pinView.canShowCallout = YES;
    
    return pinView;
    
}




@end
