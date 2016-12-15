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

@interface CountryViewController ()

@property (strong, nonatomic) NSArray * countryArray;
@property (strong, nonatomic) NSMutableArray * tableArray;

@end

@implementation CountryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.countryArray = [CoutryModel setCountryArray];
    self.tableArray = [NSMutableArray arrayWithArray:self.countryArray];
    
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
    
    cell.textLabel.text = [self.tableArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:FONT_ISTOK_REGULAR size:16];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate changeButtonText:self withString:[self.tableArray objectAtIndex:indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UISearchBarDelegate


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [self.tableArray removeAllObjects];
    
    for (NSString * string in self.countryArray) {
        
        NSString * currentLetter = nil;
        
        if (self.searchBar.text.length > 0 && [string rangeOfString:self.searchBar.text].location == NSNotFound) {
            continue;
        }
        
        
        NSString * firstLetter = [string substringToIndex:1];
        
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




@end
