//
//  JXShopDetailUserCase.h
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXShopDetailInfo.h"

@interface JXShopDetailUserCase : NSObject
- (void)shopInfoRequestWithShopId:(long)shopId
                          Success:(void(^)(JXShopDetailInfo *))successBlock
                             fail:(void(^)(NSString *errorMsg))failBlock;

- (void)shopProductInfoRequestWithShopId:(long)shopId
                                    type:(NSInteger)type
                                   order:(BOOL)isDesc
                                 pageNum:(NSInteger)pageNum
                                pageSize:(NSInteger)pageSize
                                 Success:(void(^)(NSArray *))successBlock
                                    fail:(void(^)(NSString *errorMsg))failBlock;

@end
