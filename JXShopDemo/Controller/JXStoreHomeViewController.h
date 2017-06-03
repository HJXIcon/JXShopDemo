//
//  JXStoreHomeViewController.h
//  JXShopDemo
//
//  Created by mac on 17/6/2.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JXStoreHomeViewController;
@protocol JXStoreHomeViewControllerDelegate <NSObject>
- (void)collectionViewoffsetY:(CGFloat)offsetY homeVC: (JXStoreHomeViewController *)homeVC;

@end
/**
 店铺首页
 */
@interface JXStoreHomeViewController : UIViewController

/** delegate*/
@property (nonatomic, weak)id<JXStoreHomeViewControllerDelegate> homeDelegate;
@property (nonatomic, strong) UICollectionView *collectionView;

@end
