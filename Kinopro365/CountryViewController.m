//
//  CountryViewController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 15.12.16.
//  Copyright © 2016 kiviLab.com. All rights reserved.
//

#import "CountryViewController.h"
#import "CoutryModel.h"
#import "PersonalDataController.h"
#import "Macros.h"
#import "SingleTone.h"
#import "UserInformationTable.h"


@interface CountryViewController () <CoutryModelDelegate>


@property (strong, nonatomic) NSMutableArray * tableArray;
@property (strong, nonatomic) CoutryModel * countryModel;

@end

@implementation CountryViewController

- (void) loadView {
    [super loadView];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.countryModel = [[CoutryModel alloc] init];
    self.countryModel.delegate = self;
    
    self.countryArray = [NSMutableArray new];
    NSLog(@"COUNTRYCITY %@",[[SingleTone sharedManager] country_citi]);
    if([[[SingleTone sharedManager] country_citi] isEqualToString:@"country"]){
        [self.countryModel getCountryArrayToTableView:^{
            if(self.isSearch){
                NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       @"",@"id",
                                       @"Все Страны",@"name",nil];
                [self.countryArray insertObject:dict atIndex:0];
            }
            
            self.tableArray = [NSMutableArray arrayWithArray:self.countryArray];
            [self reloadTable];
        }];
    }else if ([[[SingleTone sharedManager] country_citi] isEqualToString:@"city"]){
        if(self.isSearch){
            [self.countryModel getCityArrayToTableView:[[SingleTone sharedManager] countrySearchID] block:^{
                NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       @"",@"id",
                                       @"Все Города",@"name",nil];
                [self.countryArray insertObject:dict atIndex:0];
                self.tableArray = [NSMutableArray arrayWithArray:self.countryArray];
                [self reloadTable];
            }];
        }else{
            [self.countryModel getCityArrayToTableView:[[SingleTone sharedManager] countryID] block:^{
                self.tableArray = [NSMutableArray arrayWithArray:self.countryArray];
                [self reloadTable];
            }];
        }
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tableArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"Cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [[self.tableArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.textLabel.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:16];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RLMResults *profTableDataArray = [UserInformationTable allObjects];
    if(!self.isSearch){
        if(profTableDataArray.count>0){
            
            UserInformationTable * userTable = [profTableDataArray objectAtIndex:0];
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            userTable.isSendToServer = @"0";
            [realm commitWriteTransaction];
            
        }
        [self.delegate changeButtonText:self withString:[[self.tableArray objectAtIndex:indexPath.row] objectForKey:@"name"]];
        
        if([[[SingleTone sharedManager] country_citi] isEqualToString:@"country"]){
            [[SingleTone sharedManager] setCountryID:[[self.tableArray objectAtIndex:indexPath.row] objectForKey:@"id"]];
            [self.countryModel putCountryIdToProfle:[[self.tableArray objectAtIndex:indexPath.row] objectForKey:@"id"]];
        }else if ([[[SingleTone sharedManager] country_citi] isEqualToString:@"city"]){
            [self.countryModel putCityIdToProfle:[[self.tableArray objectAtIndex:indexPath.row] objectForKey:@"id"]];
        }
    }else{
        [self.delegate changeButtonTextInSearch:self withString:[[self.tableArray objectAtIndex:indexPath.row] objectForKey:@"name"]];
        
        NSLog(@"TABLEARRAY %@",[self.tableArray objectAtIndex:indexPath.row]);
        if([[[SingleTone sharedManager] country_citi] isEqualToString:@"country"]){
            [[SingleTone sharedManager] setCountrySearchID:[[self.tableArray objectAtIndex:indexPath.row] objectForKey:@"id"]];
        }else if ([[[SingleTone sharedManager] country_citi] isEqualToString:@"city"]){
            [[SingleTone sharedManager] setCitySearchID:[[self.tableArray objectAtIndex:indexPath.row] objectForKey:@"id"]];
        }
        
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UISearchBarDelegate


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [self.tableArray removeAllObjects];
    
    for (NSDictionary * string in self.countryArray) {
        
        NSString * currentLetter = nil;
        
        
        NSString * nameCountry = [string objectForKey:@"name"];
        
        if (self.searchBar.text.length > 0 && [nameCountry rangeOfString:self.searchBar.text].location == NSNotFound) {
            continue;
        }
        NSString * firstLetter = [nameCountry substringToIndex:1];
        
        if (![currentLetter isEqualToString:firstLetter]) {
            currentLetter = firstLetter;
        }
        
        [self.tableArray addObject:string];
    }
    [self.tableView reloadData];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

-(void) reloadTable{
    NSLog(@"RELOAD COUNTRY");
    [self.tableView reloadData];
}

#pragma mark - Actions

- (IBAction)actionButtonCancel:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
