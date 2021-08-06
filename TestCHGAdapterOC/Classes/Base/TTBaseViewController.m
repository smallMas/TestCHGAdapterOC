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
    
    if (self.navigationController && self.navigationController.viewControllers.count > 1) {
        [self setBackNavigationBar];
    }
}

// 添加返回按钮
- (void)setBackNavigationBar {
    UIImage *image = [UIImage imageNamed:@"public_icon_black_back"];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(__back)];
    self.navigationItem.leftBarButtonItem = barItem;
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

#pragma mark - btn action
- (void)__back {
    [self __back:YES];
}

- (void)__back:(BOOL)animated {
    if (self.navigationController && self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:animated];
    }else {
        [self dismissViewControllerAnimated:animated completion:nil];
    }
}

@end
