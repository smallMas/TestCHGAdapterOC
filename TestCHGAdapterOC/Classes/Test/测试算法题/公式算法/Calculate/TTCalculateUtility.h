//
//  TTCalculateUtility.h
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTCalculateUtility : NSObject
/*!
 根据字母计算出列
 题目 : 用A表示1第一列，B表示2第二列，。。。，Z表示26，AA表示27，AB表示28。。。以此类推。请写出一个函数，输入用字母表示的列号编码，输出它是第几列。
 提示 : 26进制转10进制。
*/
+ (NSString *)calculateColumnWithLetter:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
