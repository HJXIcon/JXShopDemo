//
//  JXStoreBaseMenuViewController.h
//  JXShopDemo
//
//  Created by mac on 17/6/2.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXStoreInfoHeaderView.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface JXStoreBaseMenuViewController : UIViewController

@property (nonatomic, weak) UIScrollView *topView;

/**
 替换导航条View
 */
@property(nonatomic, strong)JXStoreInfoHeaderView *brandHeaderView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic, weak) UICollectionView *collectionView;
@end
