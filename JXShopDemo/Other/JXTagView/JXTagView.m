//
//  JXTagView.m
//  JXShopDemo
//
//  Created by mac on 17/4/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXTagView.h"


@interface JXTagView ()

@property (nonatomic, strong) UIButton *selectBtn;


@end

@implementation JXTagView

- (void)setTagsFrame:(JXTagFrame *)tagsFrame
{
    _tagsFrame = tagsFrame;
    
    for (NSInteger i = 0; i < tagsFrame.tagsArray.count; i++) {
        UIButton *tagsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tagsBtn setTitle:tagsFrame.tagsArray[i] forState:UIControlStateNormal];
        [tagsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        tagsBtn.titleLabel.font = TagsTitleFont;
        
        [tagsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        tagsBtn.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
        
        tagsBtn.layer.borderWidth = 1;
        tagsBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        tagsBtn.layer.cornerRadius = 4;
        tagsBtn.layer.masksToBounds = YES;
        
        [tagsBtn addTarget:self action:@selector(tagClick:) forControlEvents:UIControlEventTouchUpInside];
        tagsBtn.tag = i;
        
        tagsBtn.frame = CGRectFromString(tagsFrame.tagsFrames[i]);
    
        [self addSubview:tagsBtn];
    }
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
  
}

- (void)tagClick:(UIButton *)button{
    
    if (_selectBtn.tag == button.tag && _selectBtn) {
        _selectBtn.selected = NO;
        _selectBtn.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
        _selectBtn = nil;
        return;
    }
    
    _selectBtn.selected = NO;
    _selectBtn.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    
    button.backgroundColor = [UIColor orangeColor];
    button.selected = YES;
    
    _selectBtn = button;
    
    
    if (self.selectIndexBlock && _selectBtn) {
        self.selectIndexBlock(_selectBtn.tag);
    }
    
}

@end
