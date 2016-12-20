//
//  ChooseProfessionViewController.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 16.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"
#import "ProfeccionalTableViewCell.h"

@protocol ChooseProfessionViewControllerDelegate;

@interface ChooseProfessionViewController : MainViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) id <ChooseProfessionViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *buttonSave;

- (IBAction)actionBackButton:(id)sender;
- (IBAction)actionButtonSave:(UIButton *)sender;

@end

@protocol ChooseProfessionViewControllerDelegate <NSObject>

@optional

- (void) setTitlForButtonDelegate: (ChooseProfessionViewController*) chooseProfessionViewController
                         withTitl: (NSString*) titl;


@end
