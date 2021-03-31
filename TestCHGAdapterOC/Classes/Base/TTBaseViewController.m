//
//  TTBaseViewController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/20.
//

#import "TTBaseViewController.h"
#import <objc/message.h>

@interface TTBaseViewController ()

@end

@implementation TTBaseViewController
+ (instancetype)newCtl:(NSDictionary *)info{
    TTBaseViewController *obj = [self class].new;
    obj.metaInfo = info;
    return obj;
}

- (void)dealloc {
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
}

#pragma mark - 事件处理
- (void)handleCommand:(NSDictionary *)action{
    [self handleCommand:action handle:nil];
}
- (void)handleCommand:(NSDictionary *)action handle:(id)handle{
    Class cls = (id)objc_getClass("TTRunEngine");
    NSAssert(cls != nil, @"无法找到类TTRunEngine");
    ((void(*)(id,SEL,id,id))objc_msgSend)(cls,NSSelectorFromString(@"handleCommand:handle:"),action,handle);
}

@end
