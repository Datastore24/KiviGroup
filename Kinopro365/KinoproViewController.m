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

@interface KinoproViewController () <ChooseProfessionalModelDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation KinoproViewController

- (void) loadView {
    [super loadView];

    self.navigationController.navigationBarHidden = NO;
    
    UILabel * customText = [[UILabel alloc]initWithTitle:@"Киносфера"];
    self.navigationItem.titleView = customText;
    
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
//    cell.arrawImage = [UIImage imageNamed:@""];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ProfessionController * profController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionController"];
    
    NSDictionary * dict = [self.finalArray objectAtIndex:indexPath.row];
    profController.professionID = [dict objectForKey:@"id"];
    profController.professionName = [dict objectForKey:@"name"];

    [self.navigationController pushViewController:profController animated:YES];
    
    
    NSLog(@"didSelectRowAtIndexPath %ld", (long)indexPath.row);
    
}

#pragma mark - Actions

- (IBAction)leftSideButtonMenu:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.centerContainer toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}



@end
