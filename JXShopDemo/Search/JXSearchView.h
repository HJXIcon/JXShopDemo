//
//  JXSearchView.h
//  FishingWorld
//
//  Created by mac on 16/12/21.
//  Copyright © 2016年 zhuya. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^Blo)(NSString *s1,UIColor *c);
typedef void (^JXSearchButtonClickCallback)(UIButton *button);
@interface JXSearchView : UIView

/** searchButtonClickCallback*/
@property (nonatomic, copy) JXSearchButtonClickCallback searchButtonClickCallback;

/** 高度*/
@property (nonatomic, assign) CGFloat searchHeight;


/**
 快速创建

 @param frame searchView的frame
 @param searchTitleText 文本
 @param searchButtonTitleTexts 按钮文本
 @param searchButtonClickCallback 回调
 @return searchView
 */
- (instancetype)initWithFrame:(CGRect)frame searchTitleText:(NSString *)searchTitleText searchButtonTitleTexts:(NSArray *)searchButtonTitleTexts searchButtonClickCallback:(JXSearchButtonClickCallback) searchButtonClickCallback;

@end
