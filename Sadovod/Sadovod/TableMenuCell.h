//
//  TableMenuCell.h
//  TravelTogether
//
//  Created by Виктор Мишустин on 02/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableMenuCell : UIView

- (UIView*) setCellListWithName: (NSString*) name
                   andImageName: (NSString*) imageName
                    andMainView: (UIView*) view;

- (UIView*) customCellQuitWithView: (UIView*) view;

@end
