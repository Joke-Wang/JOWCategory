//
//  NSDate+ZZ.m
//  test
//
//  Created by Joke Wang on 16/11/3.
//  Copyright © 2016年 joke. All rights reserved.
//

#import "NSDate+ZZ.h"

@implementation NSDate (ZZ)


#pragma mark - 判断时间是否为今年
/**
 判断时间是否为今年
 */
- (BOOL)isThisYear {
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *dateCmps = [calender components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calender components:NSCalendarUnitYear fromDate:[NSDate date]];
    return (dateCmps.year == nowCmps.year);
}


#pragma mark - 判断时间是否为昨天
/**
 判断时间是否为昨天
 
 步骤：1.将现在时间和传入时间，转换为年月日格式（@"yyyy-MM-dd"）
      2.将处理过的时间转变为 NSDate格式，准备比较
      3.使用日历组件，比较两个时间
 */

- (BOOL)isYesterday {
    NSDate *now = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    NSDate *date = [fmt dateFromString:dateStr];
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    //cmps = fromDate - toDate
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return ((cmps.year == 0) && (cmps.month == 0) && (cmps.day == 1));
}


#pragma mark - 判断时间是否为今天
/**
 判断时间是否为今天
 
 步骤：1.将现在时间和传入时间，转换为年月日格式（@"yyyy-MM-dd"）
      2.判断两个处理后的字符串是否一致
 */
- (BOOL)isToday {
    NSDate *now = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}

#pragma mark - 时间戳字符串
/**
 时间戳字符串
 */
- (NSString *)timeStampString {
    return [@([self  timeIntervalSince1970]).stringValue copy];
}

- (NSString *)zz_timeStampStringWithPrecision:(DatePrecision)sender {
    NSTimeInterval intercal = [self timeIntervalSince1970];
    if (sender == DatePrecisionWithMilliseconds) {
        intercal = intercal * 1000;
    } else if (sender == DatePrecisionWithMicroseconds) {
        intercal = intercal * 1000 * 1000;
    }
    return [@([@(intercal) longLongValue]) stringValue].copy;
}

#pragma mark - 时间成分
/**
 时间成分
 */
- (NSDateComponents *)components {
    //创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //定义成分
//    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSCalendarUnit unit = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitNanosecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitQuarter | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitYearForWeekOfYear;
    
    return [calendar components:unit fromDate:self];
}


#pragma mark - 年
/** 年 */
- (NSInteger)year {
    return [self components].year;
}

#pragma mark - 月
/** 月 */
- (NSInteger)month {
    return [self components].month;
}

#pragma mark - 日
/** 日 */
- (NSInteger)day {
    return [self components].day;
}

#pragma mark - 时
/** 时 */
- (NSInteger)hour {
    return [self components].hour;
}

#pragma mark - 分
/** 分 */
- (NSInteger)minute {
    return [self components].minute;
}

#pragma mark - 秒
/** 秒 */
- (NSInteger)second {
    return [self components].second;
}

#pragma mark - 星期
/** 星期 周日-周六（1-7） */
- (NSInteger)weekday {
    return [self components].weekday;
}
/** 星期 星期日-星期六） */
- (NSString *)weekDay {
    switch (self.weekday) {
        case 1:
            return @"星期日";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
            
        default:
            break;
    }
    
    return @"";
}

#pragma mark - 是当年的第几天
/** 是当年的第几天 */
- (NSInteger)daysAtYear {
    NSInteger days = self.day;
    NSArray *daysArr = @[@31, @28, @31, @30, @31, @30, @31, @31, @30, @31, @30, @31];
    for (int i = 0; i < self.month - 1; i++) {
        days = days + [daysArr[i] integerValue];
    }
    if (self.isLeapYear && (self.month > 2)) {
        days = days + 1;
    }
    return days;
}

#pragma mark - 是当年的第几周
/** 是当年的第几周 */
- (NSInteger)weeksAtYear {
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitWeekOfYear inUnit:NSCalendarUnitYear forDate:self];
}

#pragma mark - 是当月的第几周
/** 是当月的第几周 */
- (NSInteger)weeksAtMonth {
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:self];
}

#pragma mark - 是否闰年
/** 是否闰年 */
- (BOOL)isLeapYear {
    return (self.year % 4 == 0);
}

#pragma mark - 是否工作日（周一至周五）
/** 是否工作日（周一至周五） */
- (BOOL)isWeekdays {
    return ((self.weekday > 1) && (self.weekday < 7));
}


#pragma mark - 时间戳转换为时间字符串
/**
 时间戳转换为时间字符串

 @param date 要转变的时间戳
 @param formatString 输出显示方式（如@"yyyy-MM-dd"）
 @return formatString格式的字符串时间
 */
+ (NSString *)zz_dateStringWithdateFrom1970:(long long)date withFormat:(NSString *)formatString {
    return [[self class] zz_dateStringWithDate:[self zz_dateStringWithdateFrom1970:date] withFormat:formatString];
}

+ (NSString *)zz_dateStringWithDate:(NSDate *)date withFormat:(NSString *)formatString {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatString];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

/**
 时间戳转换为时间(NSDate)

 @param date 要转变的时间戳
 @return NSDate
 */
+ (NSDate *)zz_dateStringWithdateFrom1970:(long long)date {
    NSDate *dateInfo;
    if ([NSString stringWithFormat:@"%lld", date].length == 16) {
        dateInfo = [NSDate dateWithTimeIntervalSince1970:date/1000000];
    } else if ([NSString stringWithFormat:@"%lld", date].length == 13) {
        dateInfo = [NSDate dateWithTimeIntervalSince1970:date/1000];
    } else if ([NSString stringWithFormat:@"%lld", date].length == 10) {
        dateInfo = [NSDate dateWithTimeIntervalSince1970:date];
    }
    return dateInfo;
}

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
                  second:(NSInteger)second
{
    return [NSDate zz_dateWithYear:year
                          month:month
                            day:day
                           hour:hour
                         minute:minute
                         second:second
                       timeZone:[NSTimeZone systemTimeZone]];
}

/**
 按照给定时间输出NSDate对象
 
 @param year 年
 @param month 月
 @param day 日
 @param hour 时
 @param minute 分
 @param second 秒
 @param timeZone 时区
 @return 返回的NSDate对象
 */
+ (NSDate *)zz_dateWithYear:(NSUInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
                    hour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second
                timeZone:(NSTimeZone *)timeZone
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitTimeZone fromDate:[NSDate date]];
    dateComponents.year = year;
    dateComponents.month = month;
    dateComponents.day = day;
    dateComponents.hour = hour;
    dateComponents.minute = minute;
    dateComponents.second = second;
    dateComponents.timeZone = timeZone;
    
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

#pragma mark - 设置时间格式
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
+ (NSDateFormatter *)zz_dateFormatterWithString:(NSString *)formatString {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatString];
    return formatter;
}

#pragma mark - 判断与某天是否为同一天/周/月/年
/**
 判断与某天是否同一  天
 
 @param otherDate 某天
 */
- (BOOL)zz_sameDayWithDate:(NSDate *)otherDate {
    return ((self.year == otherDate.year) && (self.daysAtYear == otherDate.daysAtYear));
}

/**
 判断与某天是否同一  周
 
 @param otherDate 某天
 */
- (BOOL)zz_sameWeekWithDate:(NSDate *)otherDate {
    return ((self.year == otherDate.year) && (self.weeksAtYear == otherDate.weeksAtYear));
}

/**
 判断与某天是否同一  月
 
 @param otherDate 某天
 */
- (BOOL)zz_sameMonthWithDate:(NSDate *)otherDate {
    return ((self.year == otherDate.year) && (self.month == otherDate.month));
}

/**
 判断与某天是否同一  年
 
 @param otherDate 某天
 */
- (BOOL)zz_sameYearWithDate:(NSDate *)otherDate {
    return (self.year == otherDate.year);
}




@end
