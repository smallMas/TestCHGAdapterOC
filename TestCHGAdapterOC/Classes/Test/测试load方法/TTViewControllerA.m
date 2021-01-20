//
//  TTViewControllerA.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/20.
//

#import "TTViewControllerA.h"

// load 优先级：父类 > 子类 > 分类
// initialize 优先级：分类 > 子类 > 父类
// 在initialize中不能用方法交换的原因是因为 如果分类中在initialize使用方法交换，并且本身类中也在initialize方法中做了处理，那么本身类中的initialize方法是不会起作用的，就是被覆盖了
@interface TTViewControllerA ()

@end

@implementation TTViewControllerA

+ (void)load {
    [self m1];
}

//+ (void)initialize
//{
//    if (self == [TTViewControllerA class]) {
//        [self m1];
//    }
//}

+ (void)m1 {
//    Method fromeInitModelMethod = class_getInstanceMethod([self class], @selector(viewWillAppear:));
//    Method toInitModelMethod = class_getInstanceMethod([self class], @selector(swizzlingViewWillAppear:));
//    if (!class_addMethod([self class],
//                         @selector(swizzlingViewWillAppear:),
//                         method_getImplementation(toInitModelMethod),
//                         method_getTypeEncoding(toInitModelMethod))) {
//        method_exchangeImplementations(fromeInitModelMethod, toInitModelMethod);
//    }else {
////        class_replaceMethod([self class],
////                            @selector(swizzlingViewWillAppear:),
////                            method_getImplementation(fromeInitModelMethod),
////                            method_getTypeEncoding(fromeInitModelMethod));
//    }
    
    Method fromeInitModelMethod = class_getInstanceMethod([self class], @selector(viewWillAppear:));
    Method toInitModelMethod = class_getInstanceMethod([self class], @selector(swizzlingViewWillAppear:));
    if (!class_addMethod([self class], @selector(swizzlingViewWillAppear:), method_getImplementation(toInitModelMethod), method_getTypeEncoding(toInitModelMethod))) {
        method_exchangeImplementations(fromeInitModelMethod, toInitModelMethod);
    }
}

- (void)swizzlingViewWillAppear:(BOOL)animation {
    NSLog(@"Log A");
    [self swizzlingViewWillAppear:animation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"======1");
}

@end
