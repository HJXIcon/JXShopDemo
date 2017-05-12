//
//  JXShopCarTableHeaderView.h
//  JXShopDemo
//
//  Created by mac on 17/4/21.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JXShopCarTableHeaderView : UITableViewHeaderFooterView

/** 点击店铺选择按钮回调*/
@property (nonatomic, copy)void(^clickStoreNameBlock)();
/** 点击店铺名字回调*/
@property (nonatomic, copy)void(^selectStoreBlock)();

+ (CGFloat)getCarHeaderHeight;

@end
