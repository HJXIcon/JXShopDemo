//
//  JXShopDetailCollectionView.h
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCommonCollectionView.h"
@interface JXShopDetailCollectionView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) JXCommonCollectionView *collectionView;
@property (nonatomic,assign) BOOL couldScroll;
@property (nonatomic,copy) void (^translationBlock)(CGFloat offset);

//@property (nonatomic,strong,readonly) __kindof GMShopDetailCollectionViewModel *viewModel;
/**
 加载更多
 */
- (instancetype)initWithLoadMoreBlock:(void(^)()) loadMoreBlock;
//- (instancetype)initWithFrame:(CGRect)frame viewModel:(GMShopDetailCollectionViewModel *)viewModel;
/**
 根据类型去判断当前页面需要的viewModel
 */
//- (Class)viewModelClass;
/**
 绑定数据
 */
- (void)bindData:(id)data;
/**
 设置页数和总页数
 */
- (void)setTotalPage:(NSInteger)totalPage;
/**
 设置默认缺省页
 */
- (void)showNoNetWorkDefaultView;
/**
 设置CollectionView的HeaderView的高度
 */
- (CGFloat)collectionHeaderHeight;
//- (void)setContentOffset:(CGFloat)offset;



@end
