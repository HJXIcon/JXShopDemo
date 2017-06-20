//
//  JXShopDetailInfo.m
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXShopDetailInfo.h"

@implementation JXShopDetailInfo

+ (instancetype)testInfo{
    JXShopDetailInfo *info = [[JXShopDetailInfo alloc]init];
    info.bgImage = @"head-bg";
    info.icon = @"1";
    info.name = @"二次元动漫旗舰店";
    info.level = 1000;
    info.fansCount = 1000;
    info.isConcern = false;
    return info;
}

@end
