//
//  JXStoreInfoHeaderView.h
//  JXShopDemo
//
//  Created by mac on 17/6/2.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StoreInfHeaderGoBackBlock)();

/**
 替换导航条
 */
@interface JXStoreInfoHeaderView : UIView

/** offset*/
@property (nonatomic, assign)CGFloat offsetY;


/** goback*/
@property (nonatomic, copy)StoreInfHeaderGoBackBlock goBackBlock;
@end
