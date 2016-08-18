//
//  TableMenuCell.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 02/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "TableMenuCell.h"
#import "Macros.h"
#import "HexColors.h"
#import "UIView+BorderView.h"

@implementation TableMenuCell

- (UIView*) setCellListWithName: (NSString*) name
                   andImageName: (NSString*) imageName
                    andMainView: (UIView*) view
{
    UIView * viewCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    viewCell.backgroundColor = [UIColor clearColor];
    
    UILabel * labelTint = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, viewCell.frame.size.width - 65, viewCell.frame.size.height)];
    labelTint.text = name;
    labelTint.textColor = [UIColor blackColor];
    labelTint.font = [UIFont fontWithName:VM_FONT_SF_DISPLAY_REGULAR size:15];
    [viewCell addSubview:labelTint];
    
    UIImageView * imageMenu = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11.f, 20.f, 20.f)];
    imageMenu.image = [UIImage imageNamed:imageName];
    [viewCell addSubview:imageMenu];
    
    [UIView borderViewWithHeight:viewCell.frame.size.height - 1.f andWight:0 andView:viewCell andColor:@"d3d0ce"];
    
    return viewCell;
    
}

- (UIView*) customCellQuitWithView: (UIView*) view
{
    UIView * customCellQuit = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 80)];
    
    UILabel * labelTint = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, customCellQuit.frame.size.width - 60, 20)];
    labelTint.text = @"ВЫЙТИ";
    labelTint.textColor = [UIColor whiteColor];
    labelTint.font = [UIFont fontWithName:VM_FONT_REGULAR size:12];
    [customCellQuit addSubview:labelTint];
    
    UILabel * labelSubTitnt = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, customCellQuit.frame.size.width - 60, 20)];
    labelSubTitnt.text = @"Дженифер Энистон";
    labelSubTitnt.textColor = [UIColor colorWithWhite:1.f alpha:0.5f];
    labelSubTitnt.font = [UIFont fontWithName:VM_FONT_REGULAR size:12];
    [customCellQuit addSubview:labelSubTitnt];
    
    UIImageView * imagePhoto = [[UIImageView alloc] initWithFrame:CGRectMake(180, 15, 50, 50)];
    imagePhoto.image = [UIImage imageNamed:@"imageAva.png"];
    [customCellQuit addSubview:imagePhoto];
    
    return customCellQuit;
}

@end
