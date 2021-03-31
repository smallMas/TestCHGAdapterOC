//
//  TTRunEngine.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/31.
//

#import "TTRunEngine.h"
#import <objc/message.h>
#import "FSJControlUtil.h"

@implementation TTRunEngine

static inline NSDictionary *tt_methods(){
    static NSDictionary *methods = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        methods = @{@"tt_basedata":@"_tt_basedata:handle:",
                    @"tto_controller":@"_tto_controller:handle:"
        };
    });
    return methods;
}

+ (void)handleCommand:(NSDictionary *)command handle:(id)handle{
    SEL sel = NSSelectorFromString(tt_methods()[command[@"app_action"]]);
    if ([self respondsToSelector:sel]) {
        ((void(*)(id,SEL,id,id))objc_msgSend)(self,sel,command[@"info"],handle);
    }
#if DEBUG
    else{
        NSLog(@"⚠️⚠️⚠️⚠️未找到方法%@ in %@⚠️⚠️⚠️⚠️",tt_methods()[command[@"app_action"]],command);
    }
#endif
}

static inline void _showBaseKindController(char *clsName, NSDictionary *info, void(^handle)(UIViewController *obj)){
    Class cls = (id)objc_getClass(clsName);
#if DEBUG
    if (__builtin_expect(!(cls), 0)) {
        [[NSAssertionHandler currentHandler] handleFailureInFunction:[NSThread.callStackSymbols componentsJoinedByString:@"\n"] file:@(__FILE_NAME__) lineNumber:__LINE__ description:@"无法找到类%s",clsName];
    }
#endif
    UIViewController *obj = ((UIViewController *(*)(id,SEL,id))objc_msgSend)(cls,NSSelectorFromString(@"newCtl:"),info);
    BOOL animate          = YES;
    if ([info isKindOfClass:NSDictionary.class]) {
        if (info[@"hideBarOnPush"]) {obj.hidesBottomBarWhenPushed = [info[@"hideBarOnPush"] boolValue];}
        if (info[@"animate"]) {animate = [info[@"animate"] boolValue];}
    }
    SEL set = NSSelectorFromString(@"setHandle:");
    if (handle && [obj respondsToSelector:set]) {((void(*)(id,SEL,id))objc_msgSend)(obj,set, handle);}
    showController(obj, animate, nil);
    ((void(*)(id,SEL))objc_msgSend)(obj,sel_registerName("release"));
}
static inline void _presentBaseKindController(char *clsName, NSDictionary *info, BOOL navid, void(^handle)(UIViewController *obj)){
    Class cls = (id)objc_getClass(clsName);
#if DEBUG
    if (__builtin_expect(!(cls), 0)) {
        [[NSAssertionHandler currentHandler] handleFailureInFunction:[NSThread.callStackSymbols componentsJoinedByString:@"\n"] file:@(__FILE_NAME__) lineNumber:__LINE__ description:@"无法找到类%s",clsName];
    }
#endif
    UIViewController *obj = ((UIViewController *(*)(id,SEL,id))objc_msgSend)(cls,NSSelectorFromString(@"newCtl:"),info);
    BOOL animate          = YES;
    if ([info isKindOfClass:NSDictionary.class]) {
        if (info[@"hideBarOnPush"]) {obj.hidesBottomBarWhenPushed = [info[@"hideBarOnPush"] boolValue];}
        if (info[@"animate"]) {animate = [info[@"animate"] boolValue];}
    }
    SEL set = NSSelectorFromString(@"setHandle:");
    if (handle && [obj respondsToSelector:set]) {((void(*)(id,SEL,id))objc_msgSend)(obj,set, handle);}
    if (handle)handle(obj);
    UIViewController *top = currentTopViewController();
    if ([top isKindOfClass:UINavigationController.class]) {
        showController(obj, animate, nil);
    }else{
        if (navid) {
            UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:obj];
            navc.modalPresentationStyle  = obj.modalPresentationStyle;
            if (obj.transitioningDelegate) navc.transitioningDelegate = obj.transitioningDelegate;
            [top presentViewController:navc animated:animate completion:nil];
        }else{
            [top presentViewController:obj animated:animate completion:nil];
        }
    }
    ((void(*)(id,SEL))objc_msgSend)(obj,sel_registerName("release"));
}

#pragma --mark 打开测试数据库 ----
+ (void)_tt_basedata:(NSDictionary *)info handle:(id)handle{
    _showBaseKindController("TTTestWCDBDataController", info, handle);
}

+ (void)_tto_controller:(NSDictionary *)info handle:(id)handle{
    _showBaseKindController("TTTestToController", info, handle);
}

@end
