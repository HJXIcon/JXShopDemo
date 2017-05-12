//
//  JXShopViewModel.h
//  JXShopDemo
//
//  Created by mac on 17/4/21.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class JXGoodAttrModel;

/*
 职责:对原始数据model的包装,包装成为view可以(=号赋值)使用的数据,事件的源头以及接收事件的源头
 */

@interface JXShopViewModel : NSObject

///数据请求到了
- (void)requestData:(void(^)(NSArray <JXGoodAttrModel *> *datas))completion;


@end
