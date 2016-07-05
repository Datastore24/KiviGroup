//
//  CatalogView.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 05/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "CatalogView.h"

@interface CatalogView () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView * mainTableView;
@property (strong, nonatomic) NSArray * arrayDate;

@end

@implementation CatalogView

- (instancetype)initWithView: (UIView*) view andDate: (NSMutableArray*) arrayDate
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        //create table
        
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.frame.size.width, 300)];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.allowsSelection = NO;
        [self addSubview:_mainTableView];
        
    
        
        
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UITableViewDelegate

@end
