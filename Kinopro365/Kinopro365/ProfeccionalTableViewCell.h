//
//  ProfeccionalTableViewCell.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 16.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfeccionalTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *customTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *checkImage;

@end
