//
//  JXGoodAttributesView.m
//  JXShopDemo
//
//  Created by mac on 17/4/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXGoodAttributesView.h"
#import "JXGoodAttrModel.h"
#import "UIImageView+WebCache.h"
#import "GlobalDefine.h"
#import "ACMacros.h"
#import "JXGoodAttributesCell.h"
#import "JXTagFrame.h"
#import "UIView+JXShopCarAnimation.h"


static CGFloat const kHeaderViewHeight = 100;

@interface JXGoodAttributesView ()<UITableViewDelegate,UITableViewDataSource>

/*! 商品图片 */
@property (nonatomic, strong) UIImageView *iconImgView;

/** 商品名字*/
@property (nonatomic, strong)UILabel *goodsNameLbl;

/** 价格*/
@property (nonatomic, strong)UILabel *goodsPriceLbl;

@property(nonatomic, strong) UITableView *tableView;



@end
@implementation JXGoodAttributesView

#pragma mark - 懒加载

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeaderViewHeight, self.bounds.size.width, self.bounds.size.height - kHeaderViewHeight) style:UITableViewStylePlain];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor = [UIColor whiteColor];
//        _tableView.layoutMargins = UIEdgeInsetsZero;
//        _tableView.separatorInset = UIEdgeInsetsZero;
        
    }
    return _tableView;
}



#pragma mark - setter
- (void)setGoodAttrsArr:(NSArray<JXGoodAttrModel *> *)goodAttrsArr{
    _goodAttrsArr = goodAttrsArr;
    
    
}

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5];
        
        
        [self setupBasicView];
    }
    return self;
}

/**
 *  设置视图的基本内容
 */
- (void)setupBasicView {
    
    [self addSubview:self.tableView];
    
    [self setupHeadrView];
  
    [self setupBottomView];
}

- (void)setupBottomView{
    // 加入购物车
    UIButton *addToCarBt = [UIButton buttonWithType:UIButtonTypeCustom];
    addToCarBt.backgroundColor = [UIColor orangeColor];
    [addToCarBt setBackgroundImage:[UIImage imageNamed:@"8预约上门时间"] forState:UIControlStateNormal];
    [addToCarBt setTitle:@"加入购物车" forState:UIControlStateNormal];
    [addToCarBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addToCarBt.frame = CGRectMake(0, self.frame.size.height - 45, kScreenW / 2, 45);
    [addToCarBt addTarget:self action:@selector(addToCarBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addToCarBt];
    
    
    /// 立即购买
    UIButton *payNowBt = [UIButton buttonWithType:UIButtonTypeCustom];
    payNowBt.backgroundColor = [UIColor colorWithRed:254 / 255.0 green:160 / 255.0 blue:40 / 255.0 alpha:1];
    [payNowBt setBackgroundImage:[UIImage imageNamed:@"8预约上门时间"] forState:UIControlStateNormal];
    [payNowBt setTitle:@"立即购买" forState:UIControlStateNormal];
    [payNowBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    payNowBt.frame = CGRectMake(kScreenW / 2, self.frame.size.height - 45, kScreenW / 2, 45);
    [payNowBt addTarget:self action:@selector(payNowBtClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:payNowBt];
    

}

- (void)setupHeadrView{
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kHeaderViewHeight)];
    
    contentView.backgroundColor = [UIColor whiteColor];
    
    
    /// 1.图片背景View
    UIView *iconBackView = [[UIView alloc] initWithFrame:(CGRect){10, -15, 90, 90}];
    iconBackView.backgroundColor = kWhiteColor;
    iconBackView.layer.borderColor = LXBorderColor.CGColor;
    iconBackView.layer.borderWidth = 1;
    iconBackView.layer.cornerRadius = 3;
    [contentView addSubview:iconBackView];
    
    /// 2.图片
    UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:(CGRect){5, 5, 80, 80}];
    [iconImgView setImage:[UIImage imageNamed:@"2"]];
    [iconBackView addSubview:iconImgView];
    self.iconImgView = iconImgView;
    
    
    /// 3.关闭
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(kScreenW - 30, 10, 20, 20);
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"closeEx"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:closeBtn];
    
    
    /// 4.商品名字
    UILabel *goodsNameLbl = [[UILabel alloc] init];
    goodsNameLbl.text = @"商品名字商品名字商品名字商品名字";
    goodsNameLbl.textColor = kMAINCOLOR;
    goodsNameLbl.font = [UIFont systemFontOfSize:15];
    CGFloat goodsNameLblX = CGRectGetMaxX(iconBackView.frame) + 10;
    CGFloat goodsNameLblY = closeBtn.frame.origin.y;
    
    CGSize size = [goodsNameLbl.text sizeWithAttributes:@{
                                                          NSFontAttributeName : goodsNameLbl.font
                                                          }];
    
    if (size.width >= kScreenW - 150) {
        size.width = kScreenW - 150;
    }
    
    goodsNameLbl.frame = (CGRect){goodsNameLblX, goodsNameLblY, size};
    [contentView addSubview:goodsNameLbl];
    self.goodsNameLbl = goodsNameLbl;
    
    
    /// 5.价格
    UILabel *goodsPriceLbl = [[UILabel alloc] initWithFrame:(CGRect){goodsNameLbl.frame.origin.x, CGRectGetMaxY(goodsNameLbl.frame) + 10, 150, 20}];
    goodsPriceLbl.text = @"999999999元";
    goodsPriceLbl.font = [UIFont systemFontOfSize:15];
    [contentView addSubview:goodsPriceLbl];
    self.goodsPriceLbl = goodsPriceLbl;
    
    
    // 6.分割线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetHeight(contentView.frame) - 1, CGRectGetWidth(contentView.frame) - 10, 1)];

    lineView.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:0.8];
    
    [contentView addSubview:lineView];
    [self addSubview:contentView];
}


#pragma mark - Actions
- (void)payNowBtClick{
    
}

- (void)addToCarBtnClick{
    
    [self addProductsAnimation:self.iconImgView endPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height) toView:self];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self closeBtnClick];
    });
}


- (void)closeBtnClick{
    if (self.closeBlock) {
        self.closeBlock();
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.goodAttrsArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JXGoodAttributesCell *cell = [JXGoodAttributesCell cellOfCellConfigWithTableView:tableView];
    
    
    JXGoodAttrModel *model = self.goodAttrsArr[indexPath.section];
    
    
    cell.tagsFrame = model.tagFrame;
    
    cell.attriName = model.attr_name;

    
    kWeakSelf(model);
    [cell setSelectIndexBlock:^(NSInteger index) {
        
        
        NSLog(@"选择商品属性: 属性名:%@     规格:%@ ",weakmodel.attr_name,weakmodel.tagFrame.tagsArray[index]);
        NSLog(@"选择商品属性：属性id:%@   规格id:%@ ",weakmodel.attr_id,weakmodel.attr_values[index].attr_value_id);
        NSLog(@"-------------------------");
        
        
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    JXGoodAttrModel *model = self.goodAttrsArr[indexPath.section];
    return model.tagFrame.tagsTotalHeight + 35;
    
}


#pragma mark - headerFooter
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}


@end
