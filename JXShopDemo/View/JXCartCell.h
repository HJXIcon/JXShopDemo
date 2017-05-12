//
//  JXCartCell.h
//  JXShopDemo
//
//  Created by mac on 17/5/12.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXCartCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *selectShopGoodsButton;

//@property (weak, nonatomic) IBOutlet JSNummberCount *nummberCount;
//
//@property (nonatomic, strong) JSCartModel *model;

+ (CGFloat)getCartCellHeight;

@end
