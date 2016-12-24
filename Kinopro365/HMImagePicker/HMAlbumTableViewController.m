//
//  HMAlbumTableViewController.m
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMAlbumTableViewController.h"
#import "HMAlbum.h"
#import "HMAlbumTableViewCell.h"
#import "HMImageGridViewController.h"
#import "UILabel+TitleCategory.h"
#import "Macros.h"

static NSString *const HMAlbumTableViewCellIdentifier = @"HMAlbumTableViewCellIdentifier";

@interface HMAlbumTableViewController ()

@end

@implementation HMAlbumTableViewController {
    NSArray<HMAlbum *> *_assetCollection;
    NSMutableArray <PHAsset *> *_selectedAssets;
}

- (instancetype)initWithSelectedAssets:(NSMutableArray<PHAsset *> *)selectedAssets {
    self = [super init];
    if (self) {
        _selectedAssets = selectedAssets;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Альбомы"];
    self.navigationItem.titleView = CustomText;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Отмена" style:UIBarButtonItemStylePlain target:self action:@selector(clickCloseButton)];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont fontWithName:FONT_ISTOK_BOLD size:16.0], NSFontAttributeName,
                                        [UIColor whiteColor], NSForegroundColorAttributeName,
                                        nil] 
                              forState:UIControlStateNormal];
    
    
    [self fetchAssetCollectionWithCompletion:^(NSArray<HMAlbum *> *assetCollection, BOOL isDenied) {
        if (isDenied) {

            return;
        }
        _assetCollection = assetCollection;
        
        [self.tableView reloadData];
        
        if (_assetCollection.count > 0) {
            HMImageGridViewController *grid = [[HMImageGridViewController alloc]
                                               initWithAlbum:_assetCollection[0]
                                               selectedAssets:_selectedAssets
                                               maxPickerCount:_maxPickerCount];
            
            [self.navigationController pushViewController:grid animated:NO];
        }
    }];
    
    [self.tableView registerClass:[HMAlbumTableViewCell class] forCellReuseIdentifier:HMAlbumTableViewCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 80;
}

- (void)clickCloseButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 加载相册
- (void)fetchAssetCollectionWithCompletion:(void (^)(NSArray<HMAlbum *> *, BOOL))completion {
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    switch (status) {
        case PHAuthorizationStatusAuthorized:
            [self fetchResultWithCompletion:completion];
            break;
        case PHAuthorizationStatusNotDetermined:
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                [self fetchResultWithCompletion:completion];
            }];
        }
            break;
        default:
            completion(nil, YES);
            break;
    }
}

- (void)fetchResultWithCompletion:(void (^)(NSArray<HMAlbum *> *, BOOL))completion {
    // 相机胶卷
    PHFetchResult *userLibrary = [PHAssetCollection
                                  fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                  subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary
                                  options:nil];
    
    // 同步相册
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"localizedTitle" ascending:NO]];
    
    PHFetchResult *syncedAlbum = [PHAssetCollection
                                  fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                  subtype:PHAssetCollectionSubtypeAlbumSyncedAlbum
                                  options:options];
    
    NSMutableArray *result = [NSMutableArray array];
    [userLibrary enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [result addObject:[HMAlbum albumWithAssetCollection:obj]];
    }];
    [syncedAlbum enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [result addObject:[HMAlbum albumWithAssetCollection:obj]];
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{ completion(result.copy, NO); });
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _assetCollection.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HMAlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HMAlbumTableViewCellIdentifier forIndexPath:indexPath];
    
    cell.album = _assetCollection[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HMAlbum *album = _assetCollection[indexPath.row];
    HMImageGridViewController *grid = [[HMImageGridViewController alloc]
                                       initWithAlbum:album
                                       selectedAssets:_selectedAssets
                                       maxPickerCount:_maxPickerCount];
    
    [self.navigationController pushViewController:grid animated:YES];
}

@end
