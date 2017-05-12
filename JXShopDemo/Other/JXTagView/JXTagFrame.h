//
//  JXTagFrame.h
//  JXShopDemo
//
//  Created by mac on 17/4/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// 字体大小
#define TagsTitleFont [UIFont systemFontOfSize:13]

@interface JXTagFrame : NSObject

/** 标签名字数组 */
@property (nonatomic, strong) NSArray <NSString *> *tagsArray;

/** 标签间距 default is 10*/
@property (nonatomic, assign) CGFloat tagsMargin;

/** 标签行间距 default is 10*/
@property (nonatomic, assign) CGFloat tagsLineSpacing;

/** 标签最小内边距 default is 10*/
@property (nonatomic, assign) CGFloat tagsMinPadding;




#pragma mark - *******  readonly
/** 标签frame数组 */
@property (nonatomic, strong, readonly) NSMutableArray *tagsFrames;

/** 全部标签的高度 */
@property (nonatomic, assign, readonly) CGFloat tagsTotalHeight;


@end
