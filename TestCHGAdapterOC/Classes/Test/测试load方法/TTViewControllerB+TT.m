//
//  TTViewControllerB+TT.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/20.
//

#import "TTViewControllerB+TT.h"

@implementation TTViewControllerB (TT)

+ (void)load {
    [self m3];
}

//+ (void)initialize
//{
//    if (self == [TTViewControllerB class]) {
//        [self m3];
//    }
//}

+ (void)m3 {
    Method fromeInitModelMethod = class_getInstanceMethod([self class], @selector(viewWillAppear:));
    Method toInitModelMethod = class_getInstanceMethod([self class], @selector(C1swizzlingViewWillAppear:));
    if (!class_addMethod([self class],
                         @selector(C1swizzlingViewWillAppear:),
                         method_getImplementation(toInitModelMethod),
                         method_getTypeEncoding(toInitModelMethod))) {
        method_exchangeImplementations(fromeInitModelMethod, toInitModelMethod);
    }else {
        class_replaceMethod([self class],
                            @selector(C1swizzlingViewWillAppear:),
                            method_getImplementation(fromeInitModelMethod),
                            method_getTypeEncoding(fromeInitModelMethod));
    }
}

- (void)C1swizzlingViewWillAppear:(BOOL)animation {
    NSLog(@"Log B + C1");
    [self C1swizzlingViewWillAppear:animation];
}


@end
