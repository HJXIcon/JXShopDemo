//
//  UIImage+JXExtension.m
//  FishingWorld
//
//  Created by mac on 16/12/5.
//  Copyright © 2016年 zhuya. All rights reserved.
//

#import "UIImage+JXExtension.h"
#import <AVFoundation/AVFoundation.h>


@implementation UIImage (JXExtension)


/**
 返回已经改变的图片

 @param image 图片
 @param size 所需图片尺寸
 @return 图片
 */
+ (UIImage *) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}


/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 
 */
+ (UIImage *) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height{
    CGRect r = CGRectMake(0.0f,0.0f,1.0f, height);UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();CGContextSetFillColorWithColor(context, [color CGColor]);CGContextFillRect(context, r);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();UIGraphicsEndImageContext();
    
    return img;
}

/**
 根据view生成图片
 
 @param view view
 @return image
 */
+ (UIImage *) createImageFromView:(UIView *)view{
    
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}




/**
 取出视频的每一帧图片

 @param videoURL 视频url
 @param time 时间
 @return 图片
 */
+ (UIImage *) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    
    
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
    
    return thumbnailImage;
}


//
///**
// 获取SDWebImage缓存图片
//
// @return 缓存的图片
// */
//+ (UIImage*)imageFromSdcacheWithURLString:(NSString *)urlString{
//    
//    NSData *imageData =nil;
//    
//    BOOL isExit = [[SDWebImageManager sharedManager]diskImageExistsForURL:[NSURL URLWithString:urlString]];
//    
//    if(isExit) {
//        
//        NSString *cacheImageKey = [[SDWebImageManager sharedManager]cacheKeyForURL:[NSURL URLWithString:urlString]];
//        
//        if(cacheImageKey.length) {
//            
//            NSString *cacheImagePath = [[SDImageCache sharedImageCache]defaultCachePathForKey:cacheImageKey];
//            
//            if(cacheImagePath.length) {
//                
//                imageData = [NSData dataWithContentsOfFile:cacheImagePath];
//                
//            }
//            
//        }
//        
//    }
//    
//    if(!imageData) {
//        
//        imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
//        
//    }
//    
//    UIImage *image = [UIImage imageWithData:imageData];
//    
//    return image;
//    
//}





@end
