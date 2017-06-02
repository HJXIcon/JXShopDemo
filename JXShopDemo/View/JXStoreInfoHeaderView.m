//
//  JXStoreInfoHeaderView.m
//  JXShopDemo
//
//  Created by mac on 17/6/2.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXStoreInfoHeaderView.h"
#import "UIView+Extension.h"
#import "UIImage+JQImage.h"
#import "UIButton+Size.h"

@interface JXStoreInfoHeaderView ()
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) UIButton *emailButton;
@end

@implementation JXStoreInfoHeaderView

#pragma mark - lazy load
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(-(self.width-60), 30, self.width-80, 30)];
        _searchBar.placeholder = @"搜索值得买的好物";
        _searchBar.layer.cornerRadius = 15;
        _searchBar.layer.masksToBounds = YES;
        
        // 设置搜索框中文本框的背景
        [_searchBar setSearchFieldBackgroundImage:[UIImage imageWithColor:[UIColor clearColor] size:_searchBar.size] forState:UIControlStateNormal];
        
        [_searchBar setBackgroundImage:[UIImage imageWithColor:[[UIColor grayColor] colorWithAlphaComponent:0.4] size:_searchBar.size] ];
        
        UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
        searchField.textColor = [UIColor whiteColor];
        [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        
        
    }
    return _searchBar;
}

- (UIButton *)searchButton {
    if (!_searchButton) {
        _searchButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 30, 30)];
        [_searchButton setBackgroundImage:[UIImage imageNamed:@"home_search_icon"] forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}

- (UIButton *)emailButton {
    if (!_emailButton) {
        _emailButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width-45, 30, 30, 30)];
        [_emailButton setBackgroundImage:[UIImage imageNamed:@"home_email_black"] forState:UIControlStateNormal];
        
    }
    return _emailButton;
}



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.searchBar];
        [self addSubview:self.searchButton];
        [self addSubview:self.emailButton];
        
        
    }
    return self;
}

#pragma mark - Actions
- (void)goback{
    
    if (self.goBackBlock) {
        self.goBackBlock();
    }
}

- (void)setOffsetY:(CGFloat)offsetY{
    _offsetY = offsetY;
    
    
    CGFloat collecntionViewoffsetY = offsetY;
    // MIN函数用于返回一个列范围内的最小非空值
    CGFloat alpha = MIN(1, collecntionViewoffsetY/136);
    
    UIColor * color = [UIColor whiteColor];
    self.backgroundColor = [color colorWithAlphaComponent:alpha];
    
    if (collecntionViewoffsetY < 125){
        
        [UIView animateWithDuration:0.25 animations:^{
            self.searchButton.hidden = NO;
            [self.emailButton setBackgroundImage:[UIImage imageNamed:@"home_email_black"] forState:UIControlStateNormal];
            self.searchBar.frame = CGRectMake(-(self.width-60), 30, self.width-80, 30);
            self.emailButton.alpha = 1-alpha;
            self.searchButton.alpha = 1-alpha;
            
            
        }];
    } else if (collecntionViewoffsetY >= 125){
        
        [UIView animateWithDuration:0.25 animations:^{
            self.searchBar.frame = CGRectMake(20, 30, self.width-80, 30);
            self.searchButton.hidden = YES;
            self.emailButton.alpha = 1;
            [self.emailButton setBackgroundImage:[UIImage imageNamed:@"home_email_red"] forState:UIControlStateNormal];
        }];
    }
}




@end
