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

- (NSDecimalNumber *)zz_formatWithScale:(NSUInteger)decimalDigits;
- (NSString *)zz_displayAmountWithScale:(NSUInteger)decimalDigits;
- (NSString *)zz_displayAmountWithScale:(NSUInteger)maximumDecimalDigits
                         effectiveScale:(NSUInteger)minimumDecimalDigits;
@end


@interface NSDecimalNumber (Calculate)

/**
 * 求和
 
 * @param numbers 加数数组
 */
+ (NSDecimalNumber *)zz_sumWithDecimalNumberArray:(NSArray<NSDecimalNumber *> *)numbers;

/**
 * 求和
 
 * @param numberA 加数A
 * @param numberB 加数B
 */
+ (NSDecimalNumber *)zz_sumWithDecimalNumberA:(NSDecimalNumber *)numberA
                               DecimalNumberB:(NSDecimalNumber *)numberB;

- (NSDecimalNumber *)zz_decimalNumberByAdding:(NSDecimalNumber *)number;

/**
 * 求差
 
 * @param subtracted 减数
 * @param subtract   被减数
 */
+ (NSDecimalNumber *)zz_differenceWithSubtractedDecimalNumber:(NSDecimalNumber *)subtracted
                                        subtractDecimalNumber:(NSDecimalNumber *)subtract;

- (NSDecimalNumber *)zz_decimalNumberBySubtracting:(NSDecimalNumber *)number;

/**
 * 乘积
 
 * @param multipliers 乘数数组
 */
+ (NSDecimalNumber *)zz_productWithMultiplierDecimalNumberArray:(NSArray<NSDecimalNumber *> *)multipliers;

/**
 * 乘积

 * @param multiplierA 乘数A
 * @param multiplierB 乘数B
 */
+ (NSDecimalNumber *)zz_productWithMultiplierDecimalNumberA:(NSDecimalNumber *)multiplierA
                                   multiplierDecimalNumberB:(NSDecimalNumber *)multiplierB;

- (NSDecimalNumber *)zz_decimalNumberByMultiplyingBy:(NSDecimalNumber *)number;

/**
 * 求商
 
 * @param divisorA 除数A
 * @param divisorB 被除数B
 */
+ (NSDecimalNumber *)zz_quotientWithDivisorDecimalNumberA:(NSDecimalNumber *)divisorA
                                    divisorDecimalNumberB:(NSDecimalNumber *)divisorB;

- (NSDecimalNumber *)zz_decimalNumberByDividingBy:(NSDecimalNumber *)number;




@end



