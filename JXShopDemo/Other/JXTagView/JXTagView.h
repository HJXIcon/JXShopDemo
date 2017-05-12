//
//  JXTagView.h
//  JXShopDemo
//
//  Created by mac on 17/4/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXTagFrame.h"

@interface JXTagView : UIView
@property (nonatomic, strong) JXTagFrame *tagsFrame;
/** 选中tag回调*/
@property (nonatomic, copy)void(^selectIndexBlock)(NSInteger index);
@end
