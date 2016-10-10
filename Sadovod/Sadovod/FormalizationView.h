//
//  FormalizationView.h
//  Sadovod
//
//  Created by Виктор Мишустин on 05/09/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FormalizationViewDelegate;

@interface FormalizationView : UIView

@property (weak, nonatomic) id <FormalizationViewDelegate> delegate;


- (instancetype)initWithView: (UIView*) view
                     andData: (NSDictionary*) data;

@end

@protocol FormalizationViewDelegate <NSObject>

@required

-(void) getApiCreateOrder:(FormalizationView*) catalogDetailView;

@end


