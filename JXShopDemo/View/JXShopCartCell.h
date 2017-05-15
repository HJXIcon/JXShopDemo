//
//  JXShopCartCell.h
//  JXShopDemo
//
//  Created by mac on 17/5/15.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXCartModel;

@interface JXShopCartCell : UITableViewCell

typedef void(^JXShopcartCellBlock)(BOOL isSelected);
typedef void(^JXShopcartCellEditBlock)(NSInteger count);

@property (nonatomic, copy) JXShopcartCellBlock shopcartCellBlock;
@property (nonatomic, copy) JXShopcartCellEditBlock shopcartCellEditBlock;

@property(nonatomic, strong) JXCartModel *model;

- (void)configureShopcartCellWithProductURL:(NSString *)productURL
                                productName:(NSString *)productName
                                productSize:(NSString *)productSize
                               productPrice:(NSInteger)productPrice
                               productCount:(NSInteger)productCount
                               productStock:(NSInteger)productStock
                            productSelected:(BOOL)productSelected;



+ (CGFloat)getCartCellHeight;
@end
