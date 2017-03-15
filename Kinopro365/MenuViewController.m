//
//  LeftSideViewController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 17.11.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuViewModel.h"
#import "AppDelegate.h"
#import "SingleTone.h"
#import "VacanciesListController.h"
#import "Macros.h"
#import "ProfessionDetailController.h"
#import "ChooseProfessionalModel.h"

@interface MenuViewController () <MenuViewModelDelegate>

@property (strong, nonatomic) NSArray * arrayImagesOn;
@property (strong, nonatomic) NSArray * arrayImagesOff;

@end

@implementation MenuViewController

- (void) loadView{
    [super loadView];
    
    
    self.viewForAlert.layer.cornerRadius = CGRectGetWidth(self.viewForAlert.bounds) / 2;
    
    self.shadowView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    [self.shadowView.layer setShadowOffset:CGSizeMake(0, 3)];
    [self.shadowView.layer setShadowOpacity:0.7];
    [self.shadowView.layer setShadowRadius:2.0f];
    [self.shadowView.layer setShouldRasterize:YES];
    
    [self.shadowView.layer setCornerRadius:5.0f];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    MenuViewModel * menuViewModel = [[MenuViewModel alloc] init];
    menuViewModel.delegate=self;
    [menuViewModel loadUserInformation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayImagesOn = [NSArray arrayWithObjects:
                          @"filmImage", @"megaphoneImageOn", @"groupImageOn",
                          @"castingImageOn", @"bookmarkImageOn", @"notificationImageOn",
                          @"walletImageOn", @"settingImageOn", nil];
    
    self.arrayImagesOff = [NSArray arrayWithObjects:
                           @"filmImageOff", @"megaphoneImage", @"groupImage",
                           @"theateImage", @"bookmarkImage", @"notificationsImage",
                           @"walletImaga", @"settingsImage", nil];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) pushMethodWithIdentifier: (NSString*) identifier {
    
    UIViewController * nextController =
    [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    UINavigationController * nextNavNav = [[UINavigationController alloc]
                                          initWithRootViewController:nextController];
//    nextNavNav.navigationBar.layer.borderColor = [[UIColor whiteColor] CGColor];
//    nextNavNav.navigationBar.layer.borderWidth=2;// set border you can see the shadow
    nextNavNav.navigationBar.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
    nextNavNav.navigationBar.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    nextNavNav.navigationBar.layer.shadowRadius = 3.0f;
    nextNavNav.navigationBar.layer.shadowOpacity = 1.0f;
    nextNavNav.navigationBar.layer.masksToBounds=NO;
    
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.centerContainer.centerViewController = nextNavNav;
    [appDelegate.centerContainer toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
    
}
- (IBAction)actionForCheck:(id)sender {
    
    for (int i = 0; i < self.arrayButtons.count; i++) {
        UILabel * label = [self.arrayLabels objectAtIndex:i];
        UIImageView * imageView = [self.arrayImages objectAtIndex:i];
        if ([[self.arrayButtons objectAtIndex:i] isEqual:sender]) {
            label.font = [UIFont fontWithName:FONT_ISTOK_BOLD size:16];
            imageView.image = [UIImage imageNamed:[self.arrayImagesOn objectAtIndex:i]];
        } else {
            label.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:16];
            imageView.image = [UIImage imageNamed:[self.arrayImagesOff objectAtIndex:i]];
        }
    }
}

- (IBAction)actionButtonKinopro:(id)sender {
    [[SingleTone sharedManager] setMyKinosfera:@"0"];
    [self pushMethodWithIdentifier:@"KinoproViewController"];
    
}

- (IBAction)actionButtonVacancies:(id)sender {
    [[SingleTone sharedManager] setTypeView:@"0"];
    [self pushMethodWithIdentifier:@"VacanciesListController"];
}

- (IBAction)actionButtonCastings:(id)sender {
        [[SingleTone sharedManager] setTypeView:@"1"];
        [self pushMethodWithIdentifier:@"VacanciesListController"];
}

- (IBAction)actionButtonBookmark:(id)sender {
    [[SingleTone sharedManager] setMyKinosfera:@"0"];
    [self pushMethodWithIdentifier:@"BookmarksController"];
}

- (IBAction)actionButtonSettings:(id)sender {
    [self pushMethodWithIdentifier:@"SettingsController"];  
}

- (IBAction)actionAllertButton:(id)sender {
    [self pushMethodWithIdentifier:@"AlertsController"];  
}

- (IBAction)actionButtonPayment:(id)sender {
   [self pushMethodWithIdentifier:@"PaymentController"];  
}

- (IBAction)actionButtonFeedback:(id)sender {
    [self pushMethodWithIdentifier:@"FeedbackController"];
}

- (IBAction)actionAvatar:(id)sender {
    
    
    [[SingleTone sharedManager] setMyKinosfera:@"1"];
    //Необходима проверка колличества профессий
    //Если приходит несколько профессий переходим в контроллер выбора профессий
    //Если одна профессия переходим сразу в анкету
    //-----
    //Временный будевый параметр
    NSArray * profArray = [[SingleTone sharedManager] myProfArray];
    
//    if (profArray.count>1) {
//        [self pushMethodWithIdentifier:@"KinoproViewController"];
//    } else if(profArray.count == 1){
    
        
        ProfessionDetailController * profController =
        [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionDetailController"];
        UINavigationController * nextNavNav = [[UINavigationController alloc]
                                               initWithRootViewController:profController];
        //    nextNavNav.navigationBar.layer.borderColor = [[UIColor whiteColor] CGColor];
        //    nextNavNav.navigationBar.layer.borderWidth=2;// set border you can see the shadow
        nextNavNav.navigationBar.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
        nextNavNav.navigationBar.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
        nextNavNav.navigationBar.layer.shadowRadius = 3.0f;
        nextNavNav.navigationBar.layer.shadowOpacity = 1.0f;
        nextNavNav.navigationBar.layer.masksToBounds=NO;
        
        profController.profileID = [[SingleTone sharedManager] myProfileID];
        
        NSDictionary * profDict = [profArray objectAtIndex:0];
    
        profController.profID = [profDict objectForKey:@"profession_id"];
        
        NSArray * professionArray = [ChooseProfessionalModel getArrayProfessions];
        NSArray *filtered = [professionArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(id == %@)", [profDict objectForKey:@"profession_id"]]];
        NSDictionary *item;
        if(filtered.count>0){
            item = [filtered objectAtIndex:0];
        }
        
        //Профеесия
        if(item.count > 0){
            profController.profName = [item objectForKey:@"name"];
            
        }
        
        NSLog(@"PROFILEID %@ PROFID %@ PROFNAME %@", [[SingleTone sharedManager] myProfileID],profController.profID,profController.profName);
        
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.centerContainer.centerViewController = nextNavNav;
        [appDelegate.centerContainer toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
//    }
    
    
    
}

//редактирование профиля
- (IBAction)editProfileAction:(id)sender {
    [self pushMethodWithIdentifier:@"PersonalDataController"];
    
}


@end
