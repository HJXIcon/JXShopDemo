//
//  JXSearchCollectionHeaderFooterView.m
//  FishingWorld
//
//  Created by mac on 16/12/22.
//  Copyright © 2016年 zhuya. All rights reserved.
//

#import "JXSearchCollectionHeaderFooterView.h"


static CGFloat const JXMargin = 10;
@interface JXSearchCollectionHeaderFooterView ()

@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation JXSearchCollectionHeaderFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}
- (void)setLabelText:(NSString *)text color:(UIColor *)textColor{
    
    _titleLabel.text = text;
    _titleLabel.textColor = textColor;
}

- (void)setupUI{
    
    UIView *leftLine = [[UIView alloc]init];
    leftLine.backgroundColor = RGBA(200, 200, 200, 1);
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.text = @"为你推荐";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = RGBA(150, 150, 150, 1);
//    _titleLabel.frame = CGRectMake(0, 0, JXScreenW, 60);
    
    UIView *rightLine = [[UIView alloc]init];
    rightLine.backgroundColor = RGBA(200, 200, 200, 1);
    
    [self sd_addSubviews:@[leftLine,_titleLabel,rightLine]];
    
    _titleLabel.sd_layout
    .centerXEqualToView(self)
    .centerYEqualToView(self)
    .autoHeightRatio(0);
    [_titleLabel setSingleLineAutoResizeWithMaxWidth:self.width * 0.8];
    
    leftLine.sd_layout
    .leftSpaceToView(self,JXMargin * 2)
    .rightSpaceToView(_titleLabel,JXMargin)
    .heightIs(1)
    .centerYEqualToView(self);
    
    rightLine.sd_layout
    .leftSpaceToView(_titleLabel,JXMargin)
    .rightSpaceToView(self,JXMargin * 2)
    .heightIs(1)
    .centerYEqualToView(self);
    
}

@end
