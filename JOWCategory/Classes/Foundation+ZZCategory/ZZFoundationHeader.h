//
//  ZZFoundationHeader.h
//  Pods
//
//  Created by Joke Wang on 2018/12/18.
//

#ifndef ZZFoundationHeader_h
#define ZZFoundationHeader_h

static inline BOOL IS_NULL(NSString *string) {
    return (!string || [string isKindOfClass:[NSNull class]]);
}

static inline BOOL IS_EMPTY_STRING(NSString *string) {
    return (IS_NULL(string) || [string isEqual:@""] || [string isEqual:@"(null)"]);
}

static inline NSString * DISPLAY_STRING(NSString *string, NSString *defaultStr) {
    return (IS_EMPTY_STRING(string) ? defaultStr : string);
}

static inline NSString * DEFUSE_EMPTY_STRING(NSString *string) {
    return DISPLAY_STRING(string, @"");
}

#endif /* ZZFoundationHeader_h */
