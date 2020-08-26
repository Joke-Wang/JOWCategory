//
//  UIColor+Gradient.h
//  HeroCoinSDK
//
//  Created by Joke Wang on 2018/7/2.
//  Copyright © 2018年 zhutaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Gradient)

/**
 绘制渐变色
 
 @param view 目标View
 @param fromColor 渐变色起始颜色
 @param toColor 渐变色终止颜色
 @return 绘制完成的渐变色图层
 */
+ (CAGradientLayer *)zz_setGradualChangingColor:(UIView *)view
                                      fromColor:(UIColor *)fromColor
                                        toColor:(UIColor *)toColor;

@end

@interface UIColor (Change)

/**
 变化的颜色
 
 @param fromColor 开始变化时的颜色
 @param toColor 变化完成时的颜色
 @param progress 变化进度（0.0-1.0）
 @return 变化中的颜色
 */
+ (UIColor *)zz_changeFromColor:(UIColor *)fromColor
                        toColor:(UIColor *)toColor
                       progress:(float)progress;

@end

@interface UIColor (Random)

+ (UIColor *)jow_randomColor;

@end
