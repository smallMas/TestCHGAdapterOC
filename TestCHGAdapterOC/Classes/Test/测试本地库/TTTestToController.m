//
//  TTTestToController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/31.
//

#import "TTTestToController.h"

@interface TTTestToController ()

@property (strong, nonatomic) UIButton *btn1;

@property (strong, nonatomic) void (^ block)(NSString *s);
@end

@implementation TTTestToController

- (void)viewDidLoad {
    [super viewDidLoad];
    id callback = self.metaInfo[@"callback"];
    self.title = self.metaInfo[@"title"];
    
    [self btn1];
}


- (UIButton *)btn1 {
    if (!_btn1) {
        UIButton *obj = [UIButton buttonWithType:UIButtonTypeCustom];
        [obj setBackgroundColor:[UIColor fsj_randomColor]];
        [self.view addSubview:_btn1 = obj];
        obj.fsj_action = fMsg(@"clickBtn");
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
    }
    return _btn1;
}

//- (void)setHandle {
//    NSLog(@"%s",__FUNCTION__);
//}

- (void)clickBtn {
    NSLog(@"%s",__FUNCTION__);
    void(^psblcok)(NSString *s) = self.metaInfo[@"callback"];
    if (psblcok) psblcok(@"fanshijian is ok.");
    

    if (self.block) {
        self.block(@"fansj is handle.");
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setHandle:(void (^)(NSString *))block {
    self.block = block;
}

@end
