//
//  TTRunLoopPerformController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/22.
//

#import "TTRunLoopPerformController.h"

@interface TTRunLoopPerformController ()

@end

@implementation TTRunLoopPerformController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 总结：
    // performSelector方法和NSTimer在子线程中运行，需要将子线程的RunLoop run起来才能起作用
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self performSelector:@selector(haha:) withObject:nil afterDelay:2];
        [self haha:nil];
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"=====");
        }];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] run];
    });
    
}

- (void)haha:(id)sender {
    NSLog(@"%s %@",__FUNCTION__,[NSThread currentThread]);
}

@end
