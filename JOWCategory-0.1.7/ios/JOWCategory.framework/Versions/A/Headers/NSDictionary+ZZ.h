//
//  NSDictionary+ZZ.h
//  bimeiti
//
//  Created by Joke Wang on 2018/4/15.
//  Copyright © 2018年 com.bi.meiti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(ZZDictionary)
/** 是否是字典对象 */
@property (nonatomic, assign, readonly) BOOL zz_isDictionaryClass;

@end

@interface NSDictionary (ZZ)

/**
 * 字典 转换 jsonString
 */
@property (nonatomic, copy, readonly) NSString *zz_jsonString;

- (id)zz_objectForKey:(id)key;

@end

@interface NSMutableDictionary (Safe)

- (void)zz_setObject:(id)anObject forKey:(id<NSCopying>)aKey;

- (void)zz_removeObjectForKey:(id)aKey;

- (void)zz_addEntriesFromDictionary:(NSDictionary *)otherDictionary;

@end
