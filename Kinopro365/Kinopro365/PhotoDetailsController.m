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
#import "APIManger.h"

@interface PhotoDetailsController () <PhotoDetailsModelDelegate, HMImagePickerControllerDelegate, PhotoDetailViewDelegate>

@property (strong, nonatomic) NSArray * images;
@property (nonatomic) NSArray * selectedAssets;
@property (strong, nonatomic) PhotoDetailsModel * photoDetailsModel;

@property (assign, nonatomic) NSInteger x; //-----------
@property (assign, nonatomic) NSInteger y; //Числовые параметры для отрисовки таблицы

@property (assign, nonatomic) BOOL actionButton; //если YES фото переходят в режим редактирования
@property (assign, nonatomic) NSInteger countDelete; //Колличество выбранных объектов на удаление
@property (strong, nonatomic) NSMutableArray *arrayDelete; //Массив для удаления объектов
@property (strong, nonatomic) APIManger * apiManager;

@property (strong, nonatomic) NSArray * arrayData;

@property (strong, nonatomic) PhotoDetailView * imageView;

@property (strong, nonatomic) NSMutableArray * arrayButtons;

@end

@implementation PhotoDetailsController

- (void) loadView {
    [super loadView];
    
    [self.navigationController setNavigationBarHidden: NO animated:YES];
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Фото"];
    self.navigationItem.titleView = CustomText;
    
    self.buttonConfDelete.layer.cornerRadius = 5;
    self.buttonConfDelete.alpha = 0.f;
    
    self.imageView = [[PhotoDetailView alloc] initWithCustomFrame:
                                   CGRectMake(0.f, 64.f, self.view.frame.size.width,
                                              self.view.frame.size.height - 64.f)];
//    self.imageView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.imageView];
    self.imageView.alpha = 0.f;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoDetailsModel = [[PhotoDetailsModel alloc] init];
    self.arrayButtons = [NSMutableArray array];
    self.photoDetailsModel.delegate = self;
    
    
    self.apiManager = [[APIManger alloc] init];
    
    self.x = 0;
    self.y = 0;
    self.actionButton = NO;
    self.countDelete = 0;
    self.arrayDelete = [NSMutableArray array];

}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self loadViewCustom];
    
    
    
}

-(void) loadViewCustom {
    
//    [self.arrayDelete removeAllObjects];
    
    self.countDelete = 0;
    
    self.buttonConfDelete.alpha = 0;
    
    
    
    [self createActivitiIndicatorAlertWithView];
    
    [self.photoDetailsModel getPhotosArrayWithOffset:@"0" andCount:@"1000"];
    
    
    

    

    
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
        self.actionButton = NO;
        HMImagePickerController *picker = [[HMImagePickerController alloc] initWithSelectedAssets:self.selectedAssets];
        picker.pickerDelegate = self;
        picker.targetSize = CGSizeMake(600, 600);
        picker.maxPickerCount = 10 - self.images.count;
    
        [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)actionDeleteButton:(UIBarButtonItem *)sender {
    
    NSLog(@"array %@", self.arrayButtons);
    
    if (self.arrayButtons.count != 0) {
        if (!self.actionButton) {
            NSLog(@"Начинаю процесс редактирования");
            [sender setImage:[UIImage imageNamed:@"buttonDeleteOff"]];
            self.actionButton = YES;
        } else {
            NSLog(@"Заканчиваю процесс редактирования");
            [sender setImage:[UIImage imageNamed:@"buttonDeleteOn"]];
            self.actionButton = NO;
            [self allClear];
        }
    } else {
        [self showAlertWithMessage:@"У вас нет не одной фотографии для удаления"];
    }
}

- (IBAction)actionButtonConfDelete:(UIButton *)sender {
    
    NSLog(@"ARRAY DELETE %@", self.arrayDelete);
    self.actionButton = NO;
    [self.photoDetailsModel deletePhotos:self.arrayDelete];
    
    [self.deleteButton setImage:[UIImage imageNamed:@"buttonDeleteOn"]];
}

- (void) desableActivityIndicator {
    
    [self deleteActivitiIndicator];
}

#pragma mark - PhotoDetailsModelDelegate

- (void) loadPhotos: (NSArray *) array{
    
    self.arrayData = array;
    [self creationViews];
    
}


#pragma mark - HMImagePickerControllerDelegate
- (void)imagePickerController:(HMImagePickerController *)picker
      didFinishSelectedImages:(NSArray<UIImage *> *)images
               selectedAssets:(NSArray<PHAsset *> *)selectedAssets {
    

        self.images = images;
    
        for(int i=0; i<self.images.count; i++){
            
            [self.apiManager postImageDataFromSeverWithMethod:@"photo.save" andParams:nil andToken:[[SingleTone sharedManager] token] andImage:[self.images objectAtIndex:i] complitionBlock:^(id response) {
                
                NSLog(@"PHOTOSAVE %@",response);
                
                if(![response isKindOfClass:[NSDictionary class]]){
                    
                    NSLog(@"Загрузить фото не удалось");
                }else{
                    NSDictionary * dictResponse = [response objectForKey:@"response"];
                    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                             [dictResponse objectForKey:@"id"],@"photo_id", nil];
                    [self.apiManager getDataFromSeverWithMethod:@"photo.addToProfile" andParams:params andToken:[[SingleTone sharedManager] token] complitionBlock:^(id responseTwo) {
                        if([responseTwo isKindOfClass:[NSDictionary class]]){
                            if([[responseTwo objectForKey:@"response"] integerValue] != 1){
                                NSLog(@"Загрузить фото в профиль не удалось");
                            }
                            
                            
                        }else{
                            NSLog(@"Загрузить фото в профиль не удалось");
                        }
                        
                        if(i == self.images.count - 1){
                            
                            
                            
                            [self creationViews];
                            
                            [self dismissViewControllerAnimated:YES completion:nil];
                            
                        }
                    }];
                }
                
            }];
        }
}

#pragma mark - CreationvViews

- (void) creationViews {
    
    for (UIView * view in self.mainScrollView.subviews) {
        [view removeFromSuperview];
        [self.arrayButtons removeAllObjects];
    }
    self.x = 0;
    self.y = 0;
    
    
    for (int i = 0; i < self.arrayData.count; i++) {
        
        NSDictionary * dict = [self.arrayData objectAtIndex:i];
        
        CGRect viewRect = CGRectMake(6 + 78 * self.x, 15 + 103 * self.y, 75, 100);
        if (isiPhone6) {
            viewRect = CGRectMake(6 + 91.5 * self.x, 15 + 121 * self.y, 88.5, 118);
        } else if (isiPhone6Plus) {
            viewRect = CGRectMake(7 + 100 * self.x, 15 + 132.5 * self.y, 97, 129.5);
        }
        
        PhotoDetailView * view = [[PhotoDetailView alloc] initWithImage:[dict objectForKey:@"url"] andID:[dict objectForKey:@"id"] andFrame:viewRect];
        [self.arrayButtons addObject:view];
        
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
        [UIView animateWithDuration:0.3 animations:^{
            self.imageView.imageView.image = sender.imageView.image;
            self.imageView.alpha = 1.f;
        }];
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

- (void) allClear {
    
    self.countDelete = 0;
    self.buttonConfDelete.alpha = 0;
    
    for (PhotoDetailView * view in self.arrayButtons) {
        view.imageViewDelete.alpha = 0;
        view.buttonPhoto.isBool = NO;
    }
    
    [self.arrayDelete removeAllObjects];
}





@end
