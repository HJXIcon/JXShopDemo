//
//  JXShopProductCollectionViewCell.h
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXShopProductCollectionCellViewModel.h"

@interface JXShopProductCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong,readonly) JXShopProductCollectionCellViewModel *viewModel;
- (void)bindData:(id)data;

@end
