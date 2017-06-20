//
//  JXShopDetailHeaderView.h
//  JXShopDemo
//
//  Created by mac on 17/6/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXShopDetailHeaderView : UIView

- (void)bindData:(NSString *)bg icon:(NSString *)icon name:(NSString *)name level:(NSInteger)level fansCount:(NSInteger)fansCount isConcern:(BOOL)isConcern;

@end
