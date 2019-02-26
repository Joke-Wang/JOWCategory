//
//  UIView+Frame.h
//  bimeiti
//
//  Created by Joke Wang on 2018/1/10.
//  Copyright © 2018年 com.bi.meiti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
// 左上角x坐标
- (CGFloat)x;
- (void)setX:(CGFloat)x;

// 左上角y坐标
- (CGFloat)y;
- (void)setY:(CGFloat)y;

// 宽
- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

// 高
- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

// 中心点x
- (CGFloat)centerX;
- (void)setCenterX:(CGFloat)x;

// 中心点y
- (CGFloat)centerY;
- (void)setCenterY:(CGFloat)y;

/** 获取最大x */
- (CGFloat)maxX;
/** 获取最小x */
- (CGFloat)minX;

/** 获取最大y */
- (CGFloat)maxY;
/** 获取最小y */
- (CGFloat)minY;

- (void)addSingleTapEvent:(dispatch_block_t)event;

- (CGRect (^)(UIView *))zz_getRelativeWindowFrame;

- (UIView *(^)(NSInteger))zz_getElementByTag;

@end
