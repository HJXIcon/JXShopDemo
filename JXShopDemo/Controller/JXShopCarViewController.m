//
//  JXShopCarViewController.m
//  JXShopDemo
//
//  Created by mac on 17/4/21.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXShopCarViewController.h"
#import "JXShopUIService.h"
#import "JXShopCarViewModel.h"
#import "JXShopCarTableHeaderView.h"
#import "JXShopCartCell.h"
#import "JXShopcartBottomView.h"
#import <Masonry/Masonry.h>


@interface JXShopCarViewController ()<JXShopcartFormatDelegate>


@property(nonatomic, strong) UITableView *tableView;

/** UI：购物车UI处理*/
@property (nonatomic, strong)JXShopUIService *service;

/** VM：购物车逻辑处理*/
@property (nonatomic, strong)JXShopCarViewModel *viewModel;

/**< 购物车底部视图 */
@property (nonatomic, strong) JXShopcartBottomView *shopcartBottomView;

/*!编辑按钮 */
@property (nonatomic, strong) UIButton *editButton;
@end



@implementation JXShopCarViewController

#pragma mark - lazy loading

- (UIButton *)editButton {
    if (_editButton == nil){
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame = CGRectMake(0, 0, 40, 40);
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_editButton setTitle:@"完成" forState:UIControlStateSelected];
        [_editButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _editButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_editButton addTarget:self action:@selector(editButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editButton;
}

- (JXShopcartBottomView *)shopcartBottomView {
    if (_shopcartBottomView == nil){
        _shopcartBottomView = [[JXShopcartBottomView alloc] initWithFrame:CGRectMake(0, kScreenH - 50, kScreenW, 50)];
        
        __weak __typeof(self) weakSelf = self;
        /// 全选
        _shopcartBottomView.shopcartBotttomViewAllSelectBlock = ^(BOOL isSelected){
            [weakSelf.viewModel selectAllProductWithStatus:isSelected];
        };
        
        /// 结算
        _shopcartBottomView.shopcartBotttomViewSettleBlock = ^(){
            [weakSelf.viewModel settleSelectedProducts];
        };
        
        /// 删除
        _shopcartBottomView.shopcartBotttomViewDeleteBlock = ^(){
            
            [weakSelf.viewModel beginToDeleteSelectedProducts];
        };
    }
    return _shopcartBottomView;
}


- (UITableView *)tableView{
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        
        _tableView.delegate = self.service;
        _tableView.dataSource = self.service;
        _tableView.tableFooterView = [[UIView alloc]init];
        
        [_tableView registerClass:[JXShopCarTableHeaderView class] forHeaderFooterViewReuseIdentifier:@"JXShopCarTableHeaderView"];
        [_tableView registerClass:[JXShopCartCell class] forCellReuseIdentifier:@"JXShopCartCell"];
        
    }
    return _tableView;
}



- (JXShopCarViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel = [[JXShopCarViewModel alloc] init];
        _viewModel.delegate = self;
    }
    return _viewModel;
}


- (JXShopUIService *)service{
    
    if (!_service) {
        _service = [[JXShopUIService alloc] init];
        _service.viewModel = self.viewModel;
        kWeakSelf(self);
        /// 店铺选择
        _service.shopcartProxyBrandSelectBlock = ^(BOOL isSelected, NSInteger section){
            
             [weakself.viewModel selectBrandAtSection:section isSelected:isSelected];
        };
        
        /// 商品选择
        _service.shopcartProxyProductSelectBlock = ^(BOOL isSelected, NSIndexPath *indexPath){
            
            [weakself.viewModel selectProductAtIndexPath:indexPath isSelected:isSelected];
        };
        
        /// 数量改变
        _service.shopcartProxyChangeCountBlock = ^(NSInteger count, NSIndexPath *indexPath){
            
            [weakself.viewModel changeCountAtIndexPath:indexPath count:count];
        };
        
        /// 删除
        _service.shopcartProxyDeleteBlock = ^(NSIndexPath *indexPath){
          
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确认要删除这个宝贝吗？" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [weakself.viewModel deleteProductAtIndexPath:indexPath];
            }]];
            
            [weakself presentViewController:alert animated:YES completion:nil];
            
        };
        
        _service.shopcartProxyStarBlock = ^(NSIndexPath *indexPath){
            
             [weakself.viewModel starProductAtIndexPath:indexPath];
        };
        
       
        
    }
    return _service;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"购物车";
    
    
    [self setupUI];
    
    /// 加载数据
    [self.viewModel requestShopcartProductList];
    
}

- (void)setupUI{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.shopcartBottomView];
    UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.editButton];
    self.navigationItem.rightBarButtonItem = editBarButtonItem;
}




#pragma mark - Actions
- (void)editButtonAction{
    
    self.editButton.selected = !self.editButton.isSelected;
    [self.shopcartBottomView changeShopcartBottomViewWithStatus:self.editButton.isSelected];
}



#pragma mark - JXShopcartFormatDelegate

// 这是请求购物车列表成功之后的回调方法，将装有Model的数组回调到控制器；控制器将其赋给TableView的代理类JVShopcartTableViewProxy并刷新TableView。
- (void)shopcartFormatRequestProductListDidSuccessWithArray:(NSMutableArray *)dataArray{
    
}

// 这是用户在操作了单选、多选、全选、删除这些会改变底部结算视图里边的全选按钮状态、商品总价和商品数的统一回调方法，这条API会将用户操作之后的结果，也就是是否全选、商品总价和和商品总数回调给JVShopcartViewController， 控制器拿着这些数据调用底部结算视图BottomView的configure方法并刷新TableView，就完成了UI更新。
- (void)shopcartFormatAccountForTotalPrice:(float)totalPrice
                                totalCount:(NSInteger)totalCount
                             isAllSelected:(BOOL)isAllSelected{
    
    /// 底部总价
    [self.shopcartBottomView configureShopcartBottomViewWithTotalPrice:totalPrice totalCount:totalCount isAllselected:isAllSelected];
    
    /// 刷新UI
    [self.tableView reloadData];
    
}


/// 这是用户点击结算按钮的回调方法，这条API会将剔除了未选中ProductModel的模型数组回调给JVShopcartViewController，但并不改变原数据源因为用户随时可能返回
- (void)shopcartFormatSettleForSelectedProducts:(NSArray *)selectedProducts{
    
    /// 结算生成订单
    
    
}

/// 这是用户删除了购物车所有数据之后的回调方法，你可能会做些视图的隐藏或者提示。
- (void)shopcartFormatWillDeleteSelectedProducts:(NSArray *)selectedProducts{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"确认要删除这%ld个宝贝吗？", selectedProducts.count] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.viewModel deleteSelectedProducts:selectedProducts];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

/// 删除完成
- (void)shopcartFormatHasDeleteAllProducts{
    
    
}



@end
