//
//  UIButton+Countdown.h
//  ShopApp
//
//  Created by Joke Wang on 16/1/18.
//  Copyright © 2016年 cong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Countdown)

/**
 倒计时按钮
 
 @param times 倒计时时间（秒）
 @param formatStr 倒计时显示的时间格式
 */
- (void)zz_startWithTime:(NSInteger)times
    countDownTitleFormat:(NSString *)formatStr;

/**
 *    倒计时按钮
 *    @param timeLine  倒计时总时间
 *    @param title     还没倒计时的title
 *    @param subTitle  倒计时的子名字 如：时、分
 *    @param mColor    还没倒计时的颜色
 *    @param color     倒计时的颜色
 */
- (void)zz_startWithTime:(NSInteger)timeLine
                   title:(NSString *)title
          countDownTitle:(NSString *)subTitle
               mainColor:(UIColor *)mColor
              countColor:(UIColor *)color;

@end
