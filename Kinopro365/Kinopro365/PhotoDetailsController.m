//
//  PhotoDetailsController.m
//  Kinopro365
//
//  Created by Виктор Мишустин on 2/6/17.
//  Copyright © 2017 kiviLab.com. All rights reserved.
//

#import "PhotoDetailsController.h"
#import "PhotoDetailsModel.h"
#import "HMImagePickerController.h"
#import "PhotoDetailView.h"

@interface PhotoDetailsController () <PhotoDetailsModelDelegate, HMImagePickerControllerDelegate, PhotoDetailViewDelegate>

@property (strong, nonatomic) NSArray * images;
@property (nonatomic) NSArray * selectedAssets;

@property (assign, nonatomic) NSInteger x; //-----------
@property (assign, nonatomic) NSInteger y; //Числовые параметры для отрисовки таблицы

@property (assign, nonatomic) BOOL actionButton; //если YES фото переходят в режим редактирования
@property (assign, nonatomic) NSInteger countDelete; //Колличество выбранных объектов на удаление
@property (strong, nonatomic) NSMutableArray *arrayDelete; //Массив для удаления объектов

@end

@implementation PhotoDetailsController

- (void) loadView {
    [super loadView];
    
    [self.navigationController setNavigationBarHidden: NO animated:YES];
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Фото"];
    self.navigationItem.titleView = CustomText;
    
    self.buttonConfDelete.layer.cornerRadius = 5;
    self.buttonConfDelete.alpha = 0.f;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    PhotoDetailsModel * photoDetailsModel = [[PhotoDetailsModel alloc] init];
    photoDetailsModel.delegate = self;
    [photoDetailsModel getPhotosArrayWithOffset:@"0" andCount:@"1000"];
    
    self.x = 0;
    self.y = 0;
    self.actionButton = NO;
    self.countDelete = 0;
    self.arrayDelete = [NSMutableArray array];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Actions

- (IBAction)actionButtonBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionButtonAddPhoto:(UIBarButtonItem *)sender {
    
        HMImagePickerController *picker = [[HMImagePickerController alloc] initWithSelectedAssets:self.selectedAssets];
        picker.pickerDelegate = self;
        picker.targetSize = CGSizeMake(600, 600);
        picker.maxPickerCount = 10 - self.images.count;
    
        [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)actionDeleteButton:(UIBarButtonItem *)sender {
    
    if (!self.actionButton) {
        NSLog(@"Начинаю процесс редактирования");
        self.actionButton = YES;
    } else {
        NSLog(@"Заканчиваю процесс редактирования");
        self.actionButton = NO;
    }
    
}

- (IBAction)actionButtonConfDelete:(UIButton *)sender {
    
    
}

#pragma mark - PhotoDetailsModelDelegate

- (void) loadPhotos: (NSArray *) array{
    
    NSLog(@"ARRAY PHOTOS %@",array);
    
}


#pragma mark - HMImagePickerControllerDelegate
- (void)imagePickerController:(HMImagePickerController *)picker
      didFinishSelectedImages:(NSArray<UIImage *> *)images
               selectedAssets:(NSArray<PHAsset *> *)selectedAssets {
    

        self.images = images;
        self.selectedAssets = selectedAssets;
    
    
    NSLog(@"%@", self.images);
 
        
//        for(int i=0; i<self.images.count; i++){
//            NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                     @"1",@"add_to_profile",nil];
    
//            [self.apiManager postImageDataFromSeverWithMethod:@"photo.save" andParams:params andToken:[[SingleTone sharedManager] token] andImage:[self.images objectAtIndex:i] complitionBlock:^(id response) {
//                
//                if(![response isKindOfClass:[NSDictionary class]]){
//                    
//                    NSLog(@"Загрузить фото не удалось");
//                }
//            }];
//        }
//    }
    
    for (UIView * view in self.mainScrollView.subviews) {
        [view removeFromSuperview];
    }
    self.x = 0;
    self.y = 0;
    
    [self creationViews];

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - CreationvViews

- (void) creationViews {
    
    for (int i = 0; i < self.images.count; i++) {
        PhotoDetailView * view = [[PhotoDetailView alloc] initWithImage:[self.images objectAtIndex:i]
                                                                andFrame:CGRectMake(5 + 78 * self.x, 15 + 103 * self.y, 75, 100)];
        view.delegate = self;
        
        [self.mainScrollView addSubview:view];
        
        self.x += 1;
        if (self.x > 3) {
            self.x = 0;
            self.y += 1;
        }
        
    }
}

#pragma mark - PhotoDetailViewDelegate

- (void) actionView: (PhotoDetailView*) photoDetailView withButton: (CustomButton*) sender {
    
    if (!self.actionButton) {
        NSLog(@"%@", sender);
    } else {
        if (!sender.isBool) {
            sender.isBool = YES;
            photoDetailView.imageViewDelete.alpha = 1.f;
            self.countDelete += 1;
            [self.arrayDelete addObject:photoDetailView];
        } else {
            photoDetailView.imageViewDelete.alpha = 0.f;
            sender.isBool = NO;
            self.countDelete -= 1;
            [self.arrayDelete removeObject:photoDetailView];
        }
    }
    
    if (self.countDelete > 0) {
        self.buttonConfDelete.alpha = 1;
    } else {
        self.buttonConfDelete.alpha = 0;
    }
    
}




@end
