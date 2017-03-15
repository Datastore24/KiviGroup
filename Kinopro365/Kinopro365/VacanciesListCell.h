//
//  VacanciesListCell.h
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 02.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VacanciesListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *activelyLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelProfession;
@property (weak, nonatomic) IBOutlet UIView *shadowView;


@end
