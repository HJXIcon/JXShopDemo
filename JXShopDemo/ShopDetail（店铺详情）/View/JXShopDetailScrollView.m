//
//  JXShopDetailScrollView.m
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXShopDetailScrollView.h"
#import "JXShopDetailCollectionView.h"

@interface JXShopDetailScrollView ()<UIScrollViewDelegate>

@property (nonatomic,strong) NSArray<UIView *> *subViews;
@property (nonatomic,assign) NSInteger currentShowIndex;

@end

@implementation JXShopDetailScrollView

- (instancetype)initWithSubViews:(NSArray *)subViews{
    self = [super init];
    if(self){
        _subViews = subViews;
        for(int i = 0;i<_subViews.count;i++){
            UIView *view = _subViews[i];
            view.tag = i;
            [self addSubview:view];
        }
        self.delegate = self;
        self.pagingEnabled = YES;
        [self configureContraints];
    }
    return self;
}

- (void)configureContraints{
    for(int i=0;i<_subViews.count;i++){
        UIView *view = _subViews[i];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(self);
            make.width.mas_equalTo(kScreenWidth);
            make.left.mas_equalTo(kScreenWidth*i);
        }];
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentSize = CGSizeMake(kScreenWidth*_subViews.count, self.frame.size.height);
}

- (void)showSubView:(NSInteger)index{
    //主动切换
    _currentShowIndex = index;
    //todo
    CGPoint originOffset = self.contentOffset;
    self.contentOffset = CGPointMake(kScreenWidth*index, originOffset.y);
}


#pragma mark --- getter and setter
- (void)setCouldScroll:(BOOL)scrollEnabled;{
    _couldScroll = scrollEnabled;
    for(JXShopDetailCollectionView *view in self.subViews){
        view.couldScroll = scrollEnabled;
    }
}
- (void)setTranslationBlock:(void (^)(CGFloat))translationBlock{
    _translationBlock = translationBlock;
    for(UIView *view in _subViews){
        [view setValue:_translationBlock forKey:@"translationBlock"];
    }
    
}

- (UIScrollView *)currentSubScorllView{
    return (UIScrollView *)self.subViews[_currentShowIndex];
}

- (UIScrollView *)subScorllViewAtIndex:(NSInteger)index{
    return (UIScrollView *)self.subViews[index];
}

- (void)showNoNetWorkDefaultView{
    [(JXShopDetailCollectionView *)self.currentSubScorllView showNoNetWorkDefaultView];
}

#pragma mark --
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //判断tab切换
    int index = scrollView.contentOffset.x/kScreenWidth;
    if(_currentShowIndex!=index){
        _currentShowIndex = index;
        if(_tabBarSelBlock){
            _tabBarSelBlock(_currentShowIndex);
        }
        
    }
}

@end

