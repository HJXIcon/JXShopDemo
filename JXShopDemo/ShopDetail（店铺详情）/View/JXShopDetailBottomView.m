//
//  JXShopDetailBottomView.m
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXShopDetailBottomView.h"

@implementation JXShopDetailBottomView

- (instancetype)initWithTitleArray:(NSArray *)titleArray{
    self = [super init];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        _buttonArray = [NSMutableArray array];
        for(int i=0; i<titleArray.count; i++){
            UIButton *btn = [[UIButton alloc]init];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            btn.backgroundColor = [UIColor colorWithRGB:0xf9f9f9];
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRGB:0x4c5053] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRGB:0x4c5053] forState:UIControlStateDisabled];
            btn.layer.borderWidth = 0.25;
            btn.layer.borderColor = [UIColor colorWithRGB:0xededed].CGColor;
            btn.tag = i;
            [self addSubview:btn];
            [_buttonArray addObject:btn];
        }
        
        [_buttonArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
        [_buttonArray mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(self);
        }];
    }
    
    return self;
}

#pragma mark -
#pragma mark - action
- (void)addtarget:(id)target sel:(SEL)sel{
    for(UIButton *btn in _buttonArray){
        [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    }
}


@end
