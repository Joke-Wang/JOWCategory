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

@implementation NSDecimalNumber (Display)

/**
 * 固定小数位数的十进制数
 */
- (NSDecimalNumber *)zz_formatWithScale:(NSUInteger)decimalDigits {
    NSDecimalNumberHandler *handle = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:decimalDigits raiseOnExactness:YES raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    return [self decimalNumberByRoundingAccordingToBehavior:handle];
}

/**
 * 固定小数位数的十进制数字符串
 */
- (NSString *)zz_displayAmountWithScale:(NSUInteger)decimalDigits {
    return [self zz_displayAmountWithScale:decimalDigits effectiveScale:decimalDigits];
}

/**
 * 十进制数字符串
 *
 * @param maximumDecimalDigits 小数位最大有效位数
 * @param minimumDecimalDigits 小数位最小有效位数
 */
- (NSString *)zz_displayAmountWithScale:(NSUInteger)maximumDecimalDigits
                         effectiveScale:(NSUInteger)minimumDecimalDigits
{
    NSString *display = [[self zz_formatWithScale:maximumDecimalDigits] stringValue];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    // 设置格式
    //    numberFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_CN"];
    numberFormatter.decimalSeparator = K_ZZ_DecimalSeparator;
    numberFormatter.minimumIntegerDigits = 1;  // 最小整数位数
    numberFormatter.maximumFractionDigits = maximumDecimalDigits;  // 最大小数位数
    numberFormatter.minimumFractionDigits = minimumDecimalDigits;  // 最小小数位数
    
    display = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[display doubleValue]]];
    
    return display;
}

/**
 * 带货币符号的金额显示
 */
- (NSString *)zz_localCurrencyWithScale:(NSUInteger)decimalDigits {
    NSString *display = [[self zz_formatWithScale:2] stringValue];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    // 设置格式
    //    numberFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_CN"];
    numberFormatter.numberStyle = kCFNumberFormatterCurrencyStyle;
    numberFormatter.decimalSeparator = K_ZZ_DecimalSeparator;
    numberFormatter.minimumIntegerDigits = 1;  // 最小整数位数
    numberFormatter.maximumFractionDigits = decimalDigits;  // 最大小数位数
    numberFormatter.minimumFractionDigits = decimalDigits;  // 最小小数位数
    
    display = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[display doubleValue]]];
    
    return display;
}

@end


@implementation NSDecimalNumber (Calculate)

// MARK: - 和
/**
 * 求和
 *
 * @param numbers 加数数组
 */
+ (NSDecimalNumber *)zz_sumWithDecimalNumberArray:(NSArray<NSDecimalNumber *> *)numbers
{
    
    NSDecimalNumber *sum = ZZ_DecimalNumber(@"0");
    
    if (numbers.count == 0) {
        return sum;
    }
    else if (numbers.count == 1) {
        sum = numbers.firstObject;
    }
    else {
        
        for (NSDecimalNumber *numA in numbers) {
            sum = [sum zz_decimalNumberByAdding:numA];
        }
        
    }
    
    return sum;
}

/**
 * 求和
 *
 * @param numberA 加数A
 * @param numberB 加数B
 */
+ (NSDecimalNumber *)zz_sumWithDecimalNumberA:(NSDecimalNumber *)numberA
                               DecimalNumberB:(NSDecimalNumber *)numberB
{
    return [numberA zz_decimalNumberByAdding:numberB];
}

/**
 * 加
 *
 * @param number 加数
 */
- (NSDecimalNumber *)zz_decimalNumberByAdding:(NSDecimalNumber *)number
{
    NSDecimalNumber *num1 = nil;
    NSDecimalNumber *num2 = nil;
    
    if (!self) {
        num1 = ZZ_DecimalNumber(@"0");
    } else {
        num1 = self;
    }
    
    if (!number) {
        num2 = ZZ_DecimalNumber(@"0");
    } else {
        num2 = number;
    }
    
    NSDecimalNumber *num = [num1 decimalNumberByAdding:num2];
    
    return num;
}

// MARK: - 差
/**
 * 求差
 *
 * @param subtracted 减数
 * @param subtract   被减数
 */
+ (NSDecimalNumber *)zz_differenceWithSubtractedDecimalNumber:(NSDecimalNumber *)subtracted
                                        subtractDecimalNumber:(NSDecimalNumber *)subtract
{
    
    return [subtracted zz_decimalNumberBySubtracting:subtract];
}

/**
 * 减
 *
 * @param number 减数
 */
- (NSDecimalNumber *)zz_decimalNumberBySubtracting:(NSDecimalNumber *)number
{
    NSDecimalNumber *num1 = nil;
    NSDecimalNumber *num2 = nil;
    
    if (!self) {
        num1 = ZZ_DecimalNumber(@"0");
    } else {
        num1 = self;
    }
    
    if (!number) {
        num2 = ZZ_DecimalNumber(@"0");
    } else {
        num2 = number;
    }
    
    NSDecimalNumber *num = [num1 decimalNumberBySubtracting:num2];
    
    return num;
}

// MARK: - 积
/**
 * 乘积
 *
 * @param multipliers 乘数数组
 */
+ (NSDecimalNumber *)zz_productWithMultiplierDecimalNumberArray:(NSArray<NSDecimalNumber *> *)multipliers
{
    NSDecimalNumber *sum = ZZ_DecimalNumber(@"1");
    
    if (multipliers.count == 0) {
        sum = ZZ_DecimalNumber(@"0");
    }
    else if (multipliers.count == 1) {
        sum = multipliers.firstObject;
    }
    else {
        
        for (NSDecimalNumber *numA in multipliers) {
            sum = [NSDecimalNumber zz_productWithMultiplierDecimalNumberA:sum
                                                 multiplierDecimalNumberB:numA];
        }
        
    }
    
    return sum;
}

/**
 * 乘积
 *
 * @param multiplierA 乘数A
 * @param multiplierB 乘数B
 */
+ (NSDecimalNumber *)zz_productWithMultiplierDecimalNumberA:(NSDecimalNumber *)multiplierA
                                   multiplierDecimalNumberB:(NSDecimalNumber *)multiplierB
{
    return [multiplierA zz_decimalNumberByMultiplyingBy:multiplierB];
}

/**
 * 乘
 *
 * @param number 乘数
 */
- (NSDecimalNumber *)zz_decimalNumberByMultiplyingBy:(NSDecimalNumber *)number
{
    NSDecimalNumber *num1 = nil;
    NSDecimalNumber *num2 = nil;
    
    if (!self) {
        num1 = ZZ_DecimalNumber(@"0");
    } else {
        num1 = self;
    }
    
    if (!number) {
        num2 = ZZ_DecimalNumber(@"0");
    } else {
        num2 = number;
    }
    
    NSDecimalNumber *num = [num1 decimalNumberByMultiplyingBy:num2];
    
    return num;
}

// MARK: - 商
/**
 * 求商
 *
 * @param divisorA 被除数A
 * @param divisorB 除数B
 */
+ (NSDecimalNumber *)zz_quotientWithDivisorDecimalNumberA:(NSDecimalNumber *)divisorA
                                    divisorDecimalNumberB:(NSDecimalNumber *)divisorB
{
    return [divisorA zz_decimalNumberByDividingBy:divisorB];
}

/**
 * 除
 *
 * @param number 除数
 */
- (NSDecimalNumber *)zz_decimalNumberByDividingBy:(NSDecimalNumber *)number
{
    NSDecimalNumber *num1 = nil;
    NSDecimalNumber *num2 = nil;
    
    if (!self) {
        num1 = ZZ_DecimalNumber(@"0");
    } else {
        num1 = self;
    }
    
    if (!number) {
        num2 = ZZ_DecimalNumber(@"1");
    } else {
        num2 = number;
    }
    
    NSDecimalNumber *num = [num1 decimalNumberByDividingBy:num2];
    
    return num;
}


@end
