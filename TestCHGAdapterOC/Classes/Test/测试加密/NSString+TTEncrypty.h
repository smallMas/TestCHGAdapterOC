//
//  NSString+TTEncrypty.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/5/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TTEncrypty)
+ (NSString *)stringFromHexString:(NSString *)hexString;
+ (NSString *)hexStringFromString:(NSString *)string;
// 将NSData转换成十六进制的字符串
- (NSString *)convertDataToHexStr:(NSData *)data;
// 将十六进制字符串转换成NSData
- (NSData *)convertHexStrToData:(NSString *)str;
- (NSString *)toHexString;

- (NSString *)tt_AES128EncryptKey:(NSString *)key;
- (NSString *)tt_AES128DecryptKey:(NSString *)key;

- (NSString *)kl_AES128EncryptKey:(NSString *)key iv:(NSString *)iv;
- (NSString *)kl_AES128DecryptKey:(NSString *)key iv:(NSString *)iv;
@end

NS_ASSUME_NONNULL_END
