//
//  NSDecimalNumber+ZZ.h
//  HeroCoinSDK
//
//  Created by Joke Wang on 2018/5/23.
//  Copyright © 2018年 zhutaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (ZZ)

@end

@interface NSDecimalNumber (Calculate)

- (NSDecimalNumber *)zz_formatWithScale:(NSUInteger)scale;
- (NSString *)zz_displayAmountWithScale:(NSUInteger)scale;

@end



