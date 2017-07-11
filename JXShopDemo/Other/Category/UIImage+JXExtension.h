//
//  UIImage+JXExtension.h
//  FishingWorld
//
//  Created by mac on 16/12/5.
//  Copyright © 2016年 zhuya. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (JXExtension)

/**
 返回已经改变的图片
 
 @param image 图片
 @param size 所需图片尺寸
 @return 图片
 */
+ (UIImage *) OriginImage:(UIImage *)image scaleToSize:(CGSize)size;

/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 
 */
+ (UIImage *) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;


/**
 根据view生成图片

 @param view view
 @return image
 */
+ (UIImage *) createImageFromView:(UIView *)view;



/**
 取出视频的每一帧图片
 
 @param videoURL 视频url
 @param time 时间
 @return 图片
 */
+ (UIImage *) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;



/**
  获取SDWebImage缓存图片

 @param urlString 图片urlString
 @return 缓存的图片
 */
+ (UIImage*)imageFromSdcacheWithURLString:(NSString *)urlString;
@end
