//
//  JXShopCarTableHeaderView.m
//  JXShopDemo
//
//  Created by mac on 17/4/21.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXShopCarTableHeaderView.h"


@interface JXShopCarTableHeaderView()

@property (nonatomic, strong) UIButton *storeNameButton;
@property (nonatomic, strong) UIButton *selectStoreGoodsButton;

@end

@implementation JXShopCarTableHeaderView



- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self setHeaderUI];
    }
    return self;
}

- (void)setHeaderUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.selectStoreGoodsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectStoreGoodsButton.frame = CGRectZero;
    [self.selectStoreGoodsButton setImage:[UIImage imageNamed:@"xn_circle_normal"]
                                 forState:UIControlStateNormal];
    [self.selectStoreGoodsButton setImage:[UIImage imageNamed:@"xn_circle_select"]
                                 forState:UIControlStateSelected];
    self.selectStoreGoodsButton.backgroundColor=[UIColor clearColor];
    //    [self.selectStoreGoodsButton addTarget:self action:@selector(selectShopGoods:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.selectStoreGoodsButton];
    
    self.storeNameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.storeNameButton.frame = CGRectZero;
    [self.storeNameButton setTitle:@"店铺名字_____"
                          forState:UIControlStateNormal];
    [self.storeNameButton setTitleColor:[UIColor blackColor]
                               forState:UIControlStateNormal];
    self.storeNameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.storeNameButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.storeNameButton.titleLabel.font = JXFont(13);
    [self addSubview:self.storeNameButton];
    
    
    [self.selectStoreGoodsButton addTarget:self action:@selector(selectStoreAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.selectStoreGoodsButton addTarget:self action:@selector(storeNameAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Actions

- (void)storeNameAction{
    
    if (self.clickStoreNameBlock) {
        self.clickStoreNameBlock();
    }
}


- (void)selectStoreAction{
    if (self.selectStoreBlock) {
        self.selectStoreBlock();
    }
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.selectStoreGoodsButton.frame = CGRectMake(0, 0, 36, 30);
    
    self.storeNameButton.frame = CGRectMake(40, 0, kScreenW-40, 30);
    
}

+ (CGFloat)getCarHeaderHeight{
    
    return 30;
}
@end
