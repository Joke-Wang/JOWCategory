//
//  UIImage+QRCode.m
//  handheldCredit
//
//  Created by Joke Wang on 2017/3/14.
//  Copyright © 2017年 liguiwen. All rights reserved.
//

#import "UIImage+QRCode.h"

@implementation UIImage (QRCode)

/**
 生成二维码图片
 
 @param message 生成二维码要包含的信息
 @param size 输出的图片大小
 */
+ (UIImage *)QRCodeWithMessage:(NSString *)message
                     imageSize:(CGSize)size
{
    UIImage *image = [[UIImage alloc] init];
    return [image QRCodeWithMessage:message imageSize:size];
}

/**
 生成带中心标识二维码图片
 
 @param message 生成二维码要包含的信息
 @param size 输出的图片大小
 @param logo 中心logo
 */
+ (UIImage *)QRCodeWithMessage:(NSString *)message
                     imageSize:(CGSize)size
                     logoImage:(UIImage *)logo
{
    UIImage *image = [[UIImage alloc] init];
    return [image QRCodeWithMessage:message imageSize:size logoImage:logo];
}

/**
 生成二维码图片
 
 @param message 生成二维码要包含的信息
 @param size 输出的图片大小
 */
- (UIImage *)QRCodeWithMessage:(NSString *)message
                     imageSize:(CGSize)size
{
    return [self QRCodeWithMessage:message imageSize:size logoImage:nil];
}

/**
 生成带中心标识二维码图片
 
 @param message 生成二维码要包含的信息
 @param size 输出的图片大小
 @param logo 中心logo
 */
- (UIImage *)QRCodeWithMessage:(NSString *)message
                     imageSize:(CGSize)size
                     logoImage:(UIImage *)logo
{
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [filter setDefaults];
    
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    //fillColor
    CIColor *color1 = [CIColor colorWithCGColor:[UIColor blackColor].CGColor];
    //backgroundColor
    CIColor *color2 = [CIColor colorWithCGColor:[UIColor whiteColor].CGColor];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: filter.outputImage ,@"inputImage",
                                color1,@"inputColor0",
                                color2,@"inputColor1",nil];
    CIFilter *newFilter = [CIFilter filterWithName:@"CIFalseColor" withInputParameters:parameters];
    
    CIImage *outputImage = [newFilter outputImage];
    
    CIContext *context1 = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context1 createCGImage:outputImage
                                        fromRect:[outputImage extent]];
    
    CGRect extent = CGRectIntegral(outputImage.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    
    UIImage *image = [UIImage imageWithCGImage:cgImage
                                         scale:10 * scale
                                   orientation:UIImageOrientationUp];
    
    UIGraphicsBeginImageContext(CGSizeMake(size.width * 10, size.height * 10));
    
    CGContextRef context2 = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context2, kCGInterpolationNone);
    [image drawInRect:CGRectMake(0, 0, size.width * 10, size.height * 10)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    if (logo != nil) {
        //        UIGraphicsBeginImageContext(image.size);
        //
        //        //把二维码图片画上去. (这里是以,图形上下文,左上角为 (0,0)点)
        //        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        //
        //        CGRect logoRect = [self innerPositionRectWidth:image.size.width withVersion:[self fetchVersionWith:outputImage]];
        //
        ////        UIImage *view = [[UIImage alloc] init];
        ////
        ////        [view drawInRect:CGRectMake(logoRect.origin.x - 5, logoRect.origin.y - 5, logoRect.size.width - 10, logoRect.size.height - 10)];
        //
        //        [logo drawInRect:logoRect];
        //
        //        image = UIGraphicsGetImageFromCurrentImageContext();
        //
        //        //关闭图形上下文
        //        UIGraphicsEndImageContext();
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
        CGRect logoRect = [self innerPositionRectWidth:image.size.width withVersion:[self fetchVersionWith:outputImage]];
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.frame = CGRectMake(logoRect.origin.x - 5, logoRect.origin.y - 5, logoRect.size.width + 10, logoRect.size.height + 10);//logoRect;
        [imgView addSubview:view];
        
        
        UIImageView *logoView = [[UIImageView alloc] initWithImage:logo];
        logoView.frame = CGRectMake(logoRect.origin.x + 5, logoRect.origin.y + 5, logoRect.size.width - 10, logoRect.size.height - 10);
        logoView.layer.cornerRadius = logoRect.size.width/4;
        logoView.clipsToBounds = true;
        [imgView addSubview:logoView];
        
        UIGraphicsBeginImageContext(image.size);
        
        [imgView.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
    
    return image;
    
}

//获取二维码版本
- (CGFloat)fetchVersionWith:(CIImage *)image {
    return ((image.extent.size.width - 21)/4.0 + 1);
}

//获取中心logo图片的位置和大小
- (CGRect)innerPositionRectWidth:(CGFloat )width withVersion:(CGFloat )version {
    CGFloat leftMargin = width * 3 / ((version - 1) * 4 + 21);
    CGFloat centerImageWith = width * 7 / ((version - 1) * 4 + 21);
    
    CGRect rect = CGRectMake(leftMargin + 1.5, leftMargin + 1.5, leftMargin - 3, leftMargin - 3);
    rect = CGRectIntegral(rect);
    rect = CGRectInset(rect, -1, -1);
    
    CGFloat offset;
    rect = CGRectMake(CGPointZero.x, CGPointZero.y, centerImageWith, centerImageWith);
    offset = width/2 - centerImageWith/2;
    rect = CGRectOffset(rect, offset, offset);
    
    return rect;
}


/**
 获取图片
 
 @param size 截取的位置大小
 @param layer 截取的图层
 @param scale 缩放比例
 @return 生成的图片
 */
+ (UIImage *)screenShotWithSize:(CGSize)size
                          Layer:(CALayer *)layer
                          scale:(CGFloat)scale {
    UIImage* image = nil;
    /*
     *UIGraphicsBeginImageContextWithOptions有三个参数
     *size    bitmap上下文的大小，就是生成图片的size
     *opaque  是否不透明，当指定为YES的时候图片的质量会比较好
     *scale   缩放比例，指定为0.0表示使用手机主屏幕的缩放比例
     */
    UIGraphicsBeginImageContextWithOptions(size, false, scale);
    //此处我截取layer.
    [layer renderInContext: UIGraphicsGetCurrentContext()];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
