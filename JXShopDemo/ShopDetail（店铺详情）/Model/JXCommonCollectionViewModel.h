//
//  JXCommonCollectionViewModel.h
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXCommonCollectionViewModel : NSObject<UICollectionViewDelegate>

/**dataSource*/
@property (nonatomic, strong) NSMutableArray *dataSource;

@end
