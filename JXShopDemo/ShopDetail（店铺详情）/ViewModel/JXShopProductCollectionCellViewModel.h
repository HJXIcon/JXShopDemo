//
//  JXShopProductCollectionCellViewModel.h
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXShopProductCollectionCellViewData.h"

@interface JXShopProductCollectionCellViewModel : NSObject

@property (nonatomic,strong,readonly) JXShopProductCollectionCellViewData *viewData;
- (void)bindViewData:(id)data;

@end
