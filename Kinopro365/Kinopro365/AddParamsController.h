//
//  AddParamsController.h
//  Kinopro365
//
//  Created by Виктор Мишустин on 20.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "MainViewController.h"

@protocol AddParamsControllerDelegate <NSObject>

@required

@property (strong, nonatomic) NSArray * mainArrayData;
@property (assign, nonatomic) BOOL isLanguage;

@end

@interface AddParamsController : MainViewController

@property (assign, nonatomic) id <AddParamsControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (strong, nonatomic) NSArray * profArray;
@property (weak, nonatomic) IBOutlet UIButton *buttonSave;



- (IBAction)actionButtonSave:(id)sender;
@end
