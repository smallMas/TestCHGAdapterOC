//
//  TTViewControllerB.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/20.
//

#import "TTViewControllerB.h"

@interface TTViewControllerB ()

@end

@implementation TTViewControllerB

+ (void)load {
    [self m2];
}

//+ (void)initialize
//{
//    if (self == [TTViewControllerB class]) {
//        [self m2];
//    }
//}

+ (void)m2 {
    Method fromeInitModelMethod = class_getInstanceMethod([self class], @selector(viewWillAppear:));
    Method toInitModelMethod = class_getInstanceMethod([self class], @selector(aswizzlingViewWillAppear:));
    if (!class_addMethod([self class], @selector(aswizzlingViewWillAppear:), method_getImplementation(toInitModelMethod), method_getTypeEncoding(toInitModelMethod))) {
        method_exchangeImplementations(fromeInitModelMethod, toInitModelMethod);
    }else {
        class_replaceMethod([self class], @selector(aswizzlingViewWillAppear:), method_getImplementation(fromeInitModelMethod), method_getTypeEncoding(fromeInitModelMethod));
    }
}

- (void)aswizzlingViewWillAppear:(BOOL)animation {
    NSLog(@"Log B");
    [self aswizzlingViewWillAppear:animation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"======2");
}

@end
