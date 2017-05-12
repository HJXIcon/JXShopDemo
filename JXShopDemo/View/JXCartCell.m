//
//  JXCartCell.m
//  JXShopDemo
//
//  Created by mac on 17/5/12.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXCartCell.h"
#import "PPNumberButton.h"
#import "JXCartModel.h"

@interface JXCartCell ()

@property (weak, nonatomic) IBOutlet UILabel        *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel        *GoodsPricesLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *goodsImageView;


@end

@implementation JXCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _nummberCount.minValue = 1;
    _nummberCount.decreaseImage = [UIImage imageNamed:@"decrease_eleme"];
    _nummberCount.increaseImage = [UIImage imageNamed:@"increase_eleme"];
    
    
}

- (void)setModel:(JXCartModel *)model{
    _model = model;
    
    self.goodsNameLabel.text             = model.p_name;
    self.GoodsPricesLabel.text           = [NSString stringWithFormat:@"￥%.2f",model.p_price];
    self.nummberCount.currentNumber = [NSString stringWithFormat:@"%ld",model.p_stock];
    self.selectShopGoodsButton.selected  = model.isSelect;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}


+ (CGFloat)getCartCellHeight{
    
    return 100;
}

@end
