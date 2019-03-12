//
//  NSArray+ZZ.h
//  test
//
//  Created by Joke Wang on 16/10/25.
//  Copyright © 2016年 joke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(ZZArray)
/** 是否是数组对象 */
@property (nonatomic, assign, readonly) BOOL isArrayClass;

@end


@interface NSArray (ZZ)
/** 数组 元素个数，非数组返回 0 */
@property (nonatomic, assign, readonly) NSUInteger itemCount;

/** 数组 转换 jsonString */
@property (nonatomic,   copy, readonly) NSString *zz_jsonString;

/** 合并成用，逗号隔开的字符串 */
@property (nonatomic,   copy, readonly) NSString *convertString;

/**
 获取数组的元素（检查是否越界和NSNull如果是返回nil）
 */
- (id)zz_objectAtIndexCheck:(NSUInteger)index;

/**
 排序（按照给定字段）

 @param key    <#key description#>
 @param ascend true/YES，升序；false/NO, 降序

 @return 排序后数组
 */
- (NSArray *)zz_sortByKey:(NSString *)key ascend:(BOOL)ascend;

/**
 生成无需数组
 
 @return 排序后数组
 */
- (NSArray *)zz_sortWithUnordered;

/** 数组比较 */
- (BOOL)zz_compareIgnoreObjectOrderWithArray:(NSArray *)array;

/** 数组计算交集 */
- (NSArray *)zz_arrayForIntersectionWithOtherArray:(NSArray *)otherArray;

/** 数据计算差集 */
- (NSArray *)zz_arrayForMinusWithOtherArray:(NSArray *)otherArray;

/** 是否包含某元素 */
- (BOOL)zz_arrayContainsItem:(NSObject *)item;


@end


@interface NSArray (JsonData)

/**
 * json 转换数组
 */
+ (NSArray *)zz_arrayWithJsonString:(NSString *)jsonString;

@end

