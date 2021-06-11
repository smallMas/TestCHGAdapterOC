//
//  TTObject.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/6.
//

#import <Foundation/Foundation.h>

@class TTObject;
//typedef instancetype (^ CHStringBlock) (NSString *value);

//typedef TTObject * (^ CHStringBlock) (NSString *value);

NS_ASSUME_NONNULL_BEGIN

void request_conv(NSString *name, void (^ block)(NSString *age));

@interface TTObject : NSObject
@property (strong, nonatomic) NSString *a;

- (void(^)())look;

- (TTObject *(^)())run;

- (TTObject *(^)(NSString *str))listen;

- (TTObject *(^)(NSString *str, NSString *str2))work:(NSString *)w;

@end

NS_ASSUME_NONNULL_END
