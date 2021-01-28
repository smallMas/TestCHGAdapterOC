//
//  NSString+TT.h
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TT)

// 判断是否全是字母
- (BOOL)isLetter;
// 判断是否全是整数
- (BOOL)isNumber;

@end

NS_ASSUME_NONNULL_END
