//
//  UIImage+QRCode.h
//  handheldCredit
//
//  Created by Joke Wang on 2017/3/14.
//  Copyright © 2017年 liguiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QRCode)
/**
 生成二维码图片
 
 @param message 生成二维码要包含的信息
 @param size 输出的图片大小
 */
+ (UIImage *)QRCodeWithMessage:(NSString *)message imageSize:(CGSize)size;
- (UIImage *)QRCodeWithMessage:(NSString *)message imageSize:(CGSize)size;

/**
 生成带中心标识二维码图片
 
 @param message 生成二维码要包含的信息
 @param size 输出的图片大小
 @param logo 中心logo
 */
+ (UIImage *)QRCodeWithMessage:(NSString *)message imageSize:(CGSize)size logoImage:(UIImage *)logo;
- (UIImage *)QRCodeWithMessage:(NSString *)message imageSize:(CGSize)size logoImage:(UIImage *)logo;

/**
 获取图片
 
 @param size 截取的位置大小
 @param layer 截取的图层
 @param scale 缩放比例
 @return 生成的图片
 */
+ (UIImage *)screenShotWithSize:(CGSize)size
                          Layer:(CALayer *)layer
                          scale:(CGFloat)scale;

@end
