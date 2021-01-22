//
//  TTGCDBarrierController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/21.
//

#import "TTGCDBarrierController.h"

@interface TTGCDBarrierController ()

@end

@implementation TTGCDBarrierController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{
        sleep(2);
        NSLog(@"第一个任务 : %@",[NSThread currentThread]);
    });

    dispatch_async(queue, ^{
        sleep(3);
        NSLog(@"第二个任务 : %@",[NSThread currentThread]);
    });

    dispatch_barrier_async(queue, ^{
        NSLog(@"以上两个任务都执行完了");
    });

    dispatch_async(queue, ^{
        sleep(2);
        NSLog(@"第三个任务 : %@",[NSThread currentThread]);
    });

    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"第四个任务 : %@",[NSThread currentThread]);
    });

    dispatch_barrier_async(queue, ^{
        NSLog(@"以上四个任务都执行完了");
    });
}


@end
