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

@interface MenuController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

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
                                     @"Cell6", @"Cell7", @"Cell8", nil];
    
    arrayImage = [NSArray arrayWithObjects:@"VKMenu.png", @"faceMenu.png", @"instMenu.png", @"peresMenu.png", @"skypeMenu.png", nil];
    
    //Вью первой границы-------------------------------
    UIView * viewBorder1 = [[UIView alloc] initWithFrame:CGRectMake(0, 85, self.view.frame.size.width, 0.4)];
    viewBorder1.backgroundColor = [UIColor colorWithHexString:@"b3b3b3"];
    [self.view addSubview:viewBorder1];
    
    //Вью второй границы-------------------------------
    UIView * viewBorder2 = [[UIView alloc] initWithFrame:CGRectMake(0, 355, self.view.frame.size.width, 0.4)];
    viewBorder2.backgroundColor = [UIColor colorWithHexString:@"b3b3b3"];
    [self.view addSubview:viewBorder2];
    
    //Вью второй границы-------------------------------
    UIView * viewBorder3 = [[UIView alloc] initWithFrame:CGRectMake(0, 455, self.view.frame.size.width, 0.4)];
    viewBorder3.backgroundColor = [UIColor colorWithHexString:@"b3b3b3"];
    [self.view addSubview:viewBorder3];
    
    //Поделится----------------------------------------
    UILabel * labelShare = [[UILabel alloc] initWithFrame:CGRectMake(20, 470, 200, 16)];
    labelShare.text = @"Поделиться";
    labelShare.textColor = [UIColor whiteColor];
    labelShare.font = [UIFont fontWithName:FONTREGULAR size:15];
    [self.view addSubview:labelShare];
    
    //Загружаем кнопочки картинок----------------------
    for (int i = 0; i < 5; i ++) {
        UIButton * buttonMenu = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonMenu.frame = CGRectMake(20 + 40 * i, 500, 32, 32);
        buttonMenu.layer.cornerRadius = 16;
        UIImage * buttonImage = [UIImage imageNamed:[arrayImage objectAtIndex:i]];
        [buttonMenu setImage:buttonImage forState:UIControlStateNormal];
        buttonMenu.tag = 20 + i;
        [self.view addSubview:buttonMenu];
    }
    
    //Кнопка выход-------------------------------------
    UIButton * buttonExit = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonExit.frame = CGRectMake(20, 535, 60, 40);
    [buttonExit setTitle:@"Выйти" forState:UIControlStateNormal];
    [buttonExit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonExit.titleLabel.textAlignment = NSTextAlignmentLeft;
    buttonExit.titleLabel.font = [UIFont fontWithName:FONTLITE size:19];
    [self.view addSubview:buttonExit];
    

    
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
    
    if ([cellIdentifier isEqualToString:@"Cell6"]) {
        cell.userInteractionEnabled = NO;
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
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5) {
        return 15;
    } else {
        return 40;
    }
    
}



@end
