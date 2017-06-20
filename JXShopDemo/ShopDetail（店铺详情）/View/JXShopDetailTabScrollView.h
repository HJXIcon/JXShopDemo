//
//  JXShopDetailTabScrollView.h
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXShopDetailTabScrollView : UIView

- (instancetype)initWithShopId:(long)shopId;

- (void)reloadData;

- (void)loadDefaultData;

//- (void)setContentOffset:(CGFloat)offset;

- (void)setCouldScroll:(BOOL)scrollEnabled;


@end
