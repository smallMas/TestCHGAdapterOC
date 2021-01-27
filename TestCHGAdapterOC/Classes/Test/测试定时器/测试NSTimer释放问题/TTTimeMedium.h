//
//  TTTimeMedium.h
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/25.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface TTTimeMedium : NSObject

- (void)startTimeInterval:(NSTimeInterval)ti block:(FSJVoidBlock)block;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
