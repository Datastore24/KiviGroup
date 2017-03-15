//
//  MenuViewModel.h
//  Kinopro365
//
//  Created by Кирилл Ковыршин on 02.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol MenuViewModelDelegate <NSObject>

@required
@property (weak, nonatomic) IBOutlet UIButton *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *userFLName;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *countRewardsLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLikesLabel;
@property (weak, nonatomic) IBOutlet UILabel *countViewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *countAlertLabel;




@end

@interface MenuViewModel : NSObject
@property (assign, nonatomic) id <MenuViewModelDelegate> delegate;
-(void) loadUserInformation;

@end
