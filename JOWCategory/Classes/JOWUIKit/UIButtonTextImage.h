//
//  UIButtonTextImage.h
//  bimeiti
//
//  Created by Joke Wang on 2018/3/23.
//  Copyright © 2018年 com.bi.meiti. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * button style
 *
 * 用户设置以设置为准，不设置，按照系统默认显示
 */
typedef NS_ENUM(NSUInteger, ZZButtonStyleType) {
    ZZButtonStyleTypeText,                  //纯文字
    ZZButtonStyleTypeImage,                 //纯图片
    ZZButtonStyleTypeLeftImageAndRightText, //左图片 右文字
    ZZButtonStyleTypeLeftTextAndRightImage, //左文字 右图片
    ZZButtonStyleTypeTopImageAndBottomText, //上图片 下文字
};

@interface UIButtonTextImage : UIButton
/**
 * 按钮样式
 */
@property (nonatomic, assign) ZZButtonStyleType zz_buttonStyle;

@end
