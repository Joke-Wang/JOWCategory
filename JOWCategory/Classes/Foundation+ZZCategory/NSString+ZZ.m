//
//  NSString+ZZ.m
//  bimeiti
//
//  Created by Joke Wang on 2018/4/27.
//  Copyright © 2018年 com.bi.meiti. All rights reserved.
//

#import "NSString+ZZ.h"

#include <net/if.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#import <CommonCrypto/CommonDigest.h>
#import <net/if_dl.h>
#import <AdSupport/AdSupport.h>

#import "ZZFoundationHeader.h"
#import "NSDecimalNumber+ZZ.h"


@implementation NSString (ZZ)

@end

@implementation NSString (CurrentDeviceModel)
+ (NSString *)zz_currentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s (A1633A1688/A1691/A1700)";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus (A1634/A1687/A1690/A1699)";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE (A1662/A1723/A1724)";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7 (A1660/A1779/A1780)";         // Global
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus (A1661/A1785/A1786)";    // Global
    if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7 (A1778)";         // GSM
    if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus (A1784)";    // GSM
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8 (A1863/A1906/A1907)";         // Global
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus (A1864/A1898/A1899)";    // Global
    if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X (A1865/A1902)";         // Global
    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8 (A1905)";         // GSM
    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus (A1897)";    // GSM
    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X (A1901)";         // GSM
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS (A1920/A2097/A2098/A2100)";
    if ([platform isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max (A1921/A2101/A2102/A2104)";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR (A1984/A2105/A2106/A2108)";
    
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    if ([platform isEqualToString:@"iPod7,1"])   return @"iPod touch (6th generation) (A1574)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPad mini 4 (A1538)";
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPad mini 4 (A1550)";
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPad Air2 (A1566)";
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPad Air2 (A1567)";
    
    if ([platform isEqualToString:@"iPad6,3"])   return @"iPad Pro (9.7-inch) (A1673)";
    if ([platform isEqualToString:@"iPad6,4"])   return @"iPad Pro (9.7-inch) (A1674/A1675)";
    if ([platform isEqualToString:@"iPad6,7"])   return @"iPad Pro (12.9-inch) (A1584)";
    if ([platform isEqualToString:@"iPad6,8"])   return @"iPad Pro (12.9-inch) (A1652)";
    if ([platform isEqualToString:@"iPad6,11"])   return @"iPad (5th generation) (A1822)";
    if ([platform isEqualToString:@"iPad6,12"])   return @"iPad (5th generation) (A1823)";
    
    if ([platform isEqualToString:@"i386"])     return [NSString stringWithFormat:@"%@ Simulator", [UIDevice currentDevice].model];
    if ([platform isEqualToString:@"x86_64"])   return [NSString stringWithFormat:@"%@ Simulator", [UIDevice currentDevice].model];
    
    return platform;
}

@end


@implementation NSString (JsonClass)

- (id)jsonData {
    
    if (self == nil) {
        return nil;
    }
    
    NSData *jsonMetadata = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id jsData = [NSJSONSerialization JSONObjectWithData:jsonMetadata
                                                options:NSJSONReadingMutableContainers
                                                  error:&err];
    
    if(err)
    {
        NSLog(@"json解析失败：%@", err);
        return self;
    }
    
    return jsData;
}

@end


@implementation NSString (Encryption)
- (NSString*)zz_SHA1 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString *)zz_MD5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}
@end

@implementation NSString (DecimalNumber)
- (NSDecimalNumber *)zz_decimalNumber {
    return [NSDecimalNumber decimalNumberWithString:ZZ_DEFUSE_EMPTY_STRING(self)];
}

- (NSString *)zz_removeInvalidSuffix {
    if ((self.length > 0) && [self hasSuffix:@"0"]) {
        NSString *str = [self substringToIndex:self.length - 1];
        return [str zz_removeInvalidSuffix];
    } else if ((self.length > 0) && [self hasSuffix:@"."]) {
        return [self substringToIndex:self.length - 1];
    } else {
        return self;
    }
}

- (NSString *)zz_amountWithScale:(NSUInteger)scale {
    
    return [[self zz_decimalNumber] zz_displayAmountWithScale:8 effectiveScale:2];
}

- (NSString *)zz_amountString {
    return [self zz_amountWithScale:8];
}

@end

@implementation NSString (CheckFormat)

- (BOOL)zz_validateStringWithFormat:(NSString *)format {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:format];
    int i = 0;
    while (i < self.length) {
        NSString * string = [self substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

/**
 * 是否是纯数字（包含小数）
 */
- (BOOL)zz_isNumber {
    BOOL isNumber = [self zz_validateStringWithFormat:@"0123456789."];
    BOOL partCount = [self componentsSeparatedByString:@"."].count <= 2;
    return (isNumber && partCount);
}

/**
 * 是否是整数（不包含该小数点）
 */
- (BOOL)zz_isInteger {
    return [self zz_validateStringWithFormat:@"0123456789"];
}

/**
 * 是否是小数（包含该小数点）
 */
- (BOOL)zz_isDecimal {
    return ([self zz_isNumber] && ([self componentsSeparatedByString:@"."].count == 2));
}

/**
 * 检查出入的字符串
 *
 * 首位输入小数点，补全小数点前的0
 * 去除字符串前无效的0
 */
- (NSString *)zz_checkInput {
    //首位输入小数点，补全小数点前的0
    if ([self isEqualToString:@"."]) {
        return @"0.";
    }
    
    //保留小数点后8位有效数字
    if (![[self zz_decimalStringMaxLength:8] isEqualToString:self]) {
        return [self zz_decimalStringMaxLength:8];
    }
    
    //删除无效前缀0
    return [self zz_removeInvalidPrefix];
    
    
}

/**
 * 去除字符串前无效的0
 */
- (NSString *)zz_removeInvalidPrefix {
    NSString *str = [self componentsSeparatedByString:@"."].firstObject;
    if ((self.length > 1) && ![self hasPrefix:@"0."] && [str hasPrefix:@"0"]) {
        return [[self substringFromIndex:1] zz_removeInvalidPrefix];
    } else {
        return self;
    }
}

/**
 * 截取到小数点后n位
 */
- (NSString *)zz_decimalStringMaxLength:(NSUInteger)length {
    if (![self zz_decimalMaxLength:length]) {
        NSArray *arr = [self componentsSeparatedByString:@"."];
        NSString *suffix = [((NSString *)arr.lastObject) substringToIndex:length];
        return [[((NSString *)arr.firstObject) stringByAppendingString:@"."] stringByAppendingString:suffix];
    } else {
        return self;
    }
}

/**
 * 小数点后最多n位
 */
- (BOOL)zz_decimalMaxLength:(NSUInteger)length {
    NSString *str = [self componentsSeparatedByString:@"."].lastObject;
    return !([self zz_isDecimal] && (str.length > length));
}

@end


/**
 * 货币格式字符串
 */
@implementation NSString (CurrencyFormat)

/**
 * 是否货币格式 "###,##0.00"
 *
 * @return 是否符合货币格式字符串
 */
- (BOOL)zz_isCurrencyFormat {
    
    //判断是不是只包含有 "0123456789.,"
    if (![self zz_validateStringWithFormat:@"0123456789.,"]) {
        return false;
    }
    
    //根据小数点分割，判断小数部分是否为两位
    NSArray *decimalArray = [self componentsSeparatedByString:@"."];
    if (decimalArray.count != 2) {
        return false;
    }
    
    NSString *decimalString = decimalArray.lastObject;
    if (decimalString.length != 2) {
        return false;
    }
    
    //根据","判断，判断整数部分各部分是否为三位数字
    NSArray *array = [((NSString *)decimalArray.firstObject) componentsSeparatedByString:@","];
    
    //整数部分，根据","分割，数量小于需要>1,否者错误
    if (array.count >= 1) {
        for (int i = 0; i < array.count; i ++) {
            NSString *item = array[i];
            
            if (i == 0) {
                //第一部分 长度必须为 1 - 3
                if (!((item.length >= 1) && (item.length <= 3))) {
                    return false;
                }
                
            } else {
                
                if (item.length != 3) {
                    return false;
                }
                
            }
            
        }
        
    } else {
        return false;
    }
    
    return true;
}




@end


@implementation NSString (TextNumber)

+ (void)zz_setNumberFrom:(NSString *)from to:(NSString *)to change:(ChangeBlock)change {
    [NSString zz_setNumberFrom:from to:to durationTime:1.0 change:change];
}

+ (void)zz_setNumberFrom:(NSString *)from to:(NSString *)to durationTime:(float)time change:(ChangeBlock)change {
    
    if (!to && from) {
        !change ? : change(from);
        return;
    }
    
    if (!from && !to) {
        !change ? : change(@"0.00");
        return;
    }
    
//    if (!DEFUSE_EMPTY_STRING(from) || !DEFUSE_EMPTY_STRING(to) || !from || !to) {
//        !change ? : change(@"0.00");
//        return;
//    }
    
    if ([from isEqualToString:to]) {
        !change ? : change(to);
        return;
    }
    
    //动画持续时间
    float durationTime = time;
    
    //旧值
    CGFloat old = [ZZ_DEFUSE_EMPTY_STRING(from) doubleValue];
    
    //新值
    CGFloat new = [ZZ_DEFUSE_EMPTY_STRING(to) doubleValue];
    
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
    if (to.zz_isDecimal) {
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

@end


@implementation NSString (EquInfo)

+ (NSString *)zz_macString {
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *macString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return macString;
}

+ (NSString *)zz_idfaString {
    
    NSBundle *adSupportBundle = [NSBundle bundleWithPath:@"/System/Library/Frameworks/AdSupport.framework"];
    [adSupportBundle load];
    
    if (adSupportBundle == nil) {
        return @"";
    }
    else{
        
        Class asIdentifierMClass = NSClassFromString(@"ASIdentifierManager");
        
        if(asIdentifierMClass == nil){
            return @"";
        }
        else{
            
            //for no arc
            //ASIdentifierManager *asIM = [[[asIdentifierMClass alloc] init] autorelease];
            //for arc
            ASIdentifierManager *asIM = [[asIdentifierMClass alloc] init];
            
            if (asIM == nil) {
                return @"";
            }
            else{
                
                if(asIM.advertisingTrackingEnabled){
                    return [asIM.advertisingIdentifier UUIDString];
                }
                else{
                    return [asIM.advertisingIdentifier UUIDString];
                }
            }
        }
    }
}

+ (NSString *)zz_idfvString {
    if([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        return [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    
    return @"";
}
@end


@implementation NSString (Attributes)

+(NSMutableAttributedString *)zz_amountAttributedString:(NSString *)str
                                             preSize:(CGFloat)preSize
                                             sufSize:(CGFloat)sufSize{
    if (str == nil || [str isKindOfClass:[NSString class]] == NO || str.length == 0) {return nil;}
    
    NSRange range = [str rangeOfString:@"."];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:str];
    if (range.location == NSNotFound) {
        return attString;
    }else{
        NSRange preRange = NSMakeRange(0, range.location + range.length);
        NSRange sufRange = NSMakeRange(range.location + range.length, str.length - range.location - range.length);
        [attString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:preSize]}
                           range:preRange];
        [attString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:preSize]}
                           range:sufRange];
        return attString;
    }
}

@end


