//
//  TTGCDSemaphoreController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/21.
//

#import "TTGCDSemaphoreController.h"

@interface TTGCDSemaphoreController ()

@end

@implementation TTGCDSemaphoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 信号量 三个操作  create 、wait、single
    // wait 减1操作  single加1操作
    // 如果减1后的值小于0，那么该函数一直等待，相当于阻塞了当前线程
    // dispatch_semaphore_create传的值 相当于是设置最大并发数
    NSLog(@"-------------1");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __block NSInteger count = 10;
        dispatch_semaphore_t sem = dispatch_semaphore_create(count);
        for (NSInteger i = 0; i < count; i++) {
            dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSLog(@"任务%ld开始",(long)i+1);
                sleep((int)(i+1));
//                sleep(2);
                NSLog(@"任务%ld结束",(long)i+1);
                dispatch_semaphore_signal(sem);
                count --;
                
                if (count == 0) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"所有任务结束");
                        dispatch_semaphore_signal(sem);
                    });
                }
            });
        }
    });
    NSLog(@"-------------2");
}


@end
