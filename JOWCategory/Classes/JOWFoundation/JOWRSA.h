//
//  JOWRSA.h
//  JOWCategory
//
//  Created by super on 2020/8/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JOWRSA : NSObject
// return base64 encoded string
+ (NSString *)jowrea_encryptString:(NSString *)str publicKey:(NSString *)pubKey;
// return raw data
+ (NSData *)jowrea_encryptData:(NSData *)data publicKey:(NSString *)pubKey;
// return base64 encoded string
+ (NSString *)jowrea_encryptString:(NSString *)str privateKey:(NSString *)privKey;
// return raw data
+ (NSData *)jowrea_encryptData:(NSData *)data privateKey:(NSString *)privKey;

// decrypt base64 encoded string, convert result to string(not base64 encoded)
+ (NSString *)jowrea_decryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSData *)jowrea_decryptData:(NSData *)data publicKey:(NSString *)pubKey;
+ (NSString *)jowrea_decryptString:(NSString *)str privateKey:(NSString *)privKey;
+ (NSData *)jowrea_decryptData:(NSData *)data privateKey:(NSString *)privKey;

@end

NS_ASSUME_NONNULL_END
