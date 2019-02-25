//
//  UILabel+WH.m
//  PineLoan
//
//  Created by Joke Wang on 2016/12/9.
//  Copyright © 2016年 joke. All rights reserved.
//

#import "UILabel+WH.h"

#define IS_NULL(x)          (!x || [x isKindOfClass:[NSNull class]])
#define IS_EMPTY_STRING(x)  (IS_NULL(x) || [x isEqual:@""] || [x isEqual:@"(null)"])
#define DEFUSE_EMPTY_STRING(x)     (!IS_EMPTY_STRING(x) ? x : @"")
#define DISPLAY_STRING(text, defaultStr) ([DEFUSE_EMPTY_STRING(text) isEqualToString:@""] ? ([DEFUSE_EMPTY_STRING(defaultStr) isEqualToString:@""] ? @"" : DEFUSE_EMPTY_STRING(defaultStr)) : DEFUSE_EMPTY_STRING(text))

@implementation UILabel (WH)

/**
 * 根据已设置属性计算blabel宽度
 */
- (CGFloat)zz_labelWidth {
    UIFont *font = self.font;
    NSString *text = self.text;
    
    return [text boundingRectWithSize:CGSizeMake(MAXFLOAT, font.xHeight)
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{ NSFontAttributeName : font }
                              context:nil].size.width + 1;
}

/**
 * 根据已设置属性计算label高度
 */
- (CGFloat)zz_labelHeight {
    return [self zz_labelHeightWithWidth:CGRectGetWidth(self.frame)];
}

/**
 * 根据给定宽度计算label宽度
 */
- (CGFloat)zz_labelHeightWithWidth:(CGFloat)width {
    UIFont *font = self.font;
    NSString *text = self.text;
    
    return [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName : font}
                              context:nil].size.height;
}

/**
 * 给label内容添加行间距
 */
- (void)zz_changeLineSpaceWithSpace:(float)space {
    
    [self zz_changeSpaceWithLineSpace:space WordSpace:0];
    
}

/**
 * 给label内容添加字间距
 */
- (void)zz_changeWordSpaceWithSpace:(float)space {
    
    [self zz_changeSpaceWithLineSpace:0 WordSpace:space];
    
}

/**
 * 给label内容添加行间距和字间距
 *
 * @param lineSpace 行间距
 * @param wordSpace 字间距
 */
- (void)zz_changeSpaceWithLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = self.text;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    [attributedString addAttribute:NSKernAttributeName value:@(wordSpace) range:NSMakeRange(0, [labelText length])];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    
    self.attributedText = attributedString;
    [self sizeToFit];
    
}

@end


/**
 * 数值变化的label
 */
@implementation UILabel (TextNumber)

/**
 * 给label设置数值，带动画效果
 *
 * @param sender 将要显示的数值
 */
- (void)zz_setTextNumber:(NSString *)sender {
    __weak typeof(self) weakself = self;
    
    [self zz_setNumberFrom:self.text to:sender durationTime:1.0 change:^(NSString *num) {
        weakself.text = num;
    }];
}

- (void)zz_setNumberFrom:(NSString *)from to:(NSString *)to durationTime:(float)time change:(void (^) (NSString *num))change {
    
    if (!to && from) {
        !change ? : change(from);
        return;
    }
    
    if (!from && !to) {
        !change ? : change(@"0.00");
        return;
    }
    
    if ([from isEqualToString:to]) {
        !change ? : change(to);
        return;
    }
    
    //动画持续时间
    float durationTime = time;
    
    //旧值
    CGFloat old = [DEFUSE_EMPTY_STRING(from) doubleValue];
    
    //新值
    CGFloat new = [DEFUSE_EMPTY_STRING(to) doubleValue];
    
    //新旧值 差
    CGFloat poor = new - old;
    
    if (poor == 0) {
        !change ? : change(!from ? to : from);
        return;
    }
    
    //每帧增加数值
    CGFloat ratio = poor / (60.0 * durationTime);
    
    //计算保留小数点后位数
    NSUInteger scale = 0;
    
    BOOL isNumber = [self zz_validateStringWithFormat:@"0123456789." toString:to];
    BOOL partCount = [to componentsSeparatedByString:@"."].count == 2;
    
    if ((isNumber && partCount)) {
        scale = [[to componentsSeparatedByString:@"."].lastObject length];
    }
    
    //根据保留小数位数，定义字符显示格式
    NSString *format = [NSString stringWithFormat:@"%@.%@f", @"%", @(scale)];
    
    
    
    __block CGFloat resValue = [from doubleValue];
    
    NSTimeInterval period = 0.017; //设置时间间隔
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //按照时间间隔执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            resValue = resValue + ratio;
            
            if (((resValue >= new) && (ratio >= 0)) || ((resValue <= new) && (ratio <= 0))) {
                dispatch_source_cancel(_timer);
                NSString *displayString = [NSString stringWithFormat:format, new];
                !change ? : change(displayString);
            } else {
                NSString *displayString = [NSString stringWithFormat:format, resValue];
                !change ? : change(displayString);
            }
        });
        
    });
    
    dispatch_resume(_timer);
    
}

- (BOOL)zz_validateStringWithFormat:(NSString *)format toString:(NSString *)string {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:format];
    int i = 0;
    while (i < string.length) {
        NSString * temp = [string substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [temp rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


@end


