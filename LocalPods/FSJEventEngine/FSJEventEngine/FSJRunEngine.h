//
//  FSJRunEngine.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSJRunEngine : NSObject
+ (void)handleCommand:(NSDictionary *)command;
+ (void)handleCommand:(NSDictionary *)action handle:(id __nullable)handle;
@end

NS_ASSUME_NONNULL_END
