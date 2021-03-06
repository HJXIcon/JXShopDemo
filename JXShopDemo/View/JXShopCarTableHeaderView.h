//
//  JXShopCarTableHeaderView.h
//  JXShopDemo
//
//  Created by mac on 17/4/21.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXShopcartBrandModel;


typedef void(^JXShopcartHeaderViewSelectBlock)(BOOL isSelected);
typedef void(^JXShopcartHeaderViewNameClickBlock)();

@interface JXShopCarTableHeaderView : UITableViewHeaderFooterView

/** 点击店铺选择按钮回调*/
@property (nonatomic, copy)JXShopcartHeaderViewSelectBlock selectStoreBlock;

/** 点击店铺名字回调*/
@property (nonatomic, copy)JXShopcartHeaderViewNameClickBlock clickNameBlock;


@property(nonatomic, strong) JXShopcartBrandModel *model;

+ (CGFloat)getCarHeaderHeight;

@end
