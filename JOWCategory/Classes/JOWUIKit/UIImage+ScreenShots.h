//
//  UIImage+ScreenShots.h
//  Time
//
//  Created by 王章仲 on 2018/10/11.
//  Copyright © 2018年 Time. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ScreenShots)
/**
 将View转换为图片（截图）
 
 @param view 将要转换的View
 @return 转化完成地图片
 */
+ (UIImage *)imageFromView:(UIView *)view;

/**
 将View的区域转换为图片（截图）
 
 @param view 将要转换的View
 @param frame 将要转换的View中选中d转换的区域
 @return 转化完成地图片
 */
+ (UIImage *)imageFromView:(UIView *)view frame:(CGRect)frame;

/**
 将View转换为图片（截图）
 
 @param scrollView 将要转换的ScrollView
 @return 转化完成地图片
 */
+ (UIImage *)imageFromScrollView:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
