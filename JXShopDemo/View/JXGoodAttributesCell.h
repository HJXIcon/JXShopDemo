//
//  JXGoodAttributesCell.h
//  JXShopDemo
//
//  Created by mac on 17/4/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JXTagFrame;


@interface JXGoodAttributesCell : UITableViewCell
+ (instancetype )cellOfCellConfigWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) NSString *attriName;

@property (nonatomic, strong) JXTagFrame *tagsFrame;

/*! 选择属性回调 */
@property (nonatomic, copy)void(^selectIndexBlock)(NSInteger index);

@end

