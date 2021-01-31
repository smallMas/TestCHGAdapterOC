//
//  TTCallFunViewController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/1/31.
//

#import "TTCallFunViewController.h"
#import "TTPeople.h"

@interface TTCallFunViewController ()

@end

@implementation TTCallFunViewController

/*
  类结构体
  objc_class:
            Class superclass;
            cache_t cache; // bucket
            class_data_bits_t bits; // rw(读写缓存) -> methodList
 
  bucket_t:
            _imp;
            _sel;
 
 */

/*
 https://www.jianshu.com/p/86e4bba8690a
 
 动态方法决议调用（类方法 对象方法）
 static NEVER_INLINE IMP
 resolveMethod_locked(id inst, SEL sel, Class cls, int behavior)
 {
     runtimeLock.assertLocked();
     ASSERT(cls->isRealized());

     runtimeLock.unlock();
     //对象 -- 类
     if (! cls->isMetaClass()) { //类不是元类，调用对象的解析方法
         // try [cls resolveInstanceMethod:sel]
         resolveInstanceMethod(inst, sel, cls);
     }
     else {//如果是元类，调用类的解析方法， 类 -- 元类
         // try [nonMetaClass resolveClassMethod:sel]
         // and [cls resolveInstanceMethod:sel]
         resolveClassMethod(inst, sel, cls);
         //为什么要有这行代码？ -- 类方法在元类中是对象方法，所以还是需要查询元类中对象方法的动态方法决议
         if (!lookUpImpOrNil(inst, sel, cls)) { //如果没有找到或者为空，在元类的对象方法解析方法中查找
             resolveInstanceMethod(inst, sel, cls);
         }
     }

     // chances are that calling the resolver have populated the cache
     // so attempt using it
     //如果方法解析中将其实现指向其他方法，则继续走方法查找流程
     return lookUpImpOrForward(inst, sel, cls, behavior | LOOKUP_CACHE);
 }
 
 // 动态方法 对象方法
 static void resolveInstanceMethod(id inst, SEL sel, Class cls)
 {
     runtimeLock.assertUnlocked();
     ASSERT(cls->isRealized());
     SEL resolve_sel = @selector(resolveInstanceMethod:);
     
     // look的是 resolveInstanceMethod --相当于是发送消息前的容错处理
     if (!lookUpImpOrNil(cls, resolve_sel, cls->ISA())) {
         // Resolver not implemented.
         return;
     }

     BOOL (*msg)(Class, SEL, SEL) = (typeof(msg))objc_msgSend;
     bool resolved = msg(cls, resolve_sel, sel); //发送resolve_sel消息

     // Cache the result (good or bad) so the resolver doesn't fire next time.
     // +resolveInstanceMethod adds to self a.k.a. cls
     IMP imp = lookUpImpOrNil(inst, sel, cls);

     if (resolved  &&  PrintResolving) {
         if (imp) {
             _objc_inform("RESOLVE: method %c[%s %s] "
                          "dynamically resolved to %p",
                          cls->isMetaClass() ? '+' : '-',
                          cls->nameForLogging(), sel_getName(sel), imp);
         }
         else {
             // Method resolver didn't add anything?
             _objc_inform("RESOLVE: +[%s resolveInstanceMethod:%s] returned YES"
                          ", but no new implementation of %c[%s %s] was found",
                          cls->nameForLogging(), sel_getName(sel),
                          cls->isMetaClass() ? '+' : '-',
                          cls->nameForLogging(), sel_getName(sel));
         }
     }
 }
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 题目1: 方法的本质，sel是什么？IMP是什么？两者是什么关系
    // clang
    // 总结：方法的本质是消息，sel是方法编号，imp是方法实现，根据sel找到imp
    // 方法查找流程： 快速查找 -> cache_t(存在类对象，bucket[sel - imp]) -> 慢速查找(methodList - 二分查找) -> 动态方法决议(对象-类 区别) ->
    
    // lookupImpOrForward
    
    [TTPeople alloc];
    
    
    // -------------------------------------------------------------
    // 崩溃方法处理
    // 动态方法决议 resolveInstanceMethod
    // 消息转发 分为快速转发和慢速转发
    // 快速转发：forwardingTargetForSelector可以修改方法的处理的target
    // 慢速转发：methodSignatureForSelector不仅可以修改方法的处理的target，可以修改selector
    /* 防止崩溃的方法
        1、在动态方法决议中，动态添加方法的实现
        2、在快速转发中，可以修改方法的处理的target
        3、在慢速转发中，可以修改target和selector
        4、在慢速转发中，返回"v@:"这个的签名
     */
    TTPeople *person = [TTPeople alloc];
    [person sayHello:@"aa"];
}


@end
