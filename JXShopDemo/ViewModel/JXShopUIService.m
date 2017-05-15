//
//  JXShopUIService.m
//  JXShopDemo
//
//  Created by mac on 17/4/21.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXShopUIService.h"
#import "JXShopCarTableHeaderView.h"
#import "JXShopCartCell.h"
#import "JXShopCarViewModel.h"
#import "JXCartModel.h"

@implementation JXShopUIService


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.cartData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
     return [self.viewModel.cartData[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JXShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JXShopCartCell"];
    
    cell.shopcartCellEditBlock = nil;
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}



/*!
 
 // RACSignal使用步骤：
 // 1.创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
 // 2.订阅信号,才会激活信号. - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
 // 3.发送信号 - (void)sendNext:(id)value
 
 */
- (void)configureCell:(JXShopCartCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    JXCartModel *model = self.viewModel.cartData[section][row];
    
    
    kWeakSelf(self);
    
    //数量改变
    cell.shopcartCellEditBlock = ^(NSInteger changeCount){
        
        NSLog(@"section == %ld,row == %ld",indexPath.section,indexPath.row);
        
        [weakself.viewModel rowChangeQuantity:changeCount  indexPath:indexPath];
    };
    
    cell.model = model;
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [JXShopCartCell getCartCellHeight];
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
