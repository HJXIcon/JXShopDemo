//
//  JXGoodDetailsPictureCell.h
//  JXShopDemo
//
//  Created by mac on 17/4/21.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXGoodDetailsPictureCell : UITableViewCell
+ (instancetype )cellOfCellConfigWithTableView:(UITableView *)tableView;

@property(nonatomic,strong) NSString *pictureName;
@end
