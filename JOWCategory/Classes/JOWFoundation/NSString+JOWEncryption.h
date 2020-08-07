//
//  NSString+JOWEncryption.h
//  Expecta
//
//  Created by super on 2020/8/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JOWEncryption)

- (NSString*)jowEncryption_encodeSHA1;
- (NSString *)jowEncryption_encodeMD5;

- (NSString *)jowEncryption_encodeSha256:(NSString*)imput;


- (NSString *)jowEncryption_encodeHmacSHA256WithKey:(NSString *)key;

+ (NSString *)jowEncryption_encodeHmacSHA256:(NSString *)input withKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
