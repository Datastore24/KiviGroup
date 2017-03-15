//
//  TwoViewController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 18.11.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "KinoproViewController.h"
#import "KinosferaCell.h"
#import "ChooseProfessionalModel.h"
#import "KinoproSearchController.h"
#import "ProfessionController.h"
#import "APIManger.h"
#import "PersonalDataController.h"

@interface KinoproViewController () <ChooseProfessionalModelDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation KinoproViewController

- (void) loadView {
    [super loadView];

    self.navigationController.navigationBarHidden = NO;
    
    UILabel * customText = [[UILabel alloc]initWithTitle:@"Киносфера"];
    self.navigationItem.titleView = customText;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    APIManger * apiManager = [[APIManger alloc] init];
    PersonalDataController * personalDataController = [[PersonalDataController alloc] init];
    
    [apiManager getDataFromSeverWithMethod:@"account.getProfileInfo" andParams:nil andToken:[[SingleTone sharedManager] token] complitionBlock:^(id response) {
        
        if([response objectForKey:@"error_code"]){
            
            NSLog(@"Ошибка сервера код: %@, сообщение: %@",[response objectForKey:@"error_code"],
                  [response objectForKey:@"error_msg"]);
            NSInteger errorCode = [[response objectForKey:@"error_code"] integerValue];
        }else{
            
            NSDictionary * respDict = [response objectForKey:@"response"];
            NSLog(@"PROFILE %@",respDict);
            
            NSArray * profArray =[respDict objectForKey:@"professions"];
            
            [[SingleTone sharedManager] setMyProfArray:profArray];
            [[SingleTone sharedManager] setMyProfileID:[respDict objectForKey:@"id"]];
            
            [personalDataController loadFromServer:respDict];
        }
        
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayData = [NSMutableArray array];
    ChooseProfessionalModel * chooseProfModel = [[ChooseProfessionalModel alloc] init];
    chooseProfModel.delegate = self;
    [chooseProfModel getArrayToTableView];
    
}

-(void) reloadTableKinosfera{
    NSLog(@"RELOAD");
    
    
    [self.tableView reloadData];
}

-(void) addObjectToDataArray:(NSDictionary *) dict finish:(BOOL) isFinish {
    if(isFinish){
        [self.arrayData addObject:dict];
        NSComparator compareDistances = ^(id string1, id string2)
        {
            NSNumber *number1 = [NSNumber numberWithFloat:[string1 integerValue]];
            NSNumber *number2 = [NSNumber numberWithFloat:[string2 integerValue]];
            
            return [number1 compare:number2];
        };
        // sort list and create nearest list
        NSSortDescriptor *sortDescriptorNearest = [NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES comparator:compareDistances];
        self.finalArray = [self.arrayData sortedArrayUsingDescriptors:@[sortDescriptorNearest]];
        
        [self reloadTableKinosfera];
    }else{
        [self.arrayData addObject:dict];
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void) pushMethodWithIdentifier: (NSString*) identifier {
    
    UIViewController * nextController =
    [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    [self.navigationController pushViewController:nextController animated:YES];
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.finalArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString * identifier = @"Cell";
    
    
    KinosferaCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    NSDictionary * dict = [self.finalArray objectAtIndex:indexPath.row];
    cell.image.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
    cell.name.text = [dict objectForKey:@"name"];
    cell.number.text = [dict objectForKey:@"number"];
    if ([cell.number.text isEqualToString:@"0"]) {
        cell.number.alpha = 0.f;
    }
//    cell.arrawImage = [UIImage imageNamed:@""];
    
    //Если окно загружается из меню аватрки
    if ([[[SingleTone sharedManager] myKinosfera] isEqualToString:@"1"]) {
        cell.number.alpha = 0.f;
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //Если окно загружается из меню аватарки необходимо попасть сразу в анкету
    if ([[[SingleTone sharedManager] myKinosfera] isEqualToString:@"1"]) {
        
        [self pushMethodWithIdentifier:@"ProfessionDetailController"];
        
    } else {
    
    ProfessionController * profController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionController"];
    
    NSDictionary * dict = [self.finalArray objectAtIndex:indexPath.row];
    profController.professionID = [dict objectForKey:@"id"];
    profController.professionName = [dict objectForKey:@"name"];

    [self.navigationController pushViewController:profController animated:YES];
    
    
    NSLog(@"didSelectRowAtIndexPath %ld", (long)indexPath.row);
    }
}

#pragma mark - Actions

- (IBAction)leftSideButtonMenu:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.centerContainer toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}



@end
