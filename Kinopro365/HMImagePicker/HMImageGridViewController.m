//
//  HMImageGridViewController.m
//  HMImagePicker
//
//  Created by 刘凡 on 16/1/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMImageGridViewController.h"
#import "HMImagePickerGlobal.h"
#import "HMImageGridCell.h"
#import "HMImageGridViewLayout.h"
#import "HMSelectCounterButton.h"
#import "HMPreviewViewController.h"
#import "UILabel+TitleCategory.h"
#import "Macros.h"
#import "HexColors.h"

static NSString *const HMImageGridViewCellIdentifier = @"HMImageGridViewCellIdentifier";

@interface HMImageGridViewController () <HMImageGridCellDelegate, HMPreviewViewControllerDelegate>

@end

@implementation HMImageGridViewController {
    /// 相册模型
    HMAlbum *_album;
    /// 选中素材数组
    NSMutableArray <PHAsset *>*_selectedAssets;
    /// 最大选择图像数量
    NSInteger _maxPickerCount;
    
    /// 预览按钮
    UIBarButtonItem *_previewItem;
    /// 完成按钮
    UIBarButtonItem *_doneItem;
    /// 选择计数按钮
    HMSelectCounterButton *_counterButton;
}

#pragma mark - 构造函数
- (instancetype)initWithAlbum:(HMAlbum *)album
               selectedAssets:(NSMutableArray<PHAsset *> *)selectedAssets
               maxPickerCount:(NSInteger)maxPickerCount {
    
    HMImageGridViewLayout *layout = [[HMImageGridViewLayout alloc] init];
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        _album = album;
        _selectedAssets = selectedAssets;
        _maxPickerCount = maxPickerCount;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
}

#pragma mark - HMImageGridCellDelegate
- (void)imageGridCell:(HMImageGridCell *)cell didSelected:(BOOL)selected {
    
    // 判断是否已经到达最大数量
    if (_selectedAssets.count == _maxPickerCount && selected) {
 
        

        

        
        cell.selectedButton.selected = NO;
        
        return;
    }
    
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    PHAsset *asset = [_album assetWithIndex:indexPath.item];
    
    if (selected) {
        [_selectedAssets addObject:asset];
    } else {
        [_selectedAssets removeObject:asset];
    }
    
    [self updateCounter];
}

/// 更新计数显示
- (void)updateCounter {
    _counterButton.count = _selectedAssets.count;
    _doneItem.enabled = _counterButton.count > 0;
    _previewItem.enabled = _counterButton.count > 0;
    
    if (_doneItem.enabled) {
        [_doneItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIFont fontWithName:FONT_ISTOK_BOLD size:16.0], NSFontAttributeName,
                                           [UIColor hx_colorWithHexRGBAString:COLOR_ALERT_BUTTON_COLOR], NSForegroundColorAttributeName,
                                           nil]
                                 forState:UIControlStateNormal];
        [_previewItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIFont fontWithName:FONT_ISTOK_BOLD size:16.0], NSFontAttributeName,
                                           [UIColor hx_colorWithHexRGBAString:COLOR_ALERT_BUTTON_COLOR], NSForegroundColorAttributeName,
                                           nil]
                                 forState:UIControlStateNormal];
    } else {
        [_doneItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIFont fontWithName:FONT_ISTOK_BOLD size:16.0], NSFontAttributeName,
                                           [UIColor lightGrayColor], NSForegroundColorAttributeName,
                                           nil]
                                 forState:UIControlStateNormal];
        [_previewItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIFont fontWithName:FONT_ISTOK_BOLD size:16.0], NSFontAttributeName,
                                           [UIColor lightGrayColor], NSForegroundColorAttributeName,
                                           nil]
                                 forState:UIControlStateNormal];
    }
}

#pragma mark - HMPreviewViewControllerDelegate
- (BOOL)previewViewController:(HMPreviewViewController *)previewViewController didChangedAsset:(PHAsset *)asset selected:(BOOL)selected {
    
    // 更新选中素材数组
    if (selected) {
        if (_selectedAssets.count == _maxPickerCount) {

            
  
            
            return NO;
        }
        [_selectedAssets addObject:asset];
    } else {
        [_selectedAssets removeObject:asset];
    }
    [self updateCounter];
    
    // 根据 asset 查找索引
    NSInteger index = [_album indexWithAsset:asset];
    if (index == NSNotFound) {
        NSLog(@"没有在当前相册找到素材");
        return YES;
    }
    
    // 更新 Cell 显示
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    
    HMImageGridCell *cell = (HMImageGridCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    cell.selectedButton.selected = selected;
    
    return YES;
}

- (NSMutableArray<PHAsset *> *)previewViewControllerSelectedAssets {
    return _selectedAssets;
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _album.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HMImageGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HMImageGridViewCellIdentifier forIndexPath:indexPath];
    
    cell.imageView.image = [_album emptyImageWithSize:cell.bounds.size];
    [_album requestThumbnailWithAssetIndex:indexPath.item Size:cell.bounds.size completion:^(UIImage * _Nonnull thumbnail) {
        cell.imageView.image = thumbnail;
    }];
    cell.selectedButton.selected = [_selectedAssets containsObject:[_album assetWithIndex:indexPath.item]];
    
    cell.delegate = self;
    
    return cell;
}

#pragma mark - UICollectionView Delegate
- (void)showPreviewControllerWithIndexPath:(NSIndexPath *)indexPath {
    
    HMPreviewViewController *preview = [[HMPreviewViewController alloc]
                                        initWithAlbum:_album
                                        selectedAssets:_selectedAssets
                                        maxPickerCount:_maxPickerCount
                                        indexPath:indexPath];
    
    preview.delegate = self;
    
    [self.navigationController pushViewController:preview animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self showPreviewControllerWithIndexPath:indexPath];
}

#pragma mark - 监听方法
- (void)clickPreviewButton {
    [self showPreviewControllerWithIndexPath:nil];
}

- (void)clickFinishedButton {
    [[NSNotificationCenter defaultCenter] postNotificationName:HMImagePickerDidSelectedNotification object:self userInfo:nil];
}

- (void)clickCloseButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 设置界面
- (void)prepareUI {
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    UILabel * CustomText = [[UILabel alloc]initWithTitle:@"Список фото"];
    self.navigationItem.titleView = CustomText;
    
    // 工具条
    _previewItem = [[UIBarButtonItem alloc] initWithTitle:@"Просмотр" style:UIBarButtonItemStylePlain target:self action:@selector(clickPreviewButton)];
    
    _previewItem.enabled = NO;
    
    [_previewItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIFont fontWithName:FONT_ISTOK_BOLD size:16.0], NSFontAttributeName,
                                       [UIColor lightGrayColor], NSForegroundColorAttributeName,
                                       nil]
                             forState:UIControlStateNormal];
    
    
    _counterButton = [[HMSelectCounterButton alloc] init];
    UIBarButtonItem *counterItem = [[UIBarButtonItem alloc] initWithCustomView:_counterButton];
    
    _doneItem = [[UIBarButtonItem alloc] initWithTitle:@"Сохранить" style:UIBarButtonItemStylePlain target:self action:@selector(clickFinishedButton)];
    
    
    [_doneItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont fontWithName:FONT_ISTOK_BOLD size:16.0], NSFontAttributeName,
                                          [UIColor lightGrayColor], NSForegroundColorAttributeName,
                                          nil]
                                forState:UIControlStateNormal];
    
    
    _doneItem.enabled = NO;
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.toolbarItems = @[_previewItem, spaceItem, counterItem, _doneItem];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonItemStylePlain target:self action:@selector(backMethod)];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIFont fontWithName:FONT_ISTOK_BOLD size:16.0], NSFontAttributeName,
                                                                   [UIColor whiteColor], NSForegroundColorAttributeName,
                                                                   nil]
                                                         forState:UIControlStateNormal];
    
    
    
    // 取消按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Отмена" style:UIBarButtonItemStylePlain target:self action:@selector(clickCloseButton)];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIFont fontWithName:FONT_ISTOK_BOLD size:16.0], NSFontAttributeName,
                                       [UIColor whiteColor], NSForegroundColorAttributeName,
                                       nil]
                             forState:UIControlStateNormal];
    
    // 注册可重用 cell
    [self.collectionView registerClass:[HMImageGridCell class] forCellWithReuseIdentifier:HMImageGridViewCellIdentifier];
    
    // 更新计数器显示
    [self updateCounter];
}

- (void) backMethod {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
