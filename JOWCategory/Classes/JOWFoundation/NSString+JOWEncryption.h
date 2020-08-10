//
//  NSString+JOWEncryption.h
//  Expecta
//
//  Created by super on 2020/8/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JOWEncryption)
/// MD5
- (NSString *)jowEncryption_encodeMD5;

/// SHA1
- (NSString *)jowEncryption_encodeSHA1;

/// SHA256
- (NSString *)jowEncryption_encodeSha256;


/// Hmac-SHA256
/// @param key  encrypt key
- (NSString *)jowEncryption_encodeHmacSHA256WithKey:(NSString *)key;

/// Hmac-SHA256
/// @param input encrypt message
/// @param key encrypt key
+ (NSString *)jowEncryption_encodeHmacSHA256:(NSString *)input withKey:(NSString *)key;


/// AES ECB
/// @param aesKey AES key
- (NSString *)jowEncryption_encodeAESECBWithKey:(NSString *)aesKey;
- (NSString *)jowEncryption_decodeAESECBWithKey:(NSString *)aesKey;


/// AES CBC
/// @param aesKey AES key
/// @param ivKey aes initialization vector
- (NSString *)jowEncryption_encodeAESCBCWithKey:(NSString *)aesKey ivKey:(NSString *)ivKey;
- (NSString *)jowEncryption_decodeAESCBCWithKey:(NSString *)aesKey ivKey:(NSString *)ivKey;


@end

NS_ASSUME_NONNULL_END
