//
//  MessegerView.m
//  TravelTogether
//
//  Created by Виктор Мишустин on 23/08/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "MessegerView.h"
#import "UIView+BorderView.h"
#import "HexColors.h"
#import "Macros.h"

@interface MessegerView ()

//Main

@property (strong, nonatomic) UIScrollView * chatScrollView;

@end

@implementation MessegerView

- (instancetype)initWithView: (UIView*) view
                     andData: (NSArray*) data
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.f, 64.f, view.frame.size.width, view.frame.size.height - 64.f);
        
        self.chatScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height - 38.5f)];
        self.chatScrollView.backgroundColor = [UIColor blueColor];
        [UIView borderViewWithHeight:self.frame.size.height - 37.5f andWight:0 andView:self andColor:@"cdcdcd"];
        
        //SendView
        UIView * sendView = [self createSendViewWithView:self];
        [self addSubview:sendView];
        

        
        

        
    }
    return self;
}


#pragma mark - sendView

- (UIView*) createSendViewWithView: (UIView*) view {
    UIView * sendView = [[UIView alloc] initWithFrame:CGRectMake(0.f, self.frame.size.height - 38.5f, self.frame.size.width, 38.5f)];
//    sendView.backgroundColor = [UIColor redColor];
    
    
    
    return sendView;
}

@end
