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
#import <ReactiveObjC/ReactiveObjC.h>
#import "JXShopCarViewModel.h"


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



/*!
 
 // RACSignal使用步骤：
 // 1.创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
 // 2.订阅信号,才会激活信号. - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
 // 3.发送信号 - (void)sendNext:(id)value
 
 */
- (void)configureCell:(JXCartCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    JXCartModel *model = self.viewModel.cartData[section][row];
    
    //cell 选中
    kWeakSelf(self);
    // rac_signalForControlEvents：用于监听某个事件。
    // takeUntil:---给takeUntil传的是哪个信号，那么当这个信号发送信号或sendCompleted，就不能再接受源信号的内容了.
    
    /// 如果不加takeUntil:cell.rac_prepareForReuseSignal，那么每次Cell被重用时，该button都会被addTarget:selector。
    [[[cell.selectShopGoodsButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(UIButton *btn) {
        btn.selected = !btn.selected;
        [weakself.viewModel rowSelect:btn.selected IndexPath:indexPath];
    }];
    
    
    //数量改变
    cell.nummberCount.resultBlock = ^(NSString *changeCount){
        
        [weakself.viewModel rowChangeQuantity:[changeCount integerValue] indexPath:indexPath];
    };
    
    cell.model = model;
    
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
