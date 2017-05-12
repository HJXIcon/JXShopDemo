//
//  JXGoodDetailsViewController.m
//  JXShopDemo
//
//  Created by mac on 17/4/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXGoodDetailsViewController.h"
#import "JXGoodDetailsPictureCell.h"


@interface JXGoodDetailsViewController ()

@property(nonatomic, strong) NSArray *imagesArray;
@end

@implementation JXGoodDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    _imagesArray = @[@"1",@"2",@"3",@"4"];
    
    self.tableView.rowHeight = 220;
    self.tableView.tableFooterView = [[UIView alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _imagesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JXGoodDetailsPictureCell *cell = [JXGoodDetailsPictureCell cellOfCellConfigWithTableView:tableView];
    
    cell.pictureName = _imagesArray[indexPath.row];
    
    return cell;
}



@end
