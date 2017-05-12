//
//  JXGoodAttrModel.h
//  JXShopDemo
//
//  Created by mac on 17/4/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JXGoodAttrValueModel,JXTagFrame;

/// 一级属性
@interface JXGoodAttrModel : NSObject

/** 属性名 */
@property (nonatomic, strong) NSString *attr_name;
/** 属性ID */
@property (nonatomic, strong) NSString *attr_id;
/** 属性 */
@property (nonatomic, strong) NSArray <JXGoodAttrValueModel *>*attr_values;

/** JXTagFrame数组*/
@property (nonatomic, strong, readonly) JXTagFrame *tagFrame;

@end



/// 二级属性
@interface JXGoodAttrValueModel : NSObject

/** 属性值 */
@property (nonatomic, strong) NSString *attr_value;
/** 属性值id */
@property (nonatomic, strong) NSString *attr_value_id;

@end
