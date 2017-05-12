//
//  JXCartCell.h
//  JXShopDemo
//
//  Created by mac on 17/5/12.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PPNumberButton,JXCartModel;

@interface JXCartCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *selectShopGoodsButton;

@property (weak, nonatomic) IBOutlet PPNumberButton *nummberCount;

@property (nonatomic, strong) JXCartModel *model;

+ (CGFloat)getCartCellHeight;

@end
