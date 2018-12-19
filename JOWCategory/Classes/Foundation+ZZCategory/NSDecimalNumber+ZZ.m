//
//  NSDecimalNumber+ZZ.m
//  HeroCoinSDK
//
//  Created by Joke Wang on 2018/5/23.
//  Copyright © 2018年 zhutaofeng. All rights reserved.
//

#import "NSDecimalNumber+ZZ.h"
#import "NSString+ZZ.h"

@implementation NSDecimalNumber (ZZ)

@end

@implementation NSDecimalNumber (Calculate)
- (NSDecimalNumber *)zz_formatWithScale:(NSUInteger)scale {
    NSDecimalNumberHandler *handle = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:scale raiseOnExactness:YES raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    return [self decimalNumberByRoundingAccordingToBehavior:handle];
    
    
}

- (NSString *)zz_displayAmountWithScale:(NSUInteger)scale {
    NSString *display = [[self zz_formatWithScale:scale] stringValue];
    
    NSString *format = @"#####0.";
    for (int i = 0; i < scale; i ++) {
        format = [format stringByAppendingString:@"0"];
    }
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    // 设置格式
    [numberFormatter setPositiveFormat:format];
    display = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[display doubleValue]]];
    
    NSUInteger afterStrLength = [display componentsSeparatedByString:@"."].lastObject.length;
    afterStrLength = ((afterStrLength > 2) ? (afterStrLength - 2) : afterStrLength);
    
    NSString *beforeStr = [display substringToIndex:(display.length - afterStrLength)];
    NSString *afterStr = [display substringFromIndex:(display.length - afterStrLength)];
    
    return [beforeStr stringByAppendingString:[afterStr zz_removeInvalidSuffix]];
}

@end
