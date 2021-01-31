//
//  TTPeople.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/1/31.
//

#import "TTPeople.h"
#import "TTNewReceiver.h"

@implementation TTPeople

//+ (void)load {
//    // 添加方法实现
//    IMP imp = class_getMethodImplementation(self, @selector(replaceInstance));
//    Method sayMethod = class_getInstanceMethod(self, @selector(replaceInstance));
//    const char *type  = method_getTypeEncoding(sayMethod);
//    class_addMethod(self, @selector(sayHello), imp, type);
//}

- (void)saySomething {
    NSLog(@"%s - %@",__FUNCTION__,self.name);
}

#pragma mark - 崩溃流程

+ (void)replaceInstance {
    NSLog(@"%s",__FUNCTION__);
}

- (void)replaceInstance {
    NSLog(@"%s",__FUNCTION__);
}

// 动态方法决议(实例方法)
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"%s - %@",__func__,NSStringFromSelector(sel));
    if (sel == @selector(sayHello)) {
        NSLog(@"来了 : %@",NSStringFromSelector(sel));
        
//        // 添加方法实现
//        IMP imp = class_getMethodImplementation(self, @selector(replaceInstance));
//        Method sayMethod = class_getInstanceMethod(self, @selector(replaceInstance));
//        const char *type  = method_getTypeEncoding(sayMethod);
//        return class_addMethod(self, sel, imp, type);
    }
    return [super resolveInstanceMethod:sel];
}

// 快速转发
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"%s - %@",__func__,NSStringFromSelector(aSelector));
    // 更换接收者
    // 方法一：直接返回另一个对象，但是这个对象必须有aSelector的实现
//    return [TTNewReceiver alloc];
    
    // 方法二：返回自己的对象的方法，但是这个对象没有aSelector的实现，需要动态添加方法
//    IMP imp = class_getMethodImplementation([self class], @selector(replaceInstance));
//    Method sayMethod = class_getInstanceMethod([self class], @selector(replaceInstance));
//    const char *type  = method_getTypeEncoding(sayMethod);
//    class_addMethod([self class], aSelector, imp, type);
//    return [[self class] alloc];
    
    return [super forwardingTargetForSelector:aSelector];
}

// 慢速转发 - 方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"%s - %@",__func__,NSStringFromSelector(aSelector));
    // 第一种方法不处理方法的实现
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//    return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    
    // 第二种方法 将返回另一个类的方法实现
//    NSMethodSignature *signature = [TTNewReceiver instanceMethodSignatureForSelector:@selector(sayMethod)];
//    return signature;
    
//    return [super methodSignatureForSelector:aSelector];
}

// 不处理方法的实现
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"%s - %@",__func__,NSStringFromSelector(anInvocation.selector));

}
//
//// 默认的实现抛出异常
//- (void)doesNotRecognizeSelector:(SEL)aSelector {
//    NSLog(@"%s",__FUNCTION__);
//}

@end
