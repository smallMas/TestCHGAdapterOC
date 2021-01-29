//
//  UIViewController+TTThread.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/29.
//

#import "UIViewController+TTThread.h"

@implementation UIViewController (TTThread)

+ (NSThread *)shareThread {
    static NSThread *shareThread = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareThread = [[NSThread alloc] initWithTarget:self selector:@selector(threadTest:) object:nil];
        shareThread.name = @"fansj thread";
        [shareThread start];
    });
    return shareThread;
}

+ (void)threadTest:(id)sender {
    NSLog(@"%s %@",__FUNCTION__,[NSThread currentThread]);
    [[NSRunLoop currentRunLoop] run];
}

@end
