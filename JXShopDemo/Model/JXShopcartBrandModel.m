//
//  JXShopcartBrandModel.m
//  JXShopDemo
//
//  Created by mac on 17/5/16.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXShopcartBrandModel.h"
#import <MJExtension/MJExtension.h>

@implementation JXShopcartBrandModel

+ (NSDictionary *)objectClassInArray {
    
    return @{
             @"products":[JXShopcartProductModel class]
             };
}

@end
