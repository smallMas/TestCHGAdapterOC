//
//  TTViewControllerB+TT2.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/21.
//

#import "TTViewControllerB+TT2.h"

@implementation TTViewControllerB (TT2)
+ (void)load {
    [self m4];
}

+ (void)m4 {
    Method fromeInitModelMethod = class_getInstanceMethod([self class], @selector(viewWillAppear:));
    Method toInitModelMethod = class_getInstanceMethod([self class], @selector(C2swizzlingViewWillAppear:));
    if (!class_addMethod([self class],
                         @selector(C2swizzlingViewWillAppear:),
                         method_getImplementation(toInitModelMethod),
                         method_getTypeEncoding(toInitModelMethod))) {
        method_exchangeImplementations(fromeInitModelMethod, toInitModelMethod);
    }else {
        class_replaceMethod([self class],
                            @selector(C2swizzlingViewWillAppear:),
                            method_getImplementation(fromeInitModelMethod),
                            method_getTypeEncoding(fromeInitModelMethod));
    }
}

- (void)C2swizzlingViewWillAppear:(BOOL)animation {
    NSLog(@"Log B + C2");
    [self C2swizzlingViewWillAppear:animation];
}
@end
