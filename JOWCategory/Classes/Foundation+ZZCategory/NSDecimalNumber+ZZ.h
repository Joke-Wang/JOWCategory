//
//  NSDecimalNumber+ZZ.h
//  HeroCoinSDK
//
//  Created by Joke Wang on 2018/5/23.
//  Copyright © 2018年 zhutaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#define K_ZZ_DecimalSeparator @"."

@interface NSDecimalNumber (ZZ)

@end

@interface NSDecimalNumber (Calculate)

- (NSDecimalNumber *)zz_formatWithScale:(NSUInteger)decimalDigits;
- (NSString *)zz_displayAmountWithScale:(NSUInteger)decimalDigits;
- (NSString *)zz_displayAmountWithScale:(NSUInteger)maximumDecimalDigits
                      effectiveScale:(NSUInteger)minimumDecimalDigits;
@end



