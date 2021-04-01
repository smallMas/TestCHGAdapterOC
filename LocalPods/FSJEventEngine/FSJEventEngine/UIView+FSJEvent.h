//
//  UIView+FSJEvent.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/31.
//

#import <UIKit/UIKit.h>
#import <FSJMacro.h>
#import <FSJWeakProxy.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FSJEvent)
/** enlarge or shrink touch area  */
@property (assign, nonatomic) UIEdgeInsets fsj_enlarge;
/** 事件 */
@property (nonatomic, strong) NSDictionary * _Nullable fsj_action;

/** user manualy handle this action  */
- (BOOL)fsj_customRunAction:(NSDictionary *_Nullable)action;

/** manualy excecute an action to self's viewController  */
- (void)fsj_runZHAction:(NSDictionary *_Nonnull)action;
- (UIViewController *)currentTopViewController;

@end

NS_ASSUME_NONNULL_END
