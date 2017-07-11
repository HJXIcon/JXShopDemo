//
//  JXSearchSortView.m
//  FishingWorld
//
//  Created by mac on 16/12/22.
//  Copyright © 2016年 zhuya. All rights reserved.
//

#import "JXSearchSortView.h"

@interface JXSearchSortView ()
@property (nonatomic, strong) NSMutableArray *btnsArr;

@end
@implementation JXSearchSortView
- (NSMutableArray *)btnsArr{
    if (_btnsArr == nil) {
        _btnsArr = [NSMutableArray array];
    }
    return _btnsArr;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)setupUI{
    
    int count = 3;
    CGFloat btnH = 35;
    CGFloat btnX = 20;
    CGFloat btnY = (self.height - btnH) * 0.5;
    CGFloat btnW = (kScreenW - btnX * 2) / count;
    
    NSArray *titles = @[@"综合排序",@"最新发布",@"最多播放"];
    
    for (int i = 0; i < count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGBA(30, 170, 250, 1) forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btnX = 20 + i * btnW;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnsArr addObject:btn];
        [self addSubview:btn];
        
        if (i == 0) {
            btn.selected = YES;
        }
    }
}

- (void)btnClick:(UIButton *)button{
    [self selButton:button];
    if (self.btnClickCallBack) {
        self.btnClickCallBack(button.tag);
    }
    
}

- (void)selButton:(UIButton *)button{
    
    [self.btnsArr enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.selected = obj == button ? YES : NO;
    }];
}
@end
