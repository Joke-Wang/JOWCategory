//
//  NSArray+ZZ.m
//  test
//
//  Created by Joke Wang on 16/10/25.
//  Copyright © 2016年 joke. All rights reserved.
//

#import "NSArray+ZZ.h"

@implementation NSObject (ZZArray)
/** 是否是数组对象 */
- (BOOL)isArrayClass {
    return [self isKindOfClass:[NSArray class]];
}

@end


@implementation NSArray (ZZ)
/** 数组 元素个数，非数组返回 0 */
- (NSUInteger)itemCount {
    return [self isArrayClass] ? self.count : 0;
}

/** 数组 转换 jsonString */
- (NSString *)jsonString {
    NSString *str = nil;
    
    @try {
        str = [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:self options:0 error:NULL] encoding:NSUTF8StringEncoding];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    return str;
}

/** 合并成用，逗号隔开的字符串 */
- (NSString *)convertString {
    return [self componentsJoinedByString:@","];
}

/**
 获取数组的元素（检查是否越界和NSNull如果是返回nil）
 */
- (id)zz_objectAtIndexCheck:(NSUInteger)index {
    if (index < self.count) {
        return self[index];
    } else {
        //数组越界
        return nil;
    }
}

/**
 排序（按照给定字段）
 
 @param key    <#key description#>
 @param ascend true/YES，升序；false/NO, 降序
 
 @return 排序后数组
 */
- (NSArray *)zz_sortByKey:(NSString *)key ascend:(BOOL)ascend {
   return [self sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:key ascending:ascend]]];
}


/** 数组比较 */
- (BOOL)zz_compareIgnoreObjectOrderWithArray:(NSArray *)array {
    NSSet *setOne = [NSSet setWithArray:self];
    NSSet *setTwo = [NSSet setWithArray:array];
    return [setOne isEqualToSet:setTwo];
}

/** 数组计算交集 */
- (NSArray *)zz_arrayForIntersectionWithOtherArray:(NSArray *)otherArray {
    NSMutableArray *intersectionArray = [NSMutableArray array];
    if (self.count == 0) { return nil; }
    if (otherArray == nil) { return nil; }
    
    for (id obj in self) {
        if (![otherArray containsObject:obj]) { continue; }
        [intersectionArray addObject:obj];
        
//        if ([otherArray containsObject:obj]) {
//            [intersectionArray addObject:obj];
//        }
    }
    return intersectionArray;
}

/** 数据计算差集 */
- (NSArray *)zz_arrayForMinusWithOtherArray:(NSArray *)otherArray {
    NSMutableArray *minusArray = [NSMutableArray arrayWithArray:self];
    if (self.count == 0) { return nil; }
    if (otherArray == nil) { return nil; }
    
    for (id obj in otherArray) {
        if (![self containsObject:obj]) { continue; }
        [minusArray removeObject:obj];
        
//        if ([self containsObject:obj]) {
//            [minusArray removeObject:obj];
//        }
    }
    return minusArray;
}


@end

