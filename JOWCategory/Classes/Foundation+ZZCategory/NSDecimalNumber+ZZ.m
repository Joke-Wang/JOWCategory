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
- (NSDecimalNumber *)zz_formatWithScale:(NSUInteger)decimalDigits {
    NSDecimalNumberHandler *handle = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:decimalDigits raiseOnExactness:YES raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    return [self decimalNumberByRoundingAccordingToBehavior:handle];
    
    
}

- (NSString *)zz_displayAmountWithScale:(NSUInteger)decimalDigits {
    return [self zz_displayAmountWithScale:decimalDigits effectiveScale:decimalDigits];
}

- (NSString *)zz_displayAmountWithScale:(NSUInteger)maximumDecimalDigits
                         effectiveScale:(NSUInteger)minimumDecimalDigits
{
    NSString *display = [[self zz_formatWithScale:maximumDecimalDigits] stringValue];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    // 设置格式
    //    numberFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_CN"];
    numberFormatter.decimalSeparator = K_ZZ_DecimalSeparator;
    
    numberFormatter.maximumFractionDigits = maximumDecimalDigits;  // 最大小数位数
    numberFormatter.minimumFractionDigits = minimumDecimalDigits;  // 最小小数位数
    
    display = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[display doubleValue]]];
    
    return display;
}

@end
