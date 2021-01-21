//
//  TTGCDGroupController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/21.
//

#import "TTGCDGroupController.h"

@interface TTGCDGroupController ()

@end

@implementation TTGCDGroupController

- (void)viewDidLoad {
   [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // GCD Group，有三个关键动作 enter leave notify
    [self testGroup2];
}

- (void)testGroup1 {
    NSLog(@"第一种group方式");
    NSLog(@"-------------1");
    dispatch_group_t group = dispatch_group_create();
    for (NSInteger i = 0; i < 10; i++) {
        dispatch_group_enter(group);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"任务%ld开始",(long)i+1);
            sleep((int)(i+1));
            NSLog(@"任务%ld结束",(long)i+1);
            dispatch_group_leave(group);
        });
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"所有任务结束");
    });
    NSLog(@"-------------2");
}

- (void)testGroup2 {
    NSLog(@"第二种group方式");
    dispatch_group_t group = dispatch_group_create();
    for (NSInteger i = 0; i < 10; i++) {
        dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
            NSLog(@"任务%ld开始",(long)i+1);
            sleep((int)(i+1));
            NSLog(@"任务%ld结束",(long)i+1);
        });
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"所有任务结束");
    });
}

@end
