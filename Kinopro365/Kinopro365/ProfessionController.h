//
//  ProfessionController.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 13.02.17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"

@interface ProfessionController : MainViewController

@property (weak, nonatomic) IBOutlet UILabel *labelCountProfession;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (strong, nonatomic) NSString * professionID;
@property (strong, nonatomic) NSString * professionName;

- (IBAction)actionBackButton:(id)sender;

@end
