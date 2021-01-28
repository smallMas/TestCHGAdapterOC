//
//  NSString+TT.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/27.
//

#import "NSString+TT.h"

@implementation NSString (TT)

// 判断是否全是字母
- (BOOL)isLetter {
    NSString *regex = @"[a-zA-Z]*";
    return [self fsj_checkWithPredicate:regex];
}

// 判断是否全是整数
- (BOOL)isNumber {
    NSString *regex = @"[0-9]*";
    return [self fsj_checkWithPredicate:regex];
}

@end
