//
//  JXStoreInfoViewController.m
//  JXShopDemo
//
//  Created by mac on 17/6/2.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXStoreInfoViewController.h"
#import "JXStoreInfoHeaderView.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "JXStoreHomeViewController.h"
#import "UIView+Extension.h"



static CGFloat const kMaxOffset = 230;
@interface JXStoreInfoViewController ()<JXStoreHomeViewControllerDelegate>

/**
 替换导航条View
 */
@property(nonatomic, strong)JXStoreInfoHeaderView *brandHeaderView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property(nonatomic, assign) CGFloat lastCollectionViewOffsetY;



@end

@implementation JXStoreInfoViewController

#pragma mark - lazy load

- (JXStoreInfoHeaderView *)brandHeaderView{
    if (_brandHeaderView == nil) {
        _brandHeaderView = [[JXStoreInfoHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 64)];
        _brandHeaderView.backgroundColor = [UIColor clearColor];
        kWeakSelf(self);
        _brandHeaderView.goBackBlock = ^(){
            
            [weakself.navigationController popViewControllerAnimated:YES];
        };
    }
    return _brandHeaderView;
}


- (SDCycleScrollView *)cycleScrollView {
    
    if (!_cycleScrollView) {
        
        NSMutableArray *imageMutableArray = [NSMutableArray array];
        for (int i = 1; i<9; i++) {
            NSString *imageName = [NSString stringWithFormat:@"cycle_%02d.jpg",i];
            [imageMutableArray addObject:imageName];
        }
        
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenW, 230) imageNamesGroup:imageMutableArray];
        
        
    }
    return _cycleScrollView;
}

#pragma mark - cycle life

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加所有的子控制器
    [self setupAllChildViewController];
    
//    self.brandHeaderView.collectViews = self.collectionViews;
    
    [self.view addSubview:self.cycleScrollView];
    [self.view addSubview:self.brandHeaderView];
    
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;

}



#pragma mark - 私有方法


- (void)setupAllChildViewController{
    
    JXStoreHomeViewController *vc = [[JXStoreHomeViewController alloc]init];
    vc.title = @"店铺首页";
    [self addChildViewController:vc];
    
    JXStoreHomeViewController *vc1 = [[JXStoreHomeViewController alloc]init];
    vc1.title = @"新品上架";
    [self addChildViewController:vc1];
    
    JXStoreHomeViewController *vc2 = [[JXStoreHomeViewController alloc]init];
    vc2.title = @"全部宝贝";
    [self addChildViewController:vc2];
    
    JXStoreHomeViewController *vc3 = [[JXStoreHomeViewController alloc]init];
    vc3.title = @"店铺详情";
    [self addChildViewController:vc3];
    
    vc.homeDelegate = self;
    vc2.homeDelegate = self;
    vc3.homeDelegate = self;
    vc1.homeDelegate = self;
    
}



#pragma mark - JXStoreHomeViewControllerDelegate
- (void)collectionViewoffsetY:(CGFloat)offsetY homeVC:(JXStoreHomeViewController *)homeVC{
    
    /// 设置offsetY
    self.brandHeaderView.offsetY = offsetY;
    
    self.lastCollectionViewOffsetY = offsetY;
    
            if ( offsetY>=0 && offsetY<=kMaxOffset) {
    
                self.cycleScrollView.frame = CGRectMake(0, 0-offsetY, kScreenW, 230);
                
                CGFloat topOffetY = kMaxOffset - offsetY;
                
                if (topOffetY <= 64) {
                    topOffetY = 64;
                }
                self.topView.frame = CGRectMake(0, topOffetY, kScreenW, 44);
    
            }else if( offsetY < 0){
    
                self.cycleScrollView.frame = CGRectMake(0, 0, kScreenW, 230);
                 self.topView.frame = CGRectMake(0, kMaxOffset, kScreenW, 44);
    
            }else if (offsetY > kMaxOffset){
    
    
                self.cycleScrollView.frame = CGRectMake(0, -kMaxOffset, kScreenW, 230);
                self.topView.frame = CGRectMake(0, 64, kScreenW, 44);
            }

}



@end
