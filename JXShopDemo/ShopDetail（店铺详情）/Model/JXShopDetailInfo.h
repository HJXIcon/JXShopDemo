//
//  JXShopDetailInfo.h
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXShopDetailInfo : NSObject

@property (nonatomic,strong) NSString *bgImage;
@property (nonatomic,strong) NSString *icon;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) NSInteger level;
@property (nonatomic,assign) NSInteger fansCount;
@property (nonatomic,assign) BOOL isConcern;

+ (instancetype)testInfo;


@end
