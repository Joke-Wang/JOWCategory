//
//  NSDecimalNumber+ZZ.h
//  HeroCoinSDK
//
//  Created by Joke Wang on 2018/5/23.
//  Copyright © 2018年 zhutaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#define K_ZZ_DecimalSeparator @"."

#define ZZ_DecimalNumber(numberString) [NSDecimalNumber decimalNumberWithString:[numberString isKindOfClass:[NSString class]] ? numberString : [((id)numberString) stringValue]]

@interface NSDecimalNumber (ZZ)

@end

@interface NSDecimalNumber (Display)

/**
 * 固定小数位数的十进制数
 */
- (NSDecimalNumber *)zz_formatWithScale:(NSUInteger)decimalDigits;

/**
 * 固定小数位数的十进制数字符串
 */
- (NSString *)zz_displayAmountWithScale:(NSUInteger)decimalDigits;

/**
 * 十进制数字符串
 *
 * @param maximumDecimalDigits 小数位最大有效位数
 * @param minimumDecimalDigits 小数位最小有效位数
 */
- (NSString *)zz_displayAmountWithScale:(NSUInteger)maximumDecimalDigits
                         effectiveScale:(NSUInteger)minimumDecimalDigits;

/**
 * 带货币符号的金额显示
 */
- (NSString *)zz_localCurrencyWithScale:(NSUInteger)decimalDigits;

@end


@interface NSDecimalNumber (Calculate)

// MARK: - 和
/**
 * 求和
 *
 * @param numbers 加数数组
 */
+ (NSDecimalNumber *)zz_sumWithDecimalNumberArray:(NSArray<NSDecimalNumber *> *)numbers;

/**
 * 求和
 *
 * @param numberA 加数A
 * @param numberB 加数B
 */
+ (NSDecimalNumber *)zz_sumWithDecimalNumberA:(NSDecimalNumber *)numberA
                               DecimalNumberB:(NSDecimalNumber *)numberB;

/**
 * 加
 *
 * @param number 加数
 */
- (NSDecimalNumber *)zz_decimalNumberByAdding:(NSDecimalNumber *)number;

// MARK: - 差
/**
 * 求差
 *
 * @param subtracted 减数
 * @param subtract   被减数
 */
+ (NSDecimalNumber *)zz_differenceWithSubtractedDecimalNumber:(NSDecimalNumber *)subtracted
                                        subtractDecimalNumber:(NSDecimalNumber *)subtract;

/**
 * 减
 *
 * @param number 减数
 */
- (NSDecimalNumber *)zz_decimalNumberBySubtracting:(NSDecimalNumber *)number;

// MARK: - 积
/**
 * 乘积
 *
 * @param multipliers 乘数数组
 */
+ (NSDecimalNumber *)zz_productWithMultiplierDecimalNumberArray:(NSArray<NSDecimalNumber *> *)multipliers;

/**
 * 乘积
 *
 * @param multiplierA 乘数A
 * @param multiplierB 乘数B
 */
+ (NSDecimalNumber *)zz_productWithMultiplierDecimalNumberA:(NSDecimalNumber *)multiplierA
                                   multiplierDecimalNumberB:(NSDecimalNumber *)multiplierB;

/**
 * 乘
 *
 * @param number 乘数
 */
- (NSDecimalNumber *)zz_decimalNumberByMultiplyingBy:(NSDecimalNumber *)number;

// MARK: - 商
/**
 * 求商
 *
 * @param divisorA 被除数A
 * @param divisorB 除数B
 */
+ (NSDecimalNumber *)zz_quotientWithDivisorDecimalNumberA:(NSDecimalNumber *)divisorA
                                    divisorDecimalNumberB:(NSDecimalNumber *)divisorB;

/**
 * 除
 *
 * @param number 除数
 */
- (NSDecimalNumber *)zz_decimalNumberByDividingBy:(NSDecimalNumber *)number;




@end



