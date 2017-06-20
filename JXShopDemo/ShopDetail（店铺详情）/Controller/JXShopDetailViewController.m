//
//  JXShopDetailViewController.m
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXShopDetailViewController.h"
#import "JXShopDetailNavigationBar.h"
#import "JXShopDetailHeaderView.h"
#import "JXShopDetailScrollView.h"
#import "JXShopDetailBottomView.h"
#import "JXShopDetailViewModel.h"
#import "JXShopDetailCollectionView.h"
#import "JXShopDetailInfo.h"
#import "LYSelectTabBar.h"
#import "JXShopDetailTabScrollView.h"



static CGFloat const HeaderHeight = 95;
static CGFloat const TabBarHeight = 60;
static CGFloat const TabBarTopHeight = 35;

@interface JXShopDetailViewController () <LYSelectTabBarDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) JXShopDetailNavigationBar *navigationBar;
@property (nonatomic,strong) UIScrollView *mianScrollView;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) JXShopDetailHeaderView *headerView;
@property (nonatomic,strong) LYSelectTabBar *selectBar;
@property (nonatomic,strong) JXShopDetailScrollView *scrollView;
@property (nonatomic,strong) JXShopDetailBottomView *bottomView;

@property (nonatomic,strong) JXShopDetailViewModel *viewModel;


@end

@implementation JXShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.viewModel = [[JXShopDetailViewModel alloc]init];
    
    [self.view addSubview:self.navigationBar];
    [self.view addSubview:self.mianScrollView];
    
    _contentView = [[UIView alloc]init];
    [self.mianScrollView addSubview:_contentView];
    _headerView = [[JXShopDetailHeaderView alloc]init];
    [_contentView addSubview:_headerView];
    [_contentView addSubview:self.selectBar];
    
    [self configureScrollView];
    [self configureBottomView];
    
    [self configureContraints];
    [self bindViewModel];
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureScrollView{
    _scrollView = [[JXShopDetailScrollView alloc]initWithSubViews:@[
                                                                    [[JXShopDetailCollectionView alloc]init],
                                                                    [[JXShopDetailTabScrollView alloc]initWithShopId:0],
                                                                    [[JXShopDetailCollectionView alloc]init],
                                                                    [[JXShopDetailCollectionView alloc]init]]];
    [_contentView addSubview:self.scrollView];
    
    @weakify(self)
    [self.scrollView setTranslationBlock:^(CGFloat offset) {
        @strongify(self)
        CGFloat y = self.mianScrollView.contentOffset.y;
        if(offset>0){
            self.mianScrollView.contentOffset = CGPointMake(0, MIN((y+offset),(self.mianScrollView.contentSize.height-self.mianScrollView.frame.size.height)));
        }else if (offset<0){
            self.mianScrollView.contentOffset = CGPointMake(0, MAX((y+offset),0));
        }
        if(offset>0&&!self.scrollView.couldScroll&&y==0){
            self.scrollView.couldScroll = false;
        }else if (offset<0&&self.scrollView.couldScroll&&y>0){
            self.scrollView.couldScroll = false;
        }else if(y>=HeaderHeight+TabBarHeight-TabBarTopHeight){
            self.scrollView.couldScroll = true;
        }else if (y==0){
            self.scrollView.couldScroll = offset<=0?true:false;
        }
    }];
    [self.scrollView setTabBarSelBlock:^(NSInteger index) {
        @strongify(self)
        [self.selectBar setSelectedIndex:index];
        [self.viewModel showTabActionAtIndex:index];
    }];
}

- (void)configureBottomView{
    _bottomView = [[JXShopDetailBottomView alloc]initWithTitleArray:@[@"宝贝分类",@"领金币",@"联系卖家"]];
    [self.view addSubview:self.bottomView];
}

- (void)configureContraints{
    [self.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.equalTo(self.view);
        make.height.equalTo(@64);
    }];
    
    [self.mianScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mianScrollView);
        make.width.equalTo(self.mianScrollView);
    }];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(_contentView);
        make.height.mas_equalTo(HeaderHeight);
    }];
    
    [self.selectBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.top.equalTo(self.headerView.mas_bottom);
        make.height.equalTo(@(TabBarHeight));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(_contentView);
        make.top.equalTo(self.selectBar.mas_bottom).offset(0);
        make.height.equalTo(@(kScreenHeight-64 -TabBarTopHeight -49));
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.scrollView.mas_bottom);
    }];
}

- (void)bindViewModel{
    @weakify(self)
    [RACObserve(self.viewModel,shopInfo) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        JXShopDetailInfo *info = x;
        [self.headerView bindData:info.bgImage icon:info.icon name:info.name level:info.level fansCount:info.fansCount isConcern:info.isConcern];
    }];
    [[RACObserve(self.viewModel, homeDataSource) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id  _Nullable x) {
        JXShopDetailCollectionView *view = (JXShopDetailCollectionView *)[self.scrollView subScorllViewAtIndex:0];
        [view bindData:x];
        [view setTotalPage:self.viewModel.homeTotalPage];
    }];
    [[RACObserve(self.viewModel, newsDataSource) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id  _Nullable x) {
        JXShopDetailCollectionView *view = (JXShopDetailCollectionView *)[self.scrollView subScorllViewAtIndex:2];
        [view bindData:x];
        [view setTotalPage:self.viewModel.newTotalPage];
    }];
    [[RACObserve(self.viewModel, dymicDataSource) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id  _Nullable x) {
        JXShopDetailCollectionView *view = (JXShopDetailCollectionView *)[self.scrollView subScorllViewAtIndex:3];
        [view bindData:x];
        [view setTotalPage:self.viewModel.dymicTotalPage];
    }];
}
#pragma mark -
#pragma mark - getter and setter
- (JXShopDetailNavigationBar *)navigationBar{
    if(!_navigationBar){
        _navigationBar = [[JXShopDetailNavigationBar alloc]init];
        [_navigationBar.backBtn addTarget:self action:@selector(pushBackAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navigationBar;
}

- (LYSelectTabBar *)selectBar{
    if(!_selectBar){
        _selectBar = [[LYSelectTabBar alloc]initTitles:self.viewModel.tabBarTitleArray images:self.viewModel.tabBarTitleImageArray selectImages:self.viewModel.tabBarTitleSelImageArray indicatorImage:nil];
        _selectBar.delegate = self;
        _selectBar.selectedColor = [UIColor colorWithRGB:0xf74600];
        _selectBar.unSelectedColor = [UIColor blackColor];
        _selectBar.font = [UIFont systemFontOfSize:10];
    }
    
    return _selectBar;
}

- (UIScrollView *)mianScrollView{
    if(!_mianScrollView){
        _mianScrollView = [[UIScrollView alloc]init];
        _mianScrollView.delegate = self;
        _mianScrollView.showsVerticalScrollIndicator = NO;
        _mianScrollView.scrollEnabled = false;
        _mianScrollView.bounces = NO;
    }
    return _mianScrollView;
}

#pragma mark - Actions
- (void)pushBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark ---- UISCrolloView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    if(y<=(HeaderHeight+TabBarHeight-TabBarTopHeight)&&y>=HeaderHeight){
        y = -(y-HeaderHeight)/((TabBarHeight-TabBarTopHeight)/10);
        [self.selectBar setButtonImageAlpha:1 - ABS(y)/10];
        [self.selectBar setTitleFontSize:10+ABS(y)/3];
    }else{
        [self.selectBar setButtonImageAlpha:1];
        [self.selectBar setTitleFontSize:10];
    }
}

#pragma mark -
#pragma mark - delegate
- (void)tabBar:(LYSelectTabBar *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to toAssistStatus:(LYTabBatAssistStatus)status{
    NSLog(@"didSelectButtonFrom %ld to %ld",from,to);
    if(from==to) return;
    [self.scrollView showSubView:to];
    [self.viewModel showTabActionAtIndex:to];
}


@end
