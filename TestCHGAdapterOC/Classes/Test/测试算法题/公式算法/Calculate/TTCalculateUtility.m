//
//  TTCalculateUtility.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/27.
//

#import "TTCalculateUtility.h"

@implementation TTCalculateUtility

+ (NSString *)calculateColumnWithLetter:(NSString *)string {
    if ([string isLetter]) {
        NSInteger value = 0;
        // 先转化成大写
        NSString *upper = [string uppercaseString];
        for (NSInteger i = 0; i < upper.length; i++) {
            NSString *str = [upper substringWithRange:NSMakeRange(i, 1)];
            NSInteger n = upper.length-i;
            int asciiCode = [str characterAtIndex:0];
            int x = asciiCode-65+1;
            value += pow(26, n-1)*x;
        }
        return [NSString stringWithFormat:@"在%ld行",value];
    }
    return @"格式错误";
}

@end
