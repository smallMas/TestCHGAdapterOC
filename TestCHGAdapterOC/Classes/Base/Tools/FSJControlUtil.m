//
//  FSJControlUtil.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/31.
//

#import "FSJControlUtil.h"

BOOL showController(UIViewController *vc,BOOL animated,void (^completion)(void)){
    @try {
        UIWindow* window = nil;
        if (@available(iOS 13.0, *))
        {
            for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes)
            {
                if (windowScene.activationState == UISceneActivationStateForegroundActive)
                {
                    window = windowScene.windows.firstObject;

                    break;
                }
            }
        }else{
            window = [[UIApplication sharedApplication].delegate window];
        }
        UIViewController *controller = [window rootViewController];
        if (!controller) {
            return NO;
        }
        if ([controller isKindOfClass:[UINavigationController class]]) {
            [(UINavigationController*)controller pushViewController:vc animated:animated];
            return YES;
        }else if([controller isKindOfClass:[UITabBarController class]]){
            UIViewController *selectController = [(UITabBarController*)controller selectedViewController];
            
            if ([selectController isKindOfClass:[UINavigationController class]]) {
                UINavigationController* nav = (UINavigationController*)selectController;
                
                UIViewController *pCtr = [nav presentedViewController];
                while ([pCtr presentedViewController]!=nil) {
                    pCtr = [pCtr presentedViewController];
                }
                if (pCtr) {
                    if ([pCtr isKindOfClass:[UINavigationController class]]) {
                        [(UINavigationController*)pCtr pushViewController:vc animated:animated];
                    }else{
                        [pCtr presentViewController:vc animated:YES completion:nil];
                    }
                }else{
                    [nav pushViewController:vc animated:animated];
                }
                return YES;
            }else{
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                [selectController presentViewController:nav animated:animated completion:completion];
                return YES;
            }
        }else if ([controller.presentedViewController isKindOfClass:UINavigationController.class]){
            [(UINavigationController*)controller.presentedViewController pushViewController:vc animated:animated];
            return YES;
        }else{
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            nav.modalPresentationStyle = UIModalPresentationFullScreen;
            [controller presentViewController:nav animated:YES completion:completion];
            return YES;
        }
        return NO;
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

UIViewController *TT_FindBestViewController(UIViewController *vc){
    if (vc.presentedViewController) {
        return TT_FindBestViewController(vc.presentedViewController);
    }else if([vc isKindOfClass:[UISplitViewController class]]){
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0){
            return TT_FindBestViewController(svc.viewControllers.lastObject);
        }else{
            return vc;
        }
    }else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController* svc = (UINavigationController*)vc;
        if (svc.viewControllers.count > 0){
            return TT_FindBestViewController(svc.topViewController);
        }else{
            return vc;
        }
    }else if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0){
            return TT_FindBestViewController(svc.selectedViewController);
        }else{
            return vc;
        }
    }else{
        return vc;
    }
}

UIViewController *currentTopViewController(){
    UIViewController* viewController = [UIApplication sharedApplication].delegate.window.rootViewController;
//    return findBestViewController(viewController);
    TT_FindBestViewController(viewController);
    return nil;
}

@implementation FSJControlUtil

@end
