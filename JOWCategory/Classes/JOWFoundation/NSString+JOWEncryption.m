//
//  NSString+JOWEncryption.m
//  Expecta
//
//  Created by super on 2020/8/7.
//

#import "NSString+JOWEncryption.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>


@implementation NSString (JOWEncryption)

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

- (NSString *)jowEncryption_encodeMD5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}



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

@end
