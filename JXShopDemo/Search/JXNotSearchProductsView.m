//
//  JXNotSearchProductsView.m
//  FishingWorld
//
//  Created by mac on 16/12/21.
//  Copyright © 2016年 zhuya. All rights reserved.
//

#import "JXNotSearchProductsView.h"


static const CGFloat  JXMargin = 10;
@interface JXNotSearchProductsView ()

@property (nonatomic,weak) UILabel *label;
@end
@implementation JXNotSearchProductsView
- (void)setKeyword:(NSString *)keyword{
    _keyword = keyword;
    _label.text = [NSString stringWithFormat:@"抱歉，没有找到“%@”的相关视频",keyword];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)setupUI{
    // pic
    UILabel *sighLabel = [[UILabel alloc]init];
    sighLabel.text = @"!";
    sighLabel.textColor = [UIColor whiteColor];
    sighLabel.font = [UIFont boldSystemFontOfSize:22];
    sighLabel.backgroundColor = RGBA(250, 210, 90, 1);
    sighLabel.layer.cornerRadius = 15;
    sighLabel.layer.masksToBounds = YES;
    sighLabel.textAlignment = NSTextAlignmentCenter;
    
    // label
    UILabel *label = [[UILabel alloc]init];
    label.text = [NSString stringWithFormat:@"抱歉，没有找到“%@”的相关视频",@"shiehi"];
    label.font = [UIFont boldSystemFontOfSize:15];
    _label = label;
    
    // subLabel
    UILabel *subLabel = [[UILabel alloc]init];
    subLabel.text = @"钓友天下建议您：更换关键词";
    subLabel.font = [UIFont systemFontOfSize:12];
    subLabel.textColor = RGBA(140, 140, 140, 1);
    
    [self addSubview:sighLabel];
    [self addSubview:label];
    [self addSubview:subLabel];
    

    
    sighLabel.sd_layout
    .leftSpaceToView(self,JXMargin * 2)
    .centerYEqualToView(self)
    .widthIs(30)
    .heightEqualToWidth();
    
    label.sd_layout
    .leftSpaceToView(sighLabel,JXMargin)
    .topEqualToView(sighLabel)
    .autoHeightRatio(0);
    [label setSingleLineAutoResizeWithMaxWidth:self.width - 60];
    
    subLabel.sd_layout
    .leftEqualToView(label)
    .topSpaceToView(label,JXMargin)
    .autoHeightRatio(0);
    [subLabel setSingleLineAutoResizeWithMaxWidth:self.width - 60];
    
    
}

@end
