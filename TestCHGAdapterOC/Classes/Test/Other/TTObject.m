//
//  TTObject.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/6.
//

#import "TTObject.h"
void request_conv(NSString *name, void (^ block)(NSString *age)) {
    if (block) {
        block(kStringFormat(@"%@你好",name));
    }
}

@implementation TTObject
- (void(^)())look {
    return ^() {
        NSLog(@"看到了什么");
    };
}
- (TTObject *(^)())run {
    return ^() {
        NSLog(@"跑起来");
        return self;
    };
}
- (TTObject *(^)(NSString *str))listen {
    return ^(NSString *str){
        NSLog(@"听见了%@",str);
        return self;
    };
}
- (TTObject *(^)(NSString *str, NSString *str2))work:(NSString *)w {
    return ^(NSString *str, NSString *str2) {
        NSLog(@"本职工作%@和%@ 做了%@",str,str2,w);
        return self;
    };
}
@end
