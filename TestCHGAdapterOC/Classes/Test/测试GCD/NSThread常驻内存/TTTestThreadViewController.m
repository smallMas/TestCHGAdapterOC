//
//  TTTestThreadViewController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/29.
//

/*
 使用NSRunLoop，让NSThread常驻内存
 */

#import "TTTestThreadViewController.h"
#import "UIViewController+TTThread.h"

@interface TTTestThreadViewController ()

@end

@implementation TTTestThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self performSelector:@selector(ttRun) onThread:[UIViewController shareThread] withObject:nil waitUntilDone:NO];
}

- (void)ttRun {
    NSLog(@"%s %@",__FUNCTION__,[NSThread currentThread]);
}

@end
