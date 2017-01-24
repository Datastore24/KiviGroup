//
//  CountryViewController.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 15.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CountryViewControllerDelegate;

@interface CountryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) id <CountryViewControllerDelegate> delegate;
@property (strong, nonatomic) NSArray * countryArray;
@property (weak, nonatomic) IBOutlet UIButton *buttonCancel;

- (IBAction)actionButtonCancel:(UIButton *)sender;

@end

@protocol CountryViewControllerDelegate <NSObject>

@optional

- (void) changeButtonText: (CountryViewController*) controller withString: (NSString*) string;

@end
