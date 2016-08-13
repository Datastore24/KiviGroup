//
//  CategoryView.m
//  FlowersOnline
//
//  Created by Виктор on 13.08.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "CategoryView.h"
#import "UIView+BorderView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@interface CategoryView () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray * arrayData;
@property (strong, nonatomic) UITableView * tableCategory;

@end

@implementation CategoryView

- (instancetype)initWithView: (UIView*) view andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        
        self.arrayData = data;
        
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height - 64);
        self.tableCategory = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 40.f, self.frame.size.width, self.frame.size.height)];
        self.tableCategory.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableCategory.delegate = self;
        self.tableCategory.dataSource = self;
        self.tableCategory.showsVerticalScrollIndicator = NO;
        self.tableCategory.scrollEnabled = NO;
        [self addSubview:self.tableCategory];
        
    }
    return self;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.f;
}

//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    NSDictionary * dictCell =[self.arrayData objectAtIndex:indexPath.row];
    
    if (self.arrayData.count != 0) {
        [cell.contentView addSubview:[self setCustomCellWithName:[dictCell objectForKey:@"name"]
                                                        andImage:[dictCell objectForKey:@"img"]
                                                         andView:cell]];
    } else {
        NSLog(@"Нет категорий");
    }
    
    
    return cell;
    
}

#pragma mark - Custom Cell

- (UIView*) setCustomCellWithName: (NSString*) name
                         andImage: (NSString*) imageName
                          andView: (UIView*) view {
    UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height)];
    
    UILabel * labelNameCell = [[UILabel alloc] initWithFrame:CGRectMake(70.f, 0.f, view.frame.size.width - 40.f, view.frame.size.height)];
    labelNameCell.text = name;
    labelNameCell.textColor = [UIColor colorWithHexString:COLORGREEN];
    labelNameCell.font = [UIFont fontWithName:FONTREGULAR size:18];
    [cellView addSubview:labelNameCell];
    
    NSLog(@"%@", imageName);
    
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageName]];
        
        UIImageView * imageViewCell = [[UIImageView alloc] initWithFrame:CGRectMake(15.f, 5.f, 30.f, 30.f)];
        imageViewCell.layer.cornerRadius = 5.f;
        imageViewCell.clipsToBounds = YES;
        imageViewCell.image = [UIImage imageWithData: imageData];
        [cellView addSubview:imageViewCell];

    
    return cellView;
}



@end
