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
- (BOOL)isDictionaryClass {
    return [self isKindOfClass:[NSDictionary class]];
}

@end

@implementation NSDictionary (ZZ)
/**
 * 字典 转换 jsonString
 */
- (NSString *)jsonString {
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
    return jsonString;
}


@end
