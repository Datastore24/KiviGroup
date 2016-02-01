//
//  ViewController.m
//  test
//
//  Created by Кирилл Ковыршин on 01.02.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UIView * mainView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    mainView = [[UIView alloc] initWithFrame:CGRectMake(self.view.center.x, 40, 100, 40)];
    mainView.center = self.view.center;
    mainView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:mainView];
    [self testMethod];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testMethod) name:@"moveRight" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(atestMethod) name:@"moveLeft" object:nil];

}

-(void)testMethod{

    
    [UIView animateWithDuration:1.0f animations:^{
     
        mainView.center = CGPointMake(self.view.center.x + 100, self.view.center.y);
        
    } completion:^(BOOL finished) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"moveLeft" object:nil];
    }];

}

-(void)atestMethod{
    [UIView animateWithDuration:1.0f animations:^{
      mainView.center = CGPointMake(self.view.center.x - 100, self.view.center.y);
    } completion:^(BOOL finished) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"moveRight" object:nil];
    
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
