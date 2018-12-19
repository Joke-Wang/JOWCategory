//
//  UIView+Gradient.m
//  HeroCoinSDK
//
//  Created by Joke Wang on 2018/7/9.
//  Copyright © 2018年 zhutaofeng. All rights reserved.
//

#import "UIView+Gradient.h"

@implementation UIView (Gradient)
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
                                    toColor:(UIColor *)toColor
{
    
    UIView *view = [[UIView alloc] init];
    
    view.frame = frame;
    
    [view zz_viewWithGradualChangingColor:direction
                                fromColor:fromColor
                                  toColor:toColor];
    
    return view;
}

/**
 给View绘制j渐变色
 
 @param direction 渐变色变化方向
 @param fromColor 渐变色开始颜色
 @param toColor 渐变色结束颜色
 @return 绘制有渐变的色view
 */
- (UIView *)zz_viewWithGradualChangingColor:(GradualDirection)direction
                                  fromColor:(UIColor *)fromColor
                                    toColor:(UIColor *)toColor
{
    return [self zz_viewWithGradualChangingColor:direction
                                           frame:self.bounds
                                       fromColor:fromColor
                                         toColor:toColor];
}

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
                                    toColor:(UIColor *)toColor
{
    
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = frame;
    
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)fromColor.CGColor, (__bridge id)toColor.CGColor];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    switch (direction) {
        case GradualDirectionWithLeftToRight:
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(1, 0);
            break;
        case GradualDirectionWithTopToBottom:
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(0, 1);
            break;
        case GradualDirectionWithTopLeftToBottomRight:
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(1, 1);
            break;
        case GradualDirectionWithBottomLeftToTopRight:
            gradientLayer.startPoint = CGPointMake(0, 1);
            gradientLayer.endPoint = CGPointMake(1, 0);
            break;
            
        default:
            break;
    }
    
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    
    for (CALayer *lay in self.layer.sublayers) {
        if ([lay isKindOfClass:[CAGradientLayer class]]) {
            CAGradientLayer *lay0 = (CAGradientLayer *)lay;
            if ([lay0.colors isEqualToArray:gradientLayer.colors] &&
                ([lay0.locations isEqualToArray:gradientLayer.locations])) {
                [lay removeFromSuperlayer];
            }
        }
    }
    
    [self.layer addSublayer:gradientLayer];
    
    return self;
}

@end
