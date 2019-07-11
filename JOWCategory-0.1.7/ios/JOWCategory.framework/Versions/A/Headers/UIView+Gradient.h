//
//  UIView+Gradient.h
//  HeroCoinSDK
//
//  Created by Joke Wang on 2018/7/9.
//  Copyright © 2018年 zhutaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GradualDirection) {
    GradualDirectionWithLeftToRight,
    GradualDirectionWithTopToBottom,
    GradualDirectionWithTopLeftToBottomRight,
    GradualDirectionWithBottomLeftToTopRight,
};

@interface UIView (Gradient)

/**
 创建绘制有渐变色的View
 
 @param direction 渐变色变化方向
 @param frame 指定位置
 @param fromColor 渐变色开始颜色
 @param toColor 渐变色结束颜色
 @return 绘制有渐变的色view
 */
+ (UIView *)zz_viewWithGradualChangingColor:(GradualDirection)direction
                                      frame:(CGRect)frame
                                  fromColor:(UIColor *)fromColor
                                    toColor:(UIColor *)toColor;

/**
 给View绘制j渐变色
 
 @param direction 渐变色变化方向
 @param fromColor 渐变色开始颜色
 @param toColor 渐变色结束颜色
 @return 绘制有渐变的色view
 */
- (UIView *)zz_viewWithGradualChangingColor:(GradualDirection)direction
                                  fromColor:(UIColor *)fromColor
                                    toColor:(UIColor *)toColor;

/**
 给View的指定位置绘制j渐变色
 
 @param direction 渐变色变化方向
 @param frame 指定位置
 @param fromColor 渐变色开始颜色
 @param toColor 渐变色结束颜色
 @return 绘制有渐变的色view
 */
- (UIView *)zz_viewWithGradualChangingColor:(GradualDirection)direction
                                      frame:(CGRect)frame
                                  fromColor:(UIColor *)fromColor
                                    toColor:(UIColor *)toColor;

@end
