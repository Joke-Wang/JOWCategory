//
//  ZZFoundationHeader.h
//  Pods
//
//  Created by Joke Wang on 2018/12/18.
//

#ifndef ZZFoundationHeader_h
#define ZZFoundationHeader_h

static inline BOOL ZZ_IS_NULL(NSString *string) {
    return (!string || [string isKindOfClass:[NSNull class]]);
}

static inline BOOL ZZ_IS_EMPTY_STRING(NSString *string) {
    return (ZZ_IS_NULL(string) || [string isEqual:@""] || [string isEqual:@"(null)"]);
}

static inline NSString * ZZ_DISPLAY_STRING(NSString *string, NSString *defaultStr) {
    return (ZZ_IS_EMPTY_STRING(string) ? defaultStr : string);
}

static inline NSString * ZZ_DEFUSE_EMPTY_STRING(NSString *string) {
    return ZZ_DISPLAY_STRING(string, @"");
}

#endif /* ZZFoundationHeader_h */
