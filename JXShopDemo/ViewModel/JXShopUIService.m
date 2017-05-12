//
//  JXShopUIService.m
//  JXShopDemo
//
//  Created by mac on 17/4/21.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXShopUIService.h"
#import "JXShopCarTableHeaderView.h"
#import "JXCartCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation JXShopUIService


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JXCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JXCartCell"];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}


- (void)configureCell:(JXCartCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
//    JXCartModel *model = self.viewModel.cartData[section][row];
    //cell 选中
    kWeakSelf(self);
    
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [JXCartCell getCartCellHeight];
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
