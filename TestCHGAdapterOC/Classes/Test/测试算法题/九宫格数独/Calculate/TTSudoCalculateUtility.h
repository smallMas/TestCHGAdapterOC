//
//  TTSudoCalculateUtility.h
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/28.
//

#import <Foundation/Foundation.h>
#import "TTSudoModel.h"
#import "TTGongModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTSudoCalculateUtility : NSObject

// 随机创建
+ (NSArray <TTSudoModel *>*)randomCreate;

// 获取答案
+ (NSNumber *)valueForArray:(NSArray <TTSudoModel *>*)array;

@end

NS_ASSUME_NONNULL_END
