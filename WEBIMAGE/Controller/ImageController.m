//
//  ImageController.m
//  WEBIMAGE
//
//  Created by 王通 on 2017/11/17.
//  Copyright © 2017年 王通. All rights reserved.
//

#import "ImageController.h"
#import "ImageCollectionViewCell.h"
#import "ImageShowController.h"

@interface ImageController () <UICollectionViewDataSource, UICollectionViewDelegate, WaterfallLayoutDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) WaterfallLayout *waterfall;
@property (strong, nonatomic) NSMutableArray *disPlayImages;
@property (strong, nonatomic) NSMutableArray *editImages;
@property (strong, nonatomic) NSMutableArray *test;

@end

@implementation ImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建瀑布流布局
    _waterfall = [WaterfallLayout waterFallLayoutWithColumnCount:SET_COLUMN_NUM_DEFAULT_V];
    [_waterfall setColumnSpacing:2 rowSpacing:2 sectionInset:UIEdgeInsetsMake(2, 2, 2, 2)];
    _waterfall.delegate = self;
    
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView setCollectionViewLayout:_waterfall];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)reloadData {
    if (!_disPlayImages) {
        _disPlayImages = [NSMutableArray array];
    } else {
        [_disPlayImages removeAllObjects];
    }
    
    if (!_editImages) {
        _editImages = [NSMutableArray array];
    } else {
        [_editImages removeAllObjects];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __weak typeof(self)weakSelf = self;
        [[DataManager shareDataManager] queryImageWithStatus:ImageStatusNormal finish:^(NSMutableArray *images, BOOL success) {
            __strong typeof(weakSelf)strongSelf = weakSelf;
            if (success) {
                [strongSelf->_disPlayImages addObjectsFromArray:images];
                [strongSelf refreshColumn];
                [strongSelf refreshCollectionView];
            }
        }];
    });
}

- (void)refreshColumn {
    NSInteger columnCount = 0;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeLeft
        || orientation == UIInterfaceOrientationLandscapeRight) {
        columnCount = [[NSUserDefaults standardUserDefaults] integerForKey:SET_COLUMN_NUM_H];
        if (columnCount < 1) {
            columnCount = SET_COLUMN_NUM_DEFAULT_H;
        }
    } else {
        columnCount = [[NSUserDefaults standardUserDefaults] integerForKey:SET_COLUMN_NUM_V];
        if (columnCount < 1) {
            columnCount = SET_COLUMN_NUM_DEFAULT_V;
        }
    }
    
    if ([_disPlayImages count] < columnCount) {
        [_waterfall setColumnCount:[_disPlayImages count]];
    } else if (_waterfall.columnCount != columnCount) {
        [_waterfall setColumnCount:columnCount];
    }
}

- (void)refreshCollectionView {
    [_collectionView reloadData];
}

#pragma mark- WaterfallLayoutDelegate

- (CGFloat)waterfallLayout:(WaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    return itemWidth / [[_disPlayImages[indexPath.item] aspectRatio] floatValue];
}

#pragma mark- UICollectionViewDataSource & UICollectionViewDelegate

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionCellReuseIdentifier" forIndexPath:indexPath];
    [[DataManager shareDataManager] queryImageCompressWithID:[_disPlayImages[indexPath.item] imageID] finish:^(UIImage *image, BOOL success) {
        cell.image.image = image;
    }];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _disPlayImages.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [[DataManager shareDataManager] queryImageWithID:[_disPlayImages[indexPath.item] imageID] finish:^(UIImage *image, BOOL success) {
        ImageShowController *imageShowVC = [[ImageShowController alloc] init];
        imageShowVC.displayImage = image;
        [self presentViewController:imageShowVC animated:YES completion:^{
        }];
    }];
}

#pragma mark- UIViewControllerDelegate

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self refreshColumn];
    [self refreshCollectionView];
}

@end
