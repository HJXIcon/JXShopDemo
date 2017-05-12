//
//  JXShopUIService.h
//  JXShopDemo
//
//  Created by mac on 17/4/21.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JXShopCarViewModel;

@interface JXShopUIService : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) JXShopCarViewModel *viewModel;



@end
