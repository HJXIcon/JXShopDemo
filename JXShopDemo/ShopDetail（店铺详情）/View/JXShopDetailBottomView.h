//
//  JXShopDetailBottomView.h
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXShopDetailBottomView : UIView
@property (nonatomic,strong) NSMutableArray *buttonArray;

- (instancetype)initWithTitleArray:(NSArray *)titleArray;
@end
