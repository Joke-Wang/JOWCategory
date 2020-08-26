//
//  UIColor+Gradient.m
//  HeroCoinSDK
//
//  Created by Joke Wang on 2018/7/2.
//  Copyright © 2018年 zhutaofeng. All rights reserved.
//

#import "UIColor+Gradient.h"

@implementation UIColor (Gradient)

//绘制渐变色颜色的方法
+ (CAGradientLayer *)zz_setGradualChangingColor:(UIView *)view
                                      fromColor:(UIColor *)fromColor
                                        toColor:(UIColor *)toColor {
    
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)fromColor.CGColor, (__bridge id)toColor.CGColor];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    
    return gradientLayer;
}

@end


@implementation UIColor (Change)
/**
 变化的颜色
 
 @param fromColor 开始变化时的颜色
 @param toColor 变化完成时的颜色
 @param progress 变化进度（0.0-1.0）
 @return 变化中的颜色
 */
+ (UIColor *)zz_changeFromColor:(UIColor *)fromColor
                        toColor:(UIColor *)toColor
                       progress:(float)progress
{
    NSArray *beginRGBA = [self zz_getRGBWithColor:fromColor];
    NSArray *endRGBA = [self zz_getRGBWithColor:toColor];
    
    NSMutableArray *colorDifference = [NSMutableArray array];
    [colorDifference removeAllObjects];
    for (int i = 0; i < beginRGBA.count; i ++) {
        CGFloat colorDifferenceElement = [endRGBA[i] floatValue] - [beginRGBA[i] floatValue];
        [colorDifference addObject:@(colorDifferenceElement)];
    }
    UIColor *returnColor = [UIColor colorWithRed:([beginRGBA[0] floatValue] + [colorDifference[0] floatValue] * progress)
                                           green:([beginRGBA[1] floatValue] + [colorDifference[1] floatValue] * progress)
                                            blue:([beginRGBA[2] floatValue] + [colorDifference[2] floatValue] * progress)
                                           alpha:([beginRGBA[3] floatValue] + [colorDifference[3] floatValue] * progress)];
    
    return returnColor;
}


/**
 根据颜色获取色值RGBA数组
 
 @param color 颜色
 @return RGBA数组
 */
+ (NSArray *)zz_getRGBWithColor:(UIColor *)color {
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return @[@(red), @(green), @(blue), @(alpha)];
}

@end

@implementation UIColor (Random)

+ (UIColor *)jow_randomColor {
    return [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1.0];
}

@end
