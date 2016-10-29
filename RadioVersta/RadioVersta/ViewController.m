//
//  ViewController.m
//  RadioVersta
//
//  Created by Кирилл Ковыршин on 27.10.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString* resourcePath = url; //your url
    NSData *_objectData = [NSData dataWithContentsOfURL:[NSURL URLWithString:resourcePath]];
    NSError *error;
    
    app.audioPlayer = [[AVAudioPlayer alloc] initWithData:_objectData error:&error];
    app.audioPlayer.numberOfLoops = 0;
    app.audioPlayer.volume = 1.0f;
    [app.audioPlayer prepareToPlay];
    
    if (app.audioPlayer == nil)
        NSLog(@"%@", [error description]);
    else
        [app.audioPlayer play];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
