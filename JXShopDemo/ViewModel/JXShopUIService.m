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
#import "JXShopcartBrandModel.h"
#import "JXShopcartProductModel.h"

@implementation JXShopUIService


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.shopcartListArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    JXShopcartBrandModel *brandModel = self.viewModel.shopcartListArray[section];
    NSArray *productArray = brandModel.products;
    return productArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JXShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JXShopCartCell"];
    
    JXShopcartBrandModel *brandModel = self.viewModel.shopcartListArray[indexPath.section];
    
    NSArray *productArray = brandModel.products;
    
    cell.model = productArray[indexPath.row];

    __weak __typeof(self) weakSelf = self;
    
    /// 选中
    cell.shopcartCellBlock = ^(BOOL isSelected){
        if (weakSelf.shopcartProxyProductSelectBlock) {
            weakSelf.shopcartProxyProductSelectBlock(isSelected, indexPath);
        }
    };
    
    /// 数量改变
    cell.shopcartCellEditBlock = ^(NSInteger count){
        if (weakSelf.shopcartProxyChangeCountBlock) {
            weakSelf.shopcartProxyChangeCountBlock(count, indexPath);
        }
    };
    
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [JXShopCartCell getCartCellHeight];
}


#pragma mark - headerFooter
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    JXShopCarTableHeaderView * shopcartHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"JXShopCarTableHeaderView"];
    
    JXShopcartBrandModel *brandModel =self.viewModel.shopcartListArray[section];
    
    shopcartHeaderView.model = brandModel;
    
    __weak __typeof(self) weakSelf = self;
    /// 选择店铺
    shopcartHeaderView.selectStoreBlock = ^(BOOL isSelected){
        
        if (weakSelf.shopcartProxyBrandSelectBlock) {
            weakSelf.shopcartProxyBrandSelectBlock(isSelected, section);
        }
    };
    
    /// 点击店铺名字
    shopcartHeaderView.clickNameBlock = ^(){
        
        if (weakSelf.shopcartProxyBrandClickBlock) {
            weakSelf.shopcartProxyBrandClickBlock(section);
        }
    };
    
    return shopcartHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return [JXShopCarTableHeaderView getCarHeaderHeight];
}


#pragma mark - ******* 删除 收藏
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (self.shopcartProxyDeleteBlock) {
            self.shopcartProxyDeleteBlock(indexPath);
        }
    }];
    
    UITableViewRowAction *starAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (self.shopcartProxyStarBlock) {
            self.shopcartProxyStarBlock(indexPath);
        }
    }];
    
    return @[deleteAction, starAction];
}



@end
