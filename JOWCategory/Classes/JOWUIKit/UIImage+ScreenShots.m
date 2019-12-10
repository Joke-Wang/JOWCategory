//
//  UIImage+ScreenShots.m
//  Time
//
//  Created by 王章仲 on 2018/10/11.
//  Copyright © 2018年 Time. All rights reserved.
//

#import "UIImage+ScreenShots.h"

@implementation UIImage (ScreenShots)

/**
 将View转换为图片（截图）
 
 @param view 将要转换的View
 @return 转化完成地图片
 */
+ (UIImage *)imageFromView:(UIView *)view
{
    return [UIImage imageFromView:view.superview frame:view.frame];
}

/**
 将View的区域转换为图片（截图）
 
 @param view 将要转换的View
 @param frame 将要转换的View中选中d转换的区域
 @return 转化完成地图片
 */
+ (UIImage *)imageFromView:(UIView *)view frame:(CGRect)frame
{
    int scale = [UIScreen mainScreen].scale;
    CGRect rect = frame;
    rect.origin.x *= scale;
    rect.origin.y *= scale;
    rect.size.width *= scale;
    rect.size.height *= scale;
    
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数。
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, scale);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGImageRef cgImage = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage * newImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return newImage;
}

/**
 将View转换为图片（截图）
 
 @param scrollView 将要转换的ScrollView
 @return 转化完成地图片
 */
+ (UIImage *)imageFromScrollView:(UIScrollView *)scrollView {
    UIImage* image = nil;
    
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，调整清晰度。
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, YES, [UIScreen mainScreen].scale);
    
    CGPoint savedContentOffset = scrollView.contentOffset;
    CGRect savedFrame = scrollView.frame;
    scrollView.contentOffset = CGPointZero;
    scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
    [scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    scrollView.contentOffset = savedContentOffset;
    scrollView.frame = savedFrame;
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
