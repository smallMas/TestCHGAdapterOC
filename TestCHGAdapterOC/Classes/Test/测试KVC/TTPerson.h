//
//  TTPerson.h
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTPerson : NSObject {
    
    @public
    NSString *__name;
    NSString *_name;
    NSString *_isName;
    NSString *name;
    NSString *isName;
}

@property (nonatomic, strong) NSString *name;

@property (nonatomic, copy) void (^ block)(void);

- (void)test;
@end

NS_ASSUME_NONNULL_END
