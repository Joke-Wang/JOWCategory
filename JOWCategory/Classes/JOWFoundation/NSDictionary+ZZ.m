//
//  NSDictionary+ZZ.m
//  bimeiti
//
//  Created by Joke Wang on 2018/4/15.
//  Copyright © 2018年 com.bi.meiti. All rights reserved.
//

#import "NSDictionary+ZZ.h"

@implementation NSObject (ZZDictionary)
/** 是否是字典对象 */
- (BOOL)zz_isDictionaryClass {
    return [self isKindOfClass:[NSDictionary class]];
}

@end

@implementation NSDictionary (ZZ)
/**
 * 字典 转换 jsonString
 */
- (NSString *)zz_jsonString {
    NSError *error = nil;
    NSData *jsonData = nil;
    
    @try {
        jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    if (jsonData == nil) {
#ifdef DEBUG
        NSLog(@"fail to get JSON from dictionary: %@, error: %@", self, error);
#endif
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    //去掉字符串中的空格
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    //去掉字符串中的换行符
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return [NSString stringWithString:mutStr];
}

- (id)zz_objectForKey:(id)key {
    if (key != nil) {
        id value = [self objectForKey:key];
        return value;
    }
    return nil;
}

@end


@implementation NSMutableDictionary (Safe)

- (void)zz_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (anObject != nil && aKey != nil) {
        [self setObject:anObject forKey:aKey];
    }
}

- (void)zz_removeObjectForKey:(id)aKey {
    if (aKey != nil) {
        [self removeObjectForKey:aKey];
    }
}

- (void)zz_addEntriesFromDictionary:(NSDictionary *)otherDictionary {
    if (otherDictionary != nil && [otherDictionary isKindOfClass:[NSDictionary class]]) {
        [self addEntriesFromDictionary:otherDictionary];
    }
}

@end
