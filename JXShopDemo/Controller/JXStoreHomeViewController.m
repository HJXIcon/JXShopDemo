//
//  JXStoreHomeViewController.m
//  JXShopDemo
//
//  Created by mac on 17/6/2.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXStoreHomeViewController.h"


@interface JXStoreHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation JXStoreHomeViewController

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {

        
        // 设置布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kScreenW / 2 - 20, kScreenW / 2 - 20);
        layout.headerReferenceSize = CGSizeMake(kScreenW, 230 + 44);
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 10;
        
        // 指示器，cell间距，分页
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.scrollsToTop = NO;
        
        _collectionView.backgroundColor = [UIColor greenColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        // 状态条和scrollView边距的距离（暂时还没想明白为什么要有这个）。
        // 136 + 46 =
        _collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(230 + 44, 0, 0, 0);
        
        
        // 注册cell
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        /// 注册头部视图
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    
    /// 监听
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
}



- (void)dealloc{
    [self.collectionView removeObserver:self forKeyPath:@"contentOffset"];
}

#pragma observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    UICollectionView *collectionView = (UICollectionView *)object;
    
    if (collectionView != self.collectionView) {
        return;
    }
    
    
    if (![keyPath isEqualToString:@"contentOffset"]) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    
    CGFloat collectionViewoffsetY = collectionView.contentOffset.y;
    
    if ([self.homeDelegate respondsToSelector:@selector(collectionViewoffsetY:homeVC:)]) {
        [self.homeDelegate collectionViewoffsetY:collectionViewoffsetY homeVC:self];
    }
 
    
    
}


#pragma mark - 数据源


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor redColor];
    return cell;
}




- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    
    return header;
}



@end
