//
//  MenuController.m
//  PsychologistIOS
//
//  Created by Viktor on 31.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "MenuController.h"
#import "UIColor+HexColor.h"
#import "SWRevealViewController.h"
#import "Macros.h"
#import "NotificationController.h"
#import "AuthDbClass.h"

@interface MenuController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UIButton *buttonNotification;

@end

@implementation MenuController
{
    NSArray * menu;
    NSArray * arrayImage;
}

- (void) viewDidLoad
{
    self.mainTableView.backgroundColor = nil;
    self.mainTableView.scrollEnabled = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"3d3d3d"];
    
    
    menu = [NSArray arrayWithObjects:@"Cell1", @"Cell2", @"Cell3", @"Cell4", @"Cell5",
                                     @"Cell6", @"Cell7", @"Cell8", @"Cell9", @"Cell10",
                                     @"Cell11", @"Cell12", nil];
    
    arrayImage = [NSArray arrayWithObjects:@"VKMenu.png", @"faceMenu.png", @"instMenu.png", @"peresMenu.png", @"skypeMenu.png", nil];
    [self.buttonNotification addTarget:self action:@selector(buttonNotificationAction) forControlEvents:UIControlEventTouchUpInside];
    
    //Вью первой границы-------------------------------
    UIView * viewBorder1 = [[UIView alloc] initWithFrame:CGRectMake(0, 81, self.view.frame.size.width, 0.4)];
    viewBorder1.backgroundColor = [UIColor colorWithHexString:@"b3b3b3"];
    [self.view addSubview:viewBorder1];

    //Вью второй границы-------------------------------
    UIView * viewBorder2 = [[UIView alloc] initWithFrame:CGRectMake(0, 308, self.view.frame.size.width, 0.4)];
    viewBorder2.backgroundColor = [UIColor colorWithHexString:@"b3b3b3"];
    [self.view addSubview:viewBorder2];

    //Вью второй границы-------------------------------
    UIView * viewBorder3 = [[UIView alloc] initWithFrame:CGRectMake(0, 396, self.view.frame.size.width, 0.4)];
    viewBorder3.backgroundColor = [UIColor colorWithHexString:@"b3b3b3"];
    [self.view addSubview:viewBorder3];
    
    //Убираем полосы разделяющие ячейки------------------------------
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.backgroundColor = [UIColor clearColor];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = [menu objectAtIndex:indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = nil;
    
    if ([cellIdentifier isEqualToString:@"Cell8"]) {
        cell.userInteractionEnabled = NO;
    }
    
    if ([cellIdentifier isEqualToString:@"Cell11"]) {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
            //Поделится----------------------------------------
            UILabel * labelShare = [[UILabel alloc] initWithFrame:CGRectMake(20, 16, 200, 16)];
            labelShare.text = @"Поделиться";
            labelShare.textColor = [UIColor whiteColor];
            labelShare.font = [UIFont fontWithName:FONTREGULAR size:15];
            [cell addSubview:labelShare];
        
            //Загружаем кнопочки картинок----------------------
            for (int i = 0; i < 5; i ++) {
                UIButton * buttonMenu = [UIButton buttonWithType:UIButtonTypeCustom];
                buttonMenu.frame = CGRectMake(20 + 40 * i, 46, 32, 32);
                if (isiPhone5) {
                    buttonMenu.frame = CGRectMake(20 + 40 * i, 41, 32, 32);
                }
                buttonMenu.layer.cornerRadius = 16;
                UIImage * buttonImage = [UIImage imageNamed:[arrayImage objectAtIndex:i]];
                [buttonMenu setImage:buttonImage forState:UIControlStateNormal];
                buttonMenu.tag = 20 + i;
                [cell addSubview:buttonMenu];
            }
        
    }
    
    if ([cellIdentifier isEqualToString:@"Cell2"]) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }
}

#pragma mark - UITableViewDelegate
//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 11) {
        AuthDbClass * auth = [AuthDbClass new];
        [auth deleteAll];
    }    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 7) {
        return 15;
    } else if (indexPath.row == 1) {
        if (isiPhone5) {
            return 50;
        } else {
        return 60;
        }
    } else if (indexPath.row == 10) {
        if (isiPhone5) {
            return 75;
        } else {
        return 90;
        }
    } else if (indexPath.row == 6) {
        return 0;
    } else {
        if (isiPhone5) {
            return 30;
        } else {
        return 40;
    }
    }
}

#pragma mark - Action Methods

- (void) buttonNotificationAction
{
    NotificationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationController"];
    [self.navigationController pushViewController:detail animated:YES];
}



@end
