//
//  JXCommonCollectionView.m
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXCommonCollectionView.h"
#import "JXCommonCollectionViewModel.h"
#import "JXShopProductCollectionViewCell.h"

static NSString *const  ShopProductCollectionViewCell = @"GMPShopProductCollectionViewCell";

@interface JXCommonCollectionView () <UICollectionViewDataSource>

@property (nonatomic, strong) JXCommonCollectionViewModel *viewModel;

@end

@implementation JXCommonCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if(self){
        if(!_viewModel){
            _viewModel = [[JXCommonCollectionViewModel alloc]init];
            self.delegate = _viewModel;
            self.dataSource = self;
        }
        
        self.backgroundColor = [UIColor colorWithARGB:0xececec];
        //        self.backgroundColor = [UIColor whiteColor];
        
        [self registerClass:[JXShopProductCollectionViewCell class] forCellWithReuseIdentifier:ShopProductCollectionViewCell];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if(self){
        if(!_viewModel){
            _viewModel = [[JXCommonCollectionViewModel alloc]init];
            self.delegate = _viewModel;
            self.dataSource = self;
        }
        
        self.backgroundColor = [UIColor colorWithARGB:0xe4e4e4];
        //        self.backgroundColor = [UIColor whiteColor];
        
        [self registerClass:[JXShopProductCollectionViewCell class] forCellWithReuseIdentifier:ShopProductCollectionViewCell];
    }
    return self;
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewModel.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JXShopProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ShopProductCollectionViewCell forIndexPath:indexPath];
    [cell bindData:[self.viewModel.dataSource objectAtIndex:indexPath.item]];
    return cell;
}
@end

