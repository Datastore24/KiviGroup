//
//  VideoDetailsController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 2/6/17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "VideoDetailsController.h"
#import "VideoDetailsModel.h"
#import "VideoDetailsView.h"

@interface VideoDetailsController () <VideoDetailsModelDelegate, VideoDetailsViewDelegate>

@property (assign, nonatomic) NSInteger x; //-----------
@property (assign, nonatomic) NSInteger y; //Числовые параметры для отрисовки таблицы

@property (assign, nonatomic) BOOL actionButton; //если YES фото переходят в режим редактирования
@property (assign, nonatomic) NSInteger countDelete; //Колличество выбранных объектов на удаление
@property (strong, nonatomic) NSMutableArray *arrayDelete; //Массив для удаления объектов

@property (strong, nonatomic) NSArray * arrayData;

@property (strong, nonatomic) VideoDetailsModel * videoDetailsModel;


@end

@implementation VideoDetailsController

- (void) loadView {
    [super loadView];
    
    [self.navigationController setNavigationBarHidden: NO animated:YES];
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Видео"];
    self.navigationItem.titleView = CustomText;
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.videoDetailsModel = [[VideoDetailsModel alloc] init];
    self.videoDetailsModel.delegate = self;
    [self.videoDetailsModel getVideoArrayWithOffset:@"0" andCount:@"1000"];
    
    self.actionButton = NO;
    self.countDelete = 0;
    self.arrayDelete = [NSMutableArray array];
    
    

}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Actions

- (IBAction)actionButtonBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionButtonAddVideo:(UIBarButtonItem *)sender {
        [self pushCountryControllerWithIdentifier:@"VideoViewController"];
}

- (IBAction)actionButtonDelete:(UIBarButtonItem *)sender {
    
    
    if (!self.actionButton) {
        NSLog(@"Начинаю процесс редактирования");
        self.actionButton = YES;
    } else {
        NSLog(@"Заканчиваю процесс редактирования");
        self.actionButton = NO;
    }
    
}

- (IBAction)actionButtonConfDelete:(UIButton *)sender {
    
    NSLog(@"%@", self.arrayDelete);
    
}

#pragma mark - VideoDetailsModelDelegate

- (void) loadVideo: (NSArray *) array{
    
    NSLog(@"ARRAY %@",array);
    
    self.arrayData = array;
    
    [self creationViews];

    

    
}

#pragma mark - VideoDetailsViewDelegate

- (void) actionButton: (VideoDetailsView*) videoDetailsView andButton: (CustomButton*) button {
    
    if (!self.actionButton) {
        [videoDetailsView playVideo];
    } else {
        if (!button.isBool) {
            button.isBool = YES;
            videoDetailsView.imageViewDelete.alpha = 1.f;
            self.countDelete += 1;
            [self.arrayDelete addObject:videoDetailsView];
        } else {
            videoDetailsView.imageViewDelete.alpha = 0.f;
            button.isBool = NO;
            self.countDelete -= 1;
            [self.arrayDelete removeObject:videoDetailsView];
        }
    }
    if (self.countDelete > 0) {
        self.buttonConfDelete.alpha = 1;
    } else {
        self.buttonConfDelete.alpha = 0;
    }
    
    
    
}

#pragma mark - CreationvViews

- (void) creationViews {
    
    for (UIView * view in self.mainScrollView.subviews) {
        [view removeFromSuperview];
    }
    self.x = 0;
    self.y = 0;
    
    
    for (int i = 0; i < self.arrayData.count; i++) {
        
        NSDictionary * dict = [self.arrayData objectAtIndex:i];
        
        VideoDetailsView * view = [[VideoDetailsView alloc] initWithCustonFrame:
                                   CGRectMake(15 + 155 * self.x, 26 + 94 * self.y, 140, 79)
                                                                          andID:[dict objectForKey:@"id"]
                                                                         andURL:[dict objectForKey:@"link"]];
        view.delegateView = self;
        
        [self.mainScrollView addSubview:view];
        
        self.x += 1;
        if (self.x > 1) {
            self.x = 0;
            self.y += 1;
        }
        
    }
}

@end
