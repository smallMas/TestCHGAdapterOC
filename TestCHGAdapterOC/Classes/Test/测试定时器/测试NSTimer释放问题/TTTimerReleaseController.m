//
//  TTTimerReleaseController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/25.
//

#import "TTTimerReleaseController.h"
#import "TTTimeMedium.h"

@interface TTTimerReleaseController ()
//@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) TTTimeMedium *medium;

@property (nonatomic ,strong) dispatch_source_t timer;

@end

@implementation TTTimerReleaseController

- (void)dealloc
{
    [self.medium stop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    _timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(runTime) userInfo:nil repeats:YES];
    
//    [self.medium startTimeInterval:1 block:^{
//        NSLog(@"=====");
//    }];
    
    [self gcdTimer];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        sleep(3);
//    });
}

- (void)gcdTimer {
    dispatch_queue_t queue = dispatch_get_main_queue();
    //1.创建GCD中的定时器
    /*
     第一个参数:创建source的类型 DISPATCH_SOURCE_TYPE_TIMER:定时器
     第二个参数:0
     第三个参数:0
     第四个参数:队列
     */
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

    //2.设置时间等
    /*
     第一个参数:定时器对象
     第二个参数:DISPATCH_TIME_NOW 表示从现在开始计时
     第三个参数:间隔时间 GCD里面的时间最小单位为 纳秒
     第四个参数:精准度(表示允许的误差,0表示绝对精准)
     */
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);

    //3.要调用的任务
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"GCD-----%@",[NSThread currentThread]);
    });

    //4.开始执行
    dispatch_resume(timer);

    //
    self.timer = timer;
}

- (void)runTime {
    NSLog(@"%s",__FUNCTION__);
}

- (TTTimeMedium *)medium {
    if (!_medium) {
        _medium = [TTTimeMedium new];
    }
    return _medium;
}


@end
