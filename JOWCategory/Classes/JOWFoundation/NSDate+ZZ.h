//
//  NSDate+ZZ.h
//  test
//
//  Created by Joke Wang on 16/11/3.
//  Copyright © 2016年 joke. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 iOS 时间格式说明
 
 G: 公元时代，例如AD公元
 yy: 年的后2位
 yyyy: 完整年
 MM: 月，显示为1-12
 MMM: 月，显示为英文月份简写,如 Jan
 MMMM: 月，显示为英文月份全称，如 Janualy
 dd: 日，2位数表示，如02
 d: 日，1-2位显示，如 2
 EEE: 简写星期几，如Sun
 EEEE: 全写星期几，如Sunday
 aa: 上下午，AM/PM
 H: 时，24小时制，0-23
 K：时，12小时制，0-11
 m: 分，1-2位
 mm: 分，2位
 s: 秒，1-2位
 ss: 秒，2位
 S: 毫秒
 Z：GMT
 */

typedef enum : NSUInteger {
    DatePrecisionWithSeconds        = 0, //秒
    DatePrecisionWithMilliseconds   = 1, //微秒
    DatePrecisionWithMicroseconds   = 2, //毫秒
} DatePrecision;

@interface NSDate (ZZ)

/// 公历转化为其他历法
/// @param calendar 需要转化为的历法
- (NSDate *)gregorianDateToOtherCalendar:(NSCalendar *)calendar;

/// 当前日历转为目标日历
/// @param currentCalendar 当前时间使用的日历
/// @param toCalendar 将要转化为的日历
- (NSDate *)currentCalendar:(NSCalendar *)currentCalendar toCalendar:(NSCalendar *)toCalendar;

#pragma mark - 判断时间是否为今年
/**
 判断时间是否为今年
 */
- (BOOL)isThisYear;

#pragma mark - 判断时间是否为昨天
/**
 判断时间是否为昨天
 */
- (BOOL)isYesterday;

#pragma mark - 判断时间是否为今天
/**
 判断时间是否为今天
 */
- (BOOL)isToday;

#pragma mark - 时间戳字符串
/**
 时间戳字符串
 */
@property (nonatomic, copy, readonly) NSString *timeStampString;
- (NSString *)zz_timeStampStringWithPrecision:(DatePrecision)sender;

#pragma mark - 时间成分
/**
 时间成分
 */
@property (nonatomic, strong, readonly) NSDateComponents *components;

/** 年 */
@property (nonatomic, assign, readonly) NSInteger year;
/** 月 */
@property (nonatomic, assign, readonly) NSInteger month;
/** 日 */
@property (nonatomic, assign, readonly) NSInteger day;
/** 时 */
@property (nonatomic, assign, readonly) NSInteger hour;
/** 分 */
@property (nonatomic, assign, readonly) NSInteger minute;
/** 秒 */
@property (nonatomic, assign, readonly) NSInteger second;
/** 星期 */
@property (nonatomic, assign, readonly) NSInteger weekday;
/** 星期 星期日-星期六） */
@property (nonatomic,   copy, readonly) NSString *weekDay;

/** 是当年的第几天 */
@property (nonatomic, assign, readonly) NSInteger daysAtYear;
/** 是当年的第几周 */
@property (nonatomic, assign, readonly) NSInteger weeksAtYear;
/** 是当月的第几周 */
@property (nonatomic, assign, readonly) NSInteger weeksAtMonth;
/** 是否闰年 */
@property (nonatomic, assign, readonly) BOOL isLeapYear;
/** 是否工作日 */
@property (nonatomic, assign, readonly) BOOL isWeekdays;

#pragma mark - 时间戳转换为时间字符串
/**
 时间戳转换为时间字符串
 
 @param date 要转变的时间戳
 @param formatString 输出显示方式（如@"yyyy-MM-dd"）
 @return formatString格式的字符串时间
 */
+ (NSString *)zz_dateStringWithdateFrom1970:(long long)date withFormat:(NSString *)formatString;
+ (NSString *)zz_dateStringWithDate:(NSDate *)date withFormat:(NSString *)formatString;
+ (NSDate *)zz_dateStringWithdateFrom1970:(long long)date;

#pragma mark - 按照给定时间输出NSDate对象
/**
 按照给定时间输出NSDate对象

 @param year 年
 @param month 月
 @param day 日
 @param hour 时
 @param minute 分
 @param second 秒
 @return 返回的NSDate对象
 */
+ (NSDate *)zz_dateWithYear:(NSUInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
                    hour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second;

/// 按照给定时间输出NSDate对象
/// @param calendar 日历（公历、中国农历、佛历等，默认使用公历）
/// @param year 年
/// @param month 月
/// @param day 日
/// @param hour 时
/// @param minute 分
/// @param second 秒
/// @param timeZone 时区（默认使用systemTimeZone）
+ (NSDate *)zz_dateWithCalendar:(NSCalendar *)calendar
                           year:(NSUInteger)year
                          month:(NSInteger)month
                            day:(NSInteger)day
                           hour:(NSInteger)hour
                         minute:(NSInteger)minute
                         second:(NSInteger)second
                       timeZone:(NSTimeZone *)timeZone;

// MARK: - 设置时间格式
/**
 设置时间格式

 @param formatString 想要显示的时间格式
                    如：@"YYYY-MM-dd HH:mm:ss"
                    @"YYYY.MM.dd"
                    @"YYYY-MM-dd"
                    @"MM-dd HH:mm"
                    @"HH:mm"
                    @"YYYY年MM月dd日 HH:mm"
                    @"MM月dd日 HH:mm"
 @return 返回DateFormatter类型的时间格式
 */
+ (NSDateFormatter *)zz_dateFormatterWithString:(NSString *)formatString;



// MARK: - 判断与某天是否为同一天/周/月/年
/**
 判断与某天是否同一  天

 @param otherDate 某天
 */
- (BOOL)zz_sameDayWithDate:(NSDate *)otherDate;

/**
 判断与某天是否同一  周
 
 @param otherDate 某天
 */
- (BOOL)zz_sameWeekWithDate:(NSDate *)otherDate;

/**
 判断与某天是否同一  月
 
 @param otherDate 某天
 */
- (BOOL)zz_sameMonthWithDate:(NSDate *)otherDate;

/**
 判断与某天是否同一  年
 
 @param otherDate 某天
 */
- (BOOL)zz_sameYearWithDate:(NSDate *)otherDate;





@end
