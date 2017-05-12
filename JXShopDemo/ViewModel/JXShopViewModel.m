
//
//  JXShopViewModel.m
//  JXShopDemo
//
//  Created by mac on 17/4/21.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXShopViewModel.h"
#import "JXGoodAttrModel.h"

@implementation JXShopViewModel

///数据请求到了
- (void)requestData:(void(^)(NSArray <JXGoodAttrModel *> *datas))completion{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray *datas = [NSMutableArray array];
        
        
        NSArray *attr_names = @[@"尺码",@"颜色"];
        
        
        for (int i = 0; i < attr_names.count; i ++) {
            JXGoodAttrModel *model = [[JXGoodAttrModel alloc]init];
            model.attr_name = attr_names[i];
            model.attr_id = [NSString stringWithFormat:@"%d",i];
            
            
            
            NSMutableArray *valuesModelArray = [NSMutableArray array];
            if (i == 1) {
                
                NSArray *attr_values =  @[@"白色+冠+树+PK+沙",@"灰色A+冠",@"黑色+冠+树",@"蓝色A+冠+树+PK+沙"];
                for (int j = 0 ; j < attr_values.count; j ++) {
                    JXGoodAttrValueModel *valueModel = [[JXGoodAttrValueModel alloc]init];
                    valueModel.attr_value_id = [NSString stringWithFormat:@"%d",j];
                    valueModel.attr_value = attr_values[j];
                    [valuesModelArray addObject:valueModel];
                    
                }
                
            }else{
                
                
                NSArray *attr_values =  @[@"S",@"M",@"L",@"XL",@"XLLL",@"S",@"M",@"L",@"XL",@"XLLL"];
                for (int j = 0 ; j < attr_values.count; j ++) {
                    JXGoodAttrValueModel *valueModel = [[JXGoodAttrValueModel alloc]init];
                    valueModel.attr_value_id = [NSString stringWithFormat:@"%d",j];
                    valueModel.attr_value = attr_values[j];
                    [valuesModelArray addObject:valueModel];
                }
            }
            
            model.attr_values = valuesModelArray;
            
            [datas addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            completion(datas);
        });
    });
    

  
    
    
    
}
@end
