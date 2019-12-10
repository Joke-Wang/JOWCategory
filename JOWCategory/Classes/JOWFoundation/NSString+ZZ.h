//
//  NSString+ZZ.h
//  bimeiti
//
//  Created by Joke Wang on 2018/4/27.
//  Copyright © 2018年 com.bi.meiti. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ChangeBlock)(NSString *num);

@interface NSString (DeviceModel)
+ (NSString *)zz_currentDeviceModel;

+ (NSString *)zz_systemVersionString;

+ (NSString *)zz_screenPix;

@end

@interface NSString (ZZ)

@end

@interface NSString (JsonClass)

- (id)jsonData;

@end

@interface NSString (Encryption)
- (NSString *)zz_MD5;
- (NSString*)zz_SHA1;

@end

@interface NSString (DecimalNumber)

- (NSDecimalNumber *)zz_decimalNumber;

- (NSString *)zz_removeInvalidSuffix;

- (NSString *)zz_amountWithScale:(NSUInteger)scale;

- (NSString *)zz_amountString;

@end

@interface NSString (CheckFormat)

/**
 * 是否只包含format中的字符
 */
- (BOOL)zz_validateStringWithFormat:(NSString *)format;

/**
 * 是否是纯数字（包含小数）
 */
- (BOOL)zz_isNumber;

/**
 * 是否是整数（不包含该小数点）
 */
- (BOOL)zz_isInteger;

/**
 * 是否是小数（包含该小数点）
 */
- (BOOL)zz_isDecimal;

/**
 * 小数点后最多n位，包含n位
 */
- (BOOL)zz_decimalMaxLength:(NSUInteger)length;

/**
 * 检查输入的字符串
 *
 * 首位输入小数点，补全小数点前的0
 * 保留小数点后8位有效数字
 * 去除字符串前无效的0
 */
- (NSString *)zz_checkInput;

/**
 * 去除字符串前无效的0
 */
- (NSString *)zz_removeInvalidPrefix;

@end


/**
 * 货币格式字符串
 */
@interface NSString (CurrencyFormat)

/**
 * 是否货币格式 "###,##0.00"
 *
 * @return 是否符合货币格式字符串
 */
- (BOOL)zz_isCurrencyFormat;


@end


/**
 * 不断变化的数值
 *
 * label金额赋值，返回不断变化的数值
 */
@interface NSString (TextNumber)

/**
 * 不断变化的数值
 *
 * @param from 开始的数值
 * @param to 结束的数值
 * @param change 变化中的数值
 */
+ (void)zz_setNumberFrom:(NSString *)from to:(NSString *)to change:(ChangeBlock)change;

/**
 * 不断变化的数值
 *
 * @param from 开始的数值
 * @param to 结束的数值
 * @param time 变化持续时间
 * @param change 变化中的数值
 */
+ (void)zz_setNumberFrom:(NSString *)from to:(NSString *)to durationTime:(float)time change:(ChangeBlock)change;


@end


@interface NSString (EquInfo)
+ (NSString *)zz_macString;

+ (NSString *)zz_idfaString;

+ (NSString *)zz_idfvString;

@end

/**
 * 根据点左右大小不一样
 *
 */
@interface NSString (Attributes)

+(NSMutableAttributedString *)zz_amountAttributedString:(NSString *)str
                                             preSize:(CGFloat)preSize
                                             sufSize:(CGFloat)sufSize;
 

@end


