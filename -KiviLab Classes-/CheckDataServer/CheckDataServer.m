//
//  MessagePopUp.m
//  FlowersOnline
//
//  Created by Кирилл Ковыршин on 15.08.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "CheckDataServer.h"
#import "Macros.h"

@implementation CheckDataServer

+ (void)checkDataServerWithBlock: (id)object andMessage:(NSString*)message view:(id) view complitionBlock: (void (^) (void)) block
{
    NSLog(@"CHECK");
    
        if([object isKindOfClass:[NSArray class]]){
            NSLog(@"CHECK1");
            NSArray * objectArray = (NSArray *) object;
            if(objectArray.count > 0){
                block();
            }else{
                [self showEmptyMessage:message view:view];
            }
        }else if([object isKindOfClass:[NSMutableArray class]]){
            NSLog(@"CHECK2");
            NSMutableArray * objectArray = (NSMutableArray *) object;
            if(objectArray.count > 0){
                block();
            }else{
                [self showEmptyMessage:message view:view];
            }
        }else if([object isKindOfClass:[NSDictionary class]]){
            NSLog(@"CHECK3");
            NSDictionary * objectDict = (NSDictionary *) object;
            
            BOOL isEmpty = ([objectDict count] == 0);
            
            if(isEmpty){
                [self showEmptyMessage:message view:view];
            }else{
                block();
            }
        }else if([object isKindOfClass:[NSMutableDictionary class]]){
            NSLog(@"CHECK4");
            NSMutableDictionary * objectDict = (NSMutableDictionary *) object;
            
            BOOL isEmpty = ([objectDict count] == 0);
            
            if(isEmpty){
                [self showEmptyMessage:message view:view];
            }else{
                block();
            }
            
        }else{
            NSLog(@"CHECK5");
            [self showEmptyMessage:message view:view];
        }

    
    
    
    
    
    
    
}

+ (void)checkDataServer: (id)object andMessage:(NSString*)message view:(id) view {
    NSLog(@"CHECK");
    
    if([object isKindOfClass:[NSArray class]]){
        NSLog(@"CHECK1");
        NSArray * objectArray = (NSArray *) object;
        if(objectArray.count == 0){
        
            [self showEmptyMessage:message view:view];
        }
    }else if([object isKindOfClass:[NSMutableArray class]]){
        NSLog(@"CHECK2");
        NSMutableArray * objectArray = (NSMutableArray *) object;
        if(objectArray.count == 0){
            [self showEmptyMessage:message view:view];
        }
    }else if([object isKindOfClass:[NSDictionary class]]){
        NSLog(@"CHECK3");
        NSDictionary * objectDict = (NSDictionary *) object;
        
        BOOL isEmpty = ([objectDict count] == 0);
        
        if(isEmpty){
            [self showEmptyMessage:message view:view];
        }
        
    }else if([object isKindOfClass:[NSMutableDictionary class]]){
        NSLog(@"CHECK4");
        NSMutableDictionary * objectDict = (NSMutableDictionary *) object;
        
        BOOL isEmpty = ([objectDict count] == 0);
        
        if(isEmpty){
            [self showEmptyMessage:message view:view];
        }
        
    }else{
        NSLog(@"CHECK5");
        [self showEmptyMessage:message view:view];
    }
    
    
    
}

+ (BOOL) checkView: (id) view{
    
    BOOL check;
    
    if([view isKindOfClass:[UIView class]] || [view isKindOfClass:[UIScrollView class]]){
        NSLog(@"CHECK UIVIEW");
        check=YES;
    
    }else if([view isKindOfClass:[UITableView class]]){
        NSLog(@"CHECK UITABLE");
    
        check=NO;
    }else{
       NSLog(@"CHECK XER");
    }
    
    return check;
}

+ (void)showEmptyMessage: (NSString*)message view:(UIView *) view{
    
    
    
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(view.frame.size.width / 2,
                                                                            view.frame.size.height / 2 - 100, 50, 50)];
    
    [imageView setCenter:CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2-40)];
    UIImage *image = [UIImage imageNamed: @"x_1.png"];
    
    [imageView setImage:image];
    
    
    
    
    UILabel * successLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/2, view.frame.size.height/2, view.frame.size.width, 50)];
    
   
        
        [successLabel setCenter:CGPointMake(successLabel.frame.size.width / 2, view.frame.size.height / 2)];
        successLabel.textAlignment = NSTextAlignmentCenter;
        successLabel.text = message;
        successLabel.textColor = [UIColor blackColor];
        successLabel.font = [UIFont fontWithName:VM_FONT_REGULAR size:20];
    
    
    if([self checkView:view]){
        [view addSubview:imageView];
        [view addSubview:successLabel];
    }else{
        
        [view bringSubviewToFront:imageView];
        [view bringSubviewToFront:successLabel];

        
    }
        
    
    }

@end
