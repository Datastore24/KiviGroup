//
//  PersonalAreaView.h
//  FlowersOnline
//
//  Created by Виктор Мишустин on 05.06.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalAreaView : UIView <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithView: (UIView*) view andData: (NSArray*) dataArray;

@end
