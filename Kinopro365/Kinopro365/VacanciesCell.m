//
//  VacanciesCell.m
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 11.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "VacanciesCell.h"

@implementation VacanciesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)actionButtonDelete:(id)sender {
    
    [self.delegate actionCell:self endButtonDelete:sender];
}

- (IBAction)actionButtonPush:(id)sender {
    [self.delegate actionCell:self endButtonPush:sender];
}


+(NSString*)cellIdentifier{
    static NSString* cellIdentifier;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cellIdentifier = @"Content1";
    });
    return cellIdentifier;
}
@end
