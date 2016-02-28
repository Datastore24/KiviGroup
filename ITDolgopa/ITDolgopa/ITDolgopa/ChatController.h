//
//  ChatController.h
//  ITDolgopa
//
//  Created by Viktor on 25.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KYPullToCurveVeiw.h"
#import "KYPullToCurveVeiw_footer.h"

@interface ChatController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonMenu;
@property (assign,nonatomic) NSUInteger chatCount;
@property (assign,nonatomic) NSUInteger offset;
@property (assign,nonatomic) NSUInteger maxCount;
@property (nonatomic, strong) KYPullToCurveVeiw *headerView;
@property (nonatomic, strong) KYPullToCurveVeiw_footer *footerView;
@property (assign,nonatomic) BOOL isRefresh;
@property (strong, nonatomic) UIScrollView * mainScrollView;
@property (strong, nonatomic) NSArray * arrayDialog;
@property (strong, nonatomic) NSDictionary * dictResponse;

@end
