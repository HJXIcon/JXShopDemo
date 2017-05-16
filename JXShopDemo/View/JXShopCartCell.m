//
//  JXShopCartCell.m
//  JXShopDemo
//
//  Created by mac on 17/5/15.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXShopCartCell.h"
#import "UIImageView+WebCache.h"
#import "PPNumberButton.h"
#import <Masonry/Masonry.h>
#import "JXShopcartProductModel.h"

@interface JXShopCartCell ()

@property (nonatomic, strong) UIButton *productSelectButton;
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *productNameLable;
@property (nonatomic, strong) UILabel *productSizeLable;
@property (nonatomic, strong) UILabel *productPriceLable;
@property (nonatomic, strong) PPNumberButton *shopcartCountView;
@property (nonatomic, strong) UILabel *productStockLable;
@property (nonatomic, strong) UIView *shopcartBgView;
@property (nonatomic, strong) UIView *topLineView;

@end

@implementation JXShopCartCell


#pragma mark - lazy loading

- (UIButton *)productSelectButton
{
    if(_productSelectButton == nil)
    {
        _productSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_productSelectButton setImage:[UIImage imageNamed:@"xn_circle_normal"] forState:UIControlStateNormal];
        [_productSelectButton setImage:[UIImage imageNamed:@"xn_circle_select"] forState:UIControlStateSelected];
        [_productSelectButton addTarget:self action:@selector(productSelectButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _productSelectButton;
}

- (UIImageView *)productImageView {
    if (_productImageView == nil){
        _productImageView = [[UIImageView alloc] init];
    }
    return _productImageView;
}

- (UILabel *)productNameLable {
    if (_productNameLable == nil){
        _productNameLable = [[UILabel alloc] init];
        _productNameLable.font = [UIFont systemFontOfSize:14];
        _productNameLable.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1];
    }
    return _productNameLable;
}

- (UILabel *)productSizeLable {
    if (_productSizeLable == nil){
        _productSizeLable = [[UILabel alloc] init];
        _productSizeLable.font = [UIFont systemFontOfSize:13];
        _productSizeLable.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    }
    return _productSizeLable;
}

- (UILabel *)productPriceLable {
    if (_productPriceLable == nil){
        _productPriceLable = [[UILabel alloc] init];
        _productPriceLable.font = [UIFont systemFontOfSize:14];
        _productPriceLable.textColor = [UIColor colorWithRed:0.918  green:0.141  blue:0.137 alpha:1];
    }
    return _productPriceLable;
}

- (PPNumberButton *)shopcartCountView {
    if (_shopcartCountView == nil){
        _shopcartCountView = [[PPNumberButton alloc] init];
        
        __weak __typeof(self) weakSelf = self;
        _shopcartCountView.resultBlock = ^(NSString *count){
            if (weakSelf.shopcartCellEditBlock) {
                weakSelf.shopcartCellEditBlock([count integerValue]);
            }
        };
        
        _shopcartCountView.minValue = 1;
        _shopcartCountView.shakeAnimation = YES;
        _shopcartCountView.decreaseImage = [UIImage imageNamed:@"decrease_eleme"];
        _shopcartCountView.increaseImage = [UIImage imageNamed:@"increase_eleme"];
    }
    return _shopcartCountView;
}

- (UILabel *)productStockLable {
    if (_productStockLable == nil){
        _productStockLable = [[UILabel alloc] init];
        _productStockLable.font = [UIFont systemFontOfSize:13];
        _productStockLable.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    }
    return _productStockLable;
}

- (UIView *)shopcartBgView {
    if (_shopcartBgView == nil){
        _shopcartBgView = [[UIView alloc] init];
        _shopcartBgView.backgroundColor = [UIColor whiteColor];
    }
    return _shopcartBgView;
}

- (UIView *)topLineView {
    if (_topLineView == nil){
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    }
    return _topLineView;
}

#pragma mark - init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
    }
    return self;
}


- (void)setupViews {
    [self.contentView addSubview:self.shopcartBgView];
    [self.shopcartBgView addSubview:self.productSelectButton];
    [self.shopcartBgView addSubview:self.productImageView];
    [self.shopcartBgView addSubview:self.productNameLable];
    [self.shopcartBgView addSubview:self.productSizeLable];
    [self.shopcartBgView addSubview:self.productPriceLable];
    [self.shopcartBgView addSubview:self.shopcartCountView];
    [self.shopcartBgView addSubview:self.productStockLable];
    [self.shopcartBgView addSubview:self.topLineView];
}

- (void)configureShopcartCellWithProductURL:(NSString *)productURL productName:(NSString *)productName productSize:(NSString *)productSize productPrice:(NSInteger)productPrice productCount:(NSInteger)productCount productStock:(NSInteger)productStock productSelected:(BOOL)productSelected {
    NSURL *encodingURL = [NSURL URLWithString:[productURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [self.productImageView sd_setImageWithURL:encodingURL];
    self.productNameLable.text = productName;
    self.productSizeLable.text = productSize;
    self.productPriceLable.text = [NSString stringWithFormat:@"￥%ld", productPrice];
    self.productSelectButton.selected = productSelected;
    self.productStockLable.text = [NSString stringWithFormat:@"库存:%ld", productStock];
}


- (void)productSelectButtonAction {
    self.productSelectButton.selected = !self.productSelectButton.isSelected;
    if (self.shopcartCellBlock) {
        self.shopcartCellBlock(self.productSelectButton.selected);
    }
}



#pragma mark - setter
- (void)setModel:(JXShopcartProductModel *)model{
    _model = model;
    
    self.productSelectButton.selected = model.isSelected;
    NSURL *encodingURL = [NSURL URLWithString:[model.productPicUri stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    [self.productImageView sd_setImageWithURL:encodingURL];
    
    self.productNameLable.text = model.productName;
    
    self.productSizeLable.text = @"W:0 H:75 D:190";
    self.productPriceLable.text = [NSString stringWithFormat:@"%.2f",model.productPrice];
    
    self.shopcartCountView.currentNumber = [NSString stringWithFormat:@"%ld",model.productQty];
    self.productStockLable.text = [NSString stringWithFormat:@"剩余库存:%ld",model.productStocks];
;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.productSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopcartBgView).offset(10);
        make.centerY.equalTo(self.shopcartBgView).offset(-20);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopcartBgView).offset(50);
        make.centerY.equalTo(self.shopcartBgView).offset(-20);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [self.productNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(10);
        make.top.equalTo(self.shopcartBgView).offset(10);
        make.right.equalTo(self.shopcartBgView).offset(-5);
    }];
    
    [self.productSizeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(10);
        make.top.equalTo(self.productNameLable.mas_bottom);
        make.right.equalTo(self.shopcartBgView).offset(-5);
        make.height.equalTo(@20);
    }];
    
    [self.productPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(10);
        make.top.equalTo(self.productSizeLable.mas_bottom).offset(5);
        make.right.equalTo(self.shopcartBgView).offset(-5);
        make.height.equalTo(@20);
    }];
    
    [self.shopcartCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(10);
        make.bottom.equalTo(self.shopcartBgView).offset(-5);
        make.size.mas_equalTo(CGSizeMake(90, 25));
    }];
    
    [self.productStockLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopcartCountView.mas_right).offset(20);
        make.centerY.equalTo(self.shopcartCountView);
    }];
    
    [self.shopcartBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopcartBgView).offset(50);
        make.top.right.equalTo(self.shopcartBgView);
        make.height.equalTo(@0.4);
    }];
}


#pragma 类方法
+ (CGFloat)getCartCellHeight{
    return 100;
}
@end
