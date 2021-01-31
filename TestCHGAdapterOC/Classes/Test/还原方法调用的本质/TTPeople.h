//
//  TTPeople.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/1/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTPeople : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;

- (void)saySomething;

- (void)sayHello:(NSString *)ame;

@end

NS_ASSUME_NONNULL_END
