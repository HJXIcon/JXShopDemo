//
//  JXShopUIService.m
//  JXShopDemo
//
//  Created by mac on 17/4/21.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXShopUIService.h"
#import "JXShopCarTableHeaderView.h"

@implementation JXShopUIService


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"index -- %ld",indexPath.row];
    
    return cell;
}


#pragma mark - headerFooter
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    JXShopCarTableHeaderView * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"JXShopCarTableHeaderView"];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return [JXShopCarTableHeaderView getCarHeaderHeight];
}

@end
