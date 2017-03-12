//
//  VacanciesCell.h
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 11.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VacanciesCellDelegate;

@interface VacanciesCell : UITableViewCell

@property (weak, nonatomic) id <VacanciesCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *labelData;
@property (weak, nonatomic) IBOutlet UIImageView *imageType;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonDelete;
@property (weak, nonatomic) IBOutlet UIButton *buttonPush;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;


+(NSString*)cellIdentifier;

//Actions

- (IBAction)actionButtonDelete:(id)sender;
- (IBAction)actionButtonPush:(id)sender;


@end

@protocol VacanciesCellDelegate <NSObject>

- (void) actionCell: (VacanciesCell*) vacanciesCell endButtonDelete: (UIButton*) sender;
- (void) actionCell: (VacanciesCell*) vacanciesCell endButtonPush: (UIButton*) sender;



@end
