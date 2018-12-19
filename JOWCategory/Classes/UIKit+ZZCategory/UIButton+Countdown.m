//
//  UIButton+Countdown.m
//  ShopApp
//
//  Created by Joke Wang on 16/1/18.
//  Copyright © 2016年 cong. All rights reserved.
//

#import "UIButton+Countdown.h"

@implementation UIButton (Countdown)

- (void)zz_startWithTime:(NSInteger)times
    countDownTitleFormat:(NSString *)formatStr {
    
    self.userInteractionEnabled = false;
    self.enabled = false;
    NSString *titleStr = self.titleLabel.text;
    UIColor *acoler = self.backgroundColor;
    
    // 倒计时时间
    __block NSInteger timeOut = times;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        if (!self) {
            return ;
        }
        
        timeOut--;
        
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = acoler;
                [self setTitle:titleStr forState:UIControlStateNormal];
                self.userInteractionEnabled = true;
                self.enabled = true;
            });
            
        } else {
            
            int seconds = timeOut % 60;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = [UIColor whiteColor];
                [self setTitle:[NSString stringWithFormat:@"%@%@", timeStr, formatStr]
                      forState:UIControlStateDisabled];
                self.userInteractionEnabled = false;
                self.enabled = false;
            });
            
        }
    });
    
    dispatch_resume(_timer);
    
}


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
              countColor:(UIColor *)color
{
    
    self.userInteractionEnabled = NO;
    self.enabled = false;
    NSString *titleStr = self.titleLabel.text;
    UIColor *acoler = self.backgroundColor;
    
    // 倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        if (!self) {
            return ;
        }
        
        timeOut--;
        
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = acoler;
                [self setTitle:titleStr forState:UIControlStateNormal];
                self.userInteractionEnabled = true;
                self.enabled = true;
            });
            
        } else {
            
            int seconds = timeOut % 60;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = color;
                [self setTitle:[NSString stringWithFormat:@"%@%@", timeStr, subTitle] forState:UIControlStateNormal];
                self.userInteractionEnabled = false;
                self.enabled = false;
            });
        }
    });
    
    dispatch_resume(_timer);
}


@end
