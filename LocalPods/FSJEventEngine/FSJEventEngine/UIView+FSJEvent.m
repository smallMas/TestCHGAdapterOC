//
//  UIView+FSJEvent.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/31.
//

#import "UIView+FSJEvent.h"
#import "NSObject+FSJExtention.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation UIView (FSJEvent)

#pragma mark - 属性
- (void)setFsj_enlarge:(UIEdgeInsets)fsj_enlarge {
    if (UIEdgeInsetsEqualToEdgeInsets(fsj_enlarge, UIEdgeInsetsZero)) {
        objc_setAssociatedObject(self, _cmd, nil, OBJC_ASSOCIATION_ASSIGN);
    }else{
        objc_setAssociatedObject(self, _cmd, [NSValue valueWithUIEdgeInsets:fsj_enlarge], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIEdgeInsets)fsj_enlarge {
    NSValue *vl = objc_getAssociatedObject(self, @selector(setFsj_enlarge:));
    return vl ? [vl UIEdgeInsetsValue] : UIEdgeInsetsZero;
}

- (NSValue *)fsj_enlargeValue{
    NSValue *vl = objc_getAssociatedObject(self, @selector(setFsj_enlarge:));
    return vl;
}

- (void)setFsj_action:(NSDictionary *)fsj_action {
    objc_setAssociatedObject(self, _cmd, fsj_action, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (fsj_action && fsj_action.count > 0) {
        self.userInteractionEnabled = YES;
        if ([self isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton*)self;
            NSArray *actions = [btn actionsForTarget:self forControlEvent:UIControlEventTouchUpInside];
            if (![actions containsObject:@"_fsjRunAction:"]) {
                [btn addTarget:self action:@selector(_fsjRunAction:) forControlEvents:UIControlEventTouchUpInside];
            }
        }else {
            for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
                if ([gesture.fsj_identify isEqualToString:@"fsj_action"]) return;
            }
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_fsjRunAction:)];
            tap.fsj_identify = @"fsj_action";
            [self addGestureRecognizer:tap];
        }
    }else {
        if ([self isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton*)self;
            NSArray *actions = [btn actionsForTarget:self forControlEvent:UIControlEventTouchUpInside];
            if ([actions containsObject:@"_fsjRunAction:"]) {
                [btn removeTarget:self action:@selector(_fsjRunAction:) forControlEvents:UIControlEventTouchUpInside];
            }
        }else {
            for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
                if ([gesture.fsj_identify isEqualToString:@"fsj_action"]) {
                    [self removeGestureRecognizer:gesture];
                    return;
                }
            }
        }
    }
}

- (NSDictionary *)fsj_action{
    return objc_getAssociatedObject(self, @selector(setFsj_action:));
}

#pragma mark - 私有方法
- (CGRect)fsj_enlargedRect {
    NSValue *vl = [self fsj_enlargeValue];
    UIEdgeInsets insets = vl ? [vl UIEdgeInsetsValue] : UIEdgeInsetsZero;
    if (vl && !UIEdgeInsetsEqualToEdgeInsets(insets, UIEdgeInsetsZero)) {
        return CGRectMake(self.bounds.origin.x - insets.left,
                          self.bounds.origin.y - insets.top,
                          self.bounds.size.width + insets.left + insets.right,
                          self.bounds.size.height + insets.top + insets.bottom);
    } else {
        return self.bounds;
    }
}

- (UIViewController *)_myViewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (UIViewController *)currentTopViewController{
    UIViewController* viewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return [self findBestViewController:viewController];
}

- (UIViewController *)findBestViewController:(UIViewController *)vc{
    if (vc.presentedViewController) {
        return [self findBestViewController:vc.presentedViewController];
    }else if([vc isKindOfClass:[UISplitViewController class]]){
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0){
            return [self findBestViewController:svc.viewControllers.lastObject];
        }else{
            return vc;
        }
    }else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController* svc = (UINavigationController*)vc;
        if (svc.viewControllers.count > 0){
            return [self findBestViewController:svc.topViewController];
        }else{
            return vc;
        }
    }else if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0){
            return [self findBestViewController:svc.selectedViewController];
        }else{
            return vc;
        }
    }else{
        return vc;
    }
}

#pragma mark - 外部调用/重写
- (BOOL)fsj_customRunAction:(NSDictionary *)action{
    return NO;
}

- (void)fsj_runZHAction:(NSDictionary *_Nonnull)action {
    if (action) [self _fsjRunForwardAction:action];
}

#pragma mark - EVENT
- (void)_fsjRunAction:(UITapGestureRecognizer *)tap{
    if ([tap isKindOfClass:UIGestureRecognizer.class]) {
        CGRect rect = [self fsj_enlargedRect];
        if (!CGRectContainsPoint(rect, [tap locationInView:self])) {return;}
    }
    tap.enabled = NO;//禁止频繁点击
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        tap.enabled = YES;
    });
    NSDictionary *action = self.fsj_action;
    if (![self fsj_customRunAction:action]) {
        [self _fsjRunForwardAction:action];
    }
}

- (void)_fsjRunForwardAction:(NSDictionary *)action{
    UIViewController *vc = [self _myViewController];
    if (!vc) vc = [self currentTopViewController];
    NSString *msg = action[@"msg"];
    if (msg) {
        SEL  sel = NSSelectorFromString(msg);//优先处理msg消息
        id   target = action[@"target"];
        if (target) {
            NSAssert([target respondsToSelector:sel], @"%@未实现 %@方法",target,msg);
            ((void(*)(id,SEL,id))objc_msgSend)(target, sel, action[@"info"]);
        }else{
            BOOL sr = [self respondsToSelector:sel];
            BOOL vr = [vc respondsToSelector:sel];
            NSAssert((sr || vr), @"%@ OR %@未实现 %@方法",self,vc,msg);
            if (vr) {
                ((void(*)(id,SEL,id))objc_msgSend)(vc, sel, action[@"info"]);
            }else if(sr){
                ((void(*)(id,SEL,id))objc_msgSend)(self, sel, action[@"info"]);
            }
        }
    }else{
        SEL ctls = NSSelectorFromString(@"handleCommand:");  //优先处理msg消息
        if (vc && [vc respondsToSelector:ctls]) {
            NSAssert([vc respondsToSelector:ctls], @"%@未实现 %@方法",vc, @"handleCommand:");
            ((void(*)(id,SEL,id))objc_msgSend)(vc, ctls, action);
        }else {
            Class cls = (id)objc_getClass("FSJRunEngine");
            NSAssert(cls != nil, @"无法找到类FSJRunEngine");
            ((void(*)(id,SEL,id,id))objc_msgSend)(cls,NSSelectorFromString(@"handleCommand:handle:"),action,nil);
        }
    }
}


@end
