//
//  JXGoodAttrModel.m
//  JXShopDemo
//
//  Created by mac on 17/4/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXGoodAttrModel.h"
#import "JXTagFrame.h"

@implementation JXGoodAttrModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"attr_values" : @"JXGoodAttrValueModel",
             };
}


- (JXTagFrame *)tagFrame{
    
    JXTagFrame *tagFrame = [[JXTagFrame alloc]init];
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (JXGoodAttrValueModel *model in self.attr_values) {
        [tmpArray addObject:model.attr_value];
    };
    
    tagFrame.tagsArray = tmpArray;
    
    return tagFrame;
}


@end

@implementation JXGoodAttrValueModel


@end
