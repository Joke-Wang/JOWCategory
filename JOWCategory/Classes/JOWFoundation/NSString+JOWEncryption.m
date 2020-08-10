//
//  NSString+JOWEncryption.m
//  Expecta
//
//  Created by super on 2020/8/7.
//

#import "NSString+JOWEncryption.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>

#define kInitVector @"1234567812345678"

typedef NS_ENUM(NSUInteger, AESType) {
    AESTypeECB,
    AESTypeCBC,
};

@implementation NSString (JOWEncryption)
// MARK: MD5
- (NSString *)jowEncryption_encodeMD5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

// MARK: SHA1
- (NSString*)jowEncryption_encodeSHA1 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

// MARK: SHA256
- (NSString *)jowEncryption_encodeSha256 {
    const char *s = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH] = {0};
    CC_SHA256(keyData.bytes, (CC_LONG)keyData.length, digest);
    NSData*outStr = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    
    //=======xcode编译ios13之后 格式变掉=======
    // NSString *hash = [outStr description];
    // hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    // stringByReplacingOccurrencesOfString:@"\n"withString:@""];
    // hash = [hash stringByReplacingOccurrencesOfString:@"<"withString:@""];
    // hash = [hash stringByReplacingOccurrencesOfString:@">"withString:@""];
    // return hash;
    
    //=========新的方式====
    
    const unsigned *tokenBytes = (const unsigned*)[outStr bytes];
    
    NSString *hexHash = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                         ntohl(tokenBytes[0]),
                         ntohl(tokenBytes[1]),
                         ntohl(tokenBytes[2]),
                         ntohl(tokenBytes[3]),
                         ntohl(tokenBytes[4]),
                         ntohl(tokenBytes[5]),
                         ntohl(tokenBytes[6]),
                         ntohl(tokenBytes[7])];
    return hexHash;
}

// MARK: - Hmac-SHA256
- (NSString *)jowEncryption_encodeHmacSHA256WithKey:(NSString *)key {
    return [NSString jowEncryption_encodeHmacSHA256:self withKey:key];
}

+ (NSString *)jowEncryption_encodeHmacSHA256:(NSString *)input withKey:(NSString *)key {
    
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [input cStringUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMACData = [NSData dataWithBytes:cHMAC length:sizeof(cHMAC)];
    
    const unsigned char *buffer = (const unsigned char *)[HMACData bytes];
    
    NSMutableString *HMAC = [NSMutableString stringWithCapacity:HMACData.length * 2];
    
    for (int i = 0; i < HMACData.length; ++i) {
        [HMAC appendFormat:@"%02x", buffer[i]];
    }
    
    return HMAC;
}


// MARK: - AES
// MARK: AES ECB
/* AES ECB encode begain */
- (NSString *)jowEncryption_encodeAESECBWithKey:(NSString *)aesKey {
    return [self jowEncryption_encodeAESWithKey:aesKey ivKey:NULL aesType:AESTypeECB];
}
/* AES ECB encode end */

/* AES ECB decode begain */
- (NSString *)jowEncryption_decodeAESECBWithKey:(NSString *)aesKey {
    return [self jowEncryption_decodeAESWithKey:aesKey ivKey:NULL aesType:AESTypeECB];
}
/* AES ECB decode end */

// MARK: AES CBC
/* AES CBC encode begain */
- (NSString *)jowEncryption_encodeAESCBCWithKey:(NSString *)aesKey ivKey:(NSString *)ivKey {
    return [self jowEncryption_encodeAESWithKey:aesKey ivKey:ivKey aesType:AESTypeCBC];
}
/* AES CBC encode end */

/* AES CBC encode begain */
- (NSString *)jowEncryption_decodeAESCBCWithKey:(NSString *)aesKey ivKey:(NSString *)ivKey {
    return [self jowEncryption_decodeAESWithKey:aesKey ivKey:ivKey aesType:AESTypeCBC];
}
/* AES CBC decode end */

// MARK: AES ECB/CBC 内部方法
- (NSString *)jowEncryption_encodeAESWithKey:(NSString *)aesKey ivKey:(NSString * __nullable)ivKey aesType:(AESType)aesType {
    
    if (self.length < 1) {
        return @"";
    }
    
    if (AESTypeCBC == aesType) {
        NSAssert(ivKey.length > 0, @"AES CBC Mode is must be set ivKey");
    }
    
    NSData * data = [self dataUsingEncoding:NSUTF8StringEncoding];//待加密字符转为NSData型
    NSUInteger dataLength = [data length];
    
    char keyPtr[kCCKeySizeAES128 + 1];
    
    memset(keyPtr,0,sizeof(keyPtr));
    
    [aesKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void * buffer = malloc(bufferSize);
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = 0;
    // CBC模式
    if (AESTypeCBC == aesType) {
        cryptStatus = CCCrypt(kCCEncrypt,
                              kCCAlgorithmAES128,
                              kCCOptionPKCS7Padding,
                              keyPtr,
                              kCCBlockSizeAES128,
                              [ivKey UTF8String],
                              [data bytes],
                              dataLength,
                              buffer,
                              bufferSize,
                              &numBytesCrypted);
    }
    // ECB模式
    else if (AESTypeECB == aesType) {
        cryptStatus = CCCrypt(kCCEncrypt,
                              kCCAlgorithmAES,
                              kCCOptionPKCS7Padding|kCCOptionECBMode,
                              keyPtr,
                              kCCBlockSizeAES128,
                              NULL,
                              [data bytes],
                              dataLength,
                              buffer,
                              bufferSize,
                              &numBytesCrypted);
    }
    
    if(cryptStatus == kCCSuccess) {
        
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        
        NSString *result = [resultData base64EncodedStringWithOptions:0];
        
        return result;
        
    }
    
    free(buffer);
    
    return @"";
    
}

- (NSString *)jowEncryption_decodeAESWithKey:(NSString *)aesKey ivKey:(NSString * __nullable)ivKey aesType:(AESType)aesType {
    
    if(self.length < 1){
        return @"";
    }
    
    if (AESTypeCBC == aesType) {
        NSAssert(ivKey.length > 0, @"AES CBC Mode is must be set ivKey");
    }
    
    NSData *contentData = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];

    NSUInteger dataLength = contentData.length;

    char keyPtr[kCCKeySizeAES128 + 1];

    memset(keyPtr,0,sizeof(keyPtr));

    [aesKey getCString:keyPtr maxLength:sizeof(keyPtr)encoding:NSUTF8StringEncoding];

    size_t decryptSize = dataLength + kCCBlockSizeAES128;
    
    void * decryptedBytes = malloc(decryptSize);
    
    size_t actualOutSize = 0;

    CCCryptorStatus cryptStatus = 0;
    
    // CBC模式
    if (AESTypeCBC == aesType) {
        cryptStatus = CCCrypt(kCCDecrypt,
                              kCCAlgorithmAES128,
                              kCCOptionPKCS7Padding,
                              keyPtr,
                              kCCKeySizeAES128,
                              [ivKey UTF8String],
                              contentData.bytes,
                              dataLength,
                              decryptedBytes,
                              decryptSize,
                              &actualOutSize);
    }
    // ECB模式
    else if (AESTypeECB == aesType) {
        cryptStatus = CCCrypt(kCCDecrypt,
                              kCCAlgorithmAES,
                              kCCOptionPKCS7Padding|kCCOptionECBMode,
                              keyPtr,
                              kCCKeySizeAES128,
                              NULL,
                              contentData.bytes,
                              dataLength,
                              decryptedBytes,
                              decryptSize,
                              &actualOutSize);
    }
    

    if(cryptStatus == kCCSuccess) {

        NSData *dataTemp = [NSData dataWithBytesNoCopy:decryptedBytes length:actualOutSize];
        
        NSString *str = [[NSString alloc] initWithData:dataTemp encoding:NSUTF8StringEncoding];

        return str;

    }

    free(decryptedBytes);

    return @"";

}

@end
