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
            NSLog(@"fail to get JSON from array: %@, error: %@", self, error);
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

/**
 生成无需数组
 
 @return 排序后数组
 */
- (NSArray *)zz_sortWithUnordered {
    NSArray *result = [self sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str1];
        }
    }];
    return result;
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

/** 是否包含某元素 */
- (BOOL)zz_arrayContainsItem:(NSObject *)item {
    if (self.count == 0 || item == nil) {
        return false;
    }
    
    NSArray *arr = [self zz_arrayForIntersectionWithOtherArray:@[item]];
    return arr.count != 0;
}


@end

@implementation NSArray (JsonData)
/**
 * json 转换数组
 */
+ (NSArray *)zz_arrayWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                                                     options:NSJSONReadingMutableContainers
                                                       error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@", err);
        return nil;
    }
    return array;
}

@end


@implementation NSMutableArray (Safe)

- (void)zz_addObject:(id)anObject {
    if (anObject != nil) {
        [self addObject:anObject];
    }
}

- (void)zz_addObjectsFromArray:(NSArray *)otherArray {
    if (otherArray != nil && [otherArray isKindOfClass:[NSArray class]]) {
        [self addObjectsFromArray:otherArray];
    }
}

- (void)zz_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject != nil) {
        if (index < self.count) {
            [self insertObject:anObject atIndex:index];
        }else{
            [self addObject:anObject];
        }
    }
}



@end




