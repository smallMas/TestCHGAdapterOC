//
//  TTRunloopObserverController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/22.
//

#import "TTRunloopObserverController.h"

@interface TTRunloopObserverController ()

@end

@implementation TTRunloopObserverController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addRunloopObserver];
}

- (void)addRunloopObserver {
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    //传递context
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL
    };
    //定义观察者
    //    static CFRunLoopObserverRef runloopObserver;
    CFRunLoopObserverRef runloopObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopBeforeWaiting, YES, 0, &callBack, &context);
    //添加观察者
    CFRunLoopAddObserver(runloop, runloopObserver, kCFRunLoopCommonModes);
    //释放内存
    CFRelease(runloop);
}

void callBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    NSLog(@"%s",__FUNCTION__);
}

@end
