//
//  JXTagFrame.m
//  JXShopDemo
//
//  Created by mac on 17/4/20.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXTagFrame.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

static CGFloat const tagHeight = 28;

@implementation JXTagFrame

- (id)init
{
    self = [super init];
    if (self) {
        _tagsFrames = [NSMutableArray array];
        _tagsMinPadding = 10;
        _tagsMargin = 10;
        _tagsLineSpacing = 10;
    }
    return self;
}

- (void)setTagsArray:(NSArray *)tagsArray
{
    _tagsArray = tagsArray;
    
    CGFloat btnX = _tagsMargin;
    CGFloat btnW = 0;
    
    CGFloat nextWidth = 0;  // 下一个标签的宽度
    CGFloat moreWidth = 0;  // 每一行多出来的宽度
    
    /**
     *  每一行的最后一个tag的索引的数组和每一行多出来的宽度的数组
     */
    NSMutableArray *lastTagIndexs = [NSMutableArray array];
    NSMutableArray *moreWidths = [NSMutableArray array];
    
    for (NSInteger i=0; i<tagsArray.count; i++) {
        
        /// 1.按钮宽度
        btnW = [self sizeWithText:tagsArray[i] font:TagsTitleFont].width + _tagsMinPadding * 2;
        
        /// 2.下一个按钮宽度
        if (i < tagsArray.count - 1) {
            nextWidth = [self sizeWithText:tagsArray[i + 1] font:TagsTitleFont].width + _tagsMinPadding * 2;
        }
        
        /// 3.下一按钮的X
        CGFloat nextBtnX = btnX + btnW + _tagsMargin;
        
        // 4.如果下一个按钮，标签最右边则换行
        if ((nextBtnX + nextWidth) > (kScreenWidth - _tagsMargin)) {
            // 计算超过的宽度
            moreWidth = kScreenWidth - nextBtnX;
            
            [lastTagIndexs addObject:[NSNumber numberWithInteger:i]];
            [moreWidths addObject:[NSNumber numberWithFloat:moreWidth]];
            
            btnX = _tagsMargin;
            
        }else{
            btnX += (btnW + _tagsMargin);
        }
        
        // 5.如果是最后一个且数组中没有，则把最后一个加入数组
        if (i == tagsArray.count -1) {
            if (![lastTagIndexs containsObject:[NSNumber numberWithInteger:i]]) {
                [lastTagIndexs addObject:[NSNumber numberWithInteger:i]];
                [moreWidths addObject:[NSNumber numberWithFloat:0]];
            }
        }
    }
    
    
    // 6.取出tag数组中每一行tag数组
    NSInteger location = 0;  // 截取的位置
    NSInteger length = 0;    // 截取的长度
    CGFloat averageW = 0;    // 多出来的平均的宽度
    
    CGFloat tagW = 0;
    CGFloat tagH = tagHeight;
    
    for (NSInteger i = 0; i< lastTagIndexs.count; i++) {
        
        /// 6.1每一行的最后一个tag的索引
        NSInteger lastIndex = [lastTagIndexs[i] integerValue];
        
        /// 6.2每一行截取的长度
        /*! 只有一个tag的时候情况处理 */
        if (i == 0) {
            length = lastIndex + 1;
            
        }else{
            length = [lastTagIndexs[i] integerValue]-[lastTagIndexs[i-1] integerValue];
        }
        
        // 6.3从tag数组中截取每一行的tag数组
        NSArray *eachRowTagsArray = [tagsArray subarrayWithRange:NSMakeRange(location, length)];
        location = lastIndex + 1;
        
        // 6.4 每一行的平均宽度
        averageW = [moreWidths[i] floatValue] / eachRowTagsArray.count;
        
        
        // 6.5 计算tag的X、Y值
        CGFloat tagX = _tagsMargin;
        CGFloat tagY = _tagsLineSpacing + (_tagsLineSpacing + tagH) * i;
        
        // 6.6每一行tag的frame
        for (NSInteger j = 0; j< eachRowTagsArray.count; j++) {
            
            tagW = [self sizeWithText:eachRowTagsArray[j] font:TagsTitleFont].width + _tagsMinPadding * 2 + averageW;
            
            CGRect btnF = CGRectMake(tagX, tagY, tagW, tagH);
            
            
            
            [_tagsFrames addObject:NSStringFromCGRect(btnF)];
            
            tagX += (tagW + _tagsMargin);
            
        }
    }
    
    _tagsTotalHeight = (tagH + _tagsLineSpacing) * lastTagIndexs.count + _tagsLineSpacing;
    
}


/**
 *  单行文本数据获取宽高
 *
 *  @param text 文本
 *  @param font 字体
 *
 *  @return 宽高
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    
    return [text sizeWithAttributes:attrs];
}




@end
