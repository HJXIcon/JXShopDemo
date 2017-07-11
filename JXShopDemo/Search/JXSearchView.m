//
//  JXSearchView.m
//  FishingWorld
//
//  Created by mac on 16/12/21.
//  Copyright © 2016年 zhuya. All rights reserved.
//

#import "JXSearchView.h"

@interface JXSearchView ()

@property (nonatomic, strong) UILabel *searchLabel;


@end
@implementation JXSearchView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _searchLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, frame.size.width - 30, 35)];
        _searchLabel.font = [UIFont systemFontOfSize:15];
        _searchLabel.textColor = RGBA(140, 140, 140, 1);
        [self addSubview:_searchLabel];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame searchTitleText:(NSString *)searchTitleText searchButtonTitleTexts:(NSArray *)searchButtonTitleTexts searchButtonClickCallback:(JXSearchButtonClickCallback) searchButtonClickCallback{
    
    if (self =  [self initWithFrame:frame]) {
        _searchLabel.text = searchTitleText;
        
        CGFloat lastX = 10;
        CGFloat lastY = 35;
        CGFloat btnW = 0;
        CGFloat btnH = 30;
        CGFloat addW = 30;
        CGFloat marginX = 10;
        CGFloat marginY = 10;
        
        for (int i = 0; i < searchButtonTitleTexts.count; i ++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:searchButtonTitleTexts[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn.titleLabel sizeToFit];
            btn.backgroundColor = [UIColor whiteColor];
            btn.layer.cornerRadius = 15;
            btn.layer.masksToBounds = YES;
            btn.layer.borderColor = RGBA(200, 200, 200, 1).CGColor;
            btn.layer.borderWidth = 0.5;
            [btn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            btnW = btn.titleLabel.width + addW;
            
            
            if (frame.size.width - lastX > btnW) {
                
                btn.frame = CGRectMake(lastX, lastY, btnW, btnH);
            }else{
                btn.frame = CGRectMake(10, lastY + marginY + btnH, btnW, btnH);
            }
            
            lastX = CGRectGetMaxX(btn.frame) + marginX;
            lastY = btn.frame.origin.y;
            self.searchHeight = CGRectGetMaxY(btn.frame);
            [self addSubview:btn];
            
        }
       
        
    }
    self.searchButtonClickCallback = searchButtonClickCallback;
    
    return self;
    
}



#pragma mark - Action
- (void)searchButtonClick:(UIButton *)button{
    if (self.searchButtonClickCallback) {
        self.searchButtonClickCallback(button);
    }
}
@end
