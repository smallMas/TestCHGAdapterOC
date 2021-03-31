//
//  TTRunEngine.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTRunEngine : NSObject

+ (void)handleCommand:(NSDictionary *)command handle:(id)handle;

@end

NS_ASSUME_NONNULL_END
