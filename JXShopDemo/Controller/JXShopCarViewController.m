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



@interface JXShopCarViewController ()


@property(nonatomic, strong) UITableView *tableView;

/** UI*/
@property (nonatomic, strong)JXShopUIService *service;

/** VM*/
@property (nonatomic, strong)JXShopCarViewModel *viewModel;


@end



@implementation JXShopCarViewController

#pragma mark - lazy loading
- (UITableView *)tableView{
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        
        _tableView.delegate = self.service;
        _tableView.dataSource = self.service;
        _tableView.tableFooterView = [[UIView alloc]init];
        
        [_tableView registerClass:[JXShopCarTableHeaderView class] forHeaderFooterViewReuseIdentifier:@"JXShopCarTableHeaderView"];
        
    }
    return _tableView;
}



- (JXShopCarViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel = [[JXShopCarViewModel alloc] init];
    }
    return _viewModel;
}


- (JXShopUIService *)service{
    
    if (!_service) {
        _service = [[JXShopUIService alloc] init];
        _service.viewModel = self.viewModel;
    }
    return _service;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"购物车";
    
    [self.view addSubview:self.tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
