//
//  NSObject+FSJExtention.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/31.
//

#import "NSObject+FSJExtention.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (FSJExtention)

- (NSString *)fsj_identify {
    return objc_getAssociatedObject(self, @selector(setFsj_identify:));
}

- (void)setFsj_identify:(NSString *)fsj_identify {
    objc_setAssociatedObject(self, _cmd, fsj_identify, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
