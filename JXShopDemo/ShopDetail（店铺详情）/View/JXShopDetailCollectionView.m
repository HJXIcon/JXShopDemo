//
//  JXShopDetailCollectionView.m
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXShopDetailCollectionView.h"
#import "JXShopDetailCollectionViewModel.h"
#import "JXCommonCollectionView.h"
#import "JXShopProductCollectionViewCell.h"

@interface JXShopDetailCollectionView ()

@property (nonatomic,strong) __kindof JXShopDetailCollectionViewModel *viewModel;
@property (nonatomic,copy) void (^loadMoreBlock)();
@property (nonatomic,assign) NSInteger totalPage;
@property (nonatomic,assign) BOOL isAddedFooter;

@end

@implementation JXShopDetailCollectionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _viewModel = [[JXShopDetailCollectionViewModel alloc]init];
        [self configureUI];
        [self configureContraints];
        [self.collectionView registerClass:[JXShopProductCollectionViewCell class] forCellWithReuseIdentifier:@"ShopProductCollectionViewCell"];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CollectioViewFooterIdentifier"];
    }
    return self;
}

- (instancetype)initWithLoadMoreBlock:(void(^)()) loadMoreBlock{
    self = [self initWithFrame:CGRectZero];
    if(self){
        _loadMoreBlock = loadMoreBlock;
    }
    return self;
}

- (void)configureUI{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[JXCommonCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    self.backgroundColor = [UIColor colorWithARGB:0xececec];
    [self addSubview:_collectionView];
    
    //    _scrollToTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [_scrollToTopBtn setBackgroundImage:[UIImage imageNamed:@"scroll_to_top_bg"] forState:UIControlStateNormal];
    //    [_scrollToTopBtn setBackgroundImage:[UIImage imageNamed:@"scroll_to_top_selected_bg"] forState:UIControlStateHighlighted];
    //    [_scrollToTopBtn addTarget:self action:@selector(scrollToTop) forControlEvents:UIControlEventTouchUpInside];
    //    _scrollToTopBtn.hidden = true;
    //    [self addSubview:_scrollToTopBtn];
    //    [self addSubview:self.pageShowView];
}
- (void)scrollToTop{
    [_collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (void)configureContraints{
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    //    [_scrollToTopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.equalTo(self).offset(-10);
    //        make.bottom.equalTo(self).offset(-20);
    //        make.size.mas_equalTo(CGSizeMake(35, 35));
    //    }];
    //
    //    [_pageShowView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerX.equalTo(self);
    //        make.bottom.equalTo(self).offset(-20);
    //        make.size.mas_equalTo(CGSizeMake(47, 25));
    //    }];
}

- (void)bindData:(id)data{
    [self bindData:data needHud:true];
}

- (void)bindData:(id)data needHud:(BOOL)needHud{
    self.viewModel.dataSource = data;
    //    NSInteger count = self.viewModel.dataSource.count;
    //    if(!self.viewModel.dataSource ){
    //        if(needHud)[self showHudWithHint:nil];
    //    }else if(count>0 ){
    //        [self hideHud];
    //        _showDefaultView.hidden = true;
    //    }else {//
    //        [self.collectionView removeFooter];
    //        self.collectionView.scrollEnabled = false;
    //        [self showNodataDefaultView];
    //    }
    [self.collectionView reloadData];
}

#pragma mark -
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
    JXShopProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopProductCollectionViewCell" forIndexPath:indexPath];
    JXShopProductCollectionCellViewData *viewData = [self.viewModel.dataSource objectAtIndex:indexPath.item];
    [cell bindData:viewData];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier;
    UICollectionReusableView *kindView = [[UICollectionReusableView alloc]init];
    if ([kind isEqualToString: UICollectionElementKindSectionFooter ]){
        reuseIdentifier = @"CollectioViewFooterIdentifier";
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
        kindView = view;
    }
    
    return kindView;
    
}

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(kScreenWidth, 0);
}

#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellW = (kScreenWidth-0)/2;
    CGFloat cellH = 270*(cellW/187);
    return CGSizeMake(cellW , cellH);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}
#pragma mark ---- UICollectionViewDelegate


- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"进入到商品详情页");
}

#pragma mark -
#pragma mark --- scrollDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    _translationBlock(y);
    if(!_couldScroll){
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
    //    float currentPosition = scrollView.contentOffset.y;
    //    _scrollToTopBtn.hidden = !(currentPosition>scrollView.height);
    //
    //    NSInteger currentPage = (self.viewModel.dataSource.count-1)/20 +1;
    //    CGFloat offset = currentPosition<0?0:currentPosition;
    //    [self.pageShowView setCurrentPage:((offset/scrollView.contentSize.height)*currentPage +1) totalPage:_totalPage];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    //    _pageShowView.hidden = false;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //    _pageShowView.hidden = true;
}
@end
