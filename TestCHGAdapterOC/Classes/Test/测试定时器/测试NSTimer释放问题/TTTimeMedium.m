//
//  TTTimeMedium.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/25.
//

#import "TTTimeMedium.h"

@interface TTTimeMedium ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) FSJVoidBlock block;

@end

@implementation TTTimeMedium

- (void)dealloc
{
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
}
- (void)startTimeInterval:(NSTimeInterval)ti block:(FSJVoidBlock)block {
    self.block = block;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runTime) userInfo:nil repeats:YES];
}

- (void)runTime {
    if (self.block) {
        self.block();
    }
}

- (void)stop {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
