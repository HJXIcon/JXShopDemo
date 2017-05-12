//
//  JXCartCell.m
//  JXShopDemo
//
//  Created by mac on 17/5/12.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXCartCell.h"

@interface JXCartCell ()

@property (weak, nonatomic) IBOutlet UILabel        *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel        *GoodsPricesLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *goodsImageView;


@end

@implementation JXCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (CGFloat)getCartCellHeight{
    
    return 100;
}

@end
