//
//  CellPaymentHistory.h
//  Kinopro365
//
//  Created by Мишустин Сергеевич on 11.03.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CellPaymentHistoryDelegate;

@interface CellPaymentHistory : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelData;
@property (weak, nonatomic) IBOutlet UILabel *labelStatus;
@property (weak, nonatomic) IBOutlet UILabel *labelCount;

@property (weak, nonatomic) IBOutlet UIButton *buttonDelete;
@property (weak, nonatomic) id <CellPaymentHistoryDelegate> delegate;

- (IBAction)actionButtonDelete:(id)sender;

@end

@protocol CellPaymentHistoryDelegate <NSObject>

- (void) actionCell: (CellPaymentHistory*) cellPaymentHistory withButtonDelete: (UIButton*) sender;

@end
