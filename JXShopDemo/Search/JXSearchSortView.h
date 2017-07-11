//
//  JXSearchSortView.h
//  FishingWorld
//
//  Created by mac on 16/12/22.
//  Copyright © 2016年 zhuya. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^SortBtnCallBack)(NSInteger index);
/**
 搜索排序view
 */
@interface JXSearchSortView : UIView

/** 回调*/
@property (nonatomic, copy) SortBtnCallBack btnClickCallBack;

@end
