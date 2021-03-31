//
//  TTTestLocalEventLibController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/31.
//

#import "TTTestLocalEventLibController.h"
#import "TTLocalLibModel.h"

@interface TTTestLocalEventLibController ()
@property (strong, nonatomic) UIButton *btn1;
@property (strong, nonatomic) UIView *view1;

@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation TTTestLocalEventLibController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self btn1];
    [self view1];
    
    self.tableView.tableViewAdapter.footerHeight = 0;
    self.tableView.tableViewAdapter.headerHeight = 0;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view1.mas_bottom).offset(10);
    }];
    [self reload];
}

- (void)reload {
    self.tableView.cellDatas = @[self.dataArray];
    [self.tableView reloadData];
}

- (UIButton *)btn1 {
    if (!_btn1) {
        UIButton *obj = [UIButton buttonWithType:UIButtonTypeCustom];
        [obj setBackgroundColor:[UIColor fsj_randomColor]];
        [self.view addSubview:_btn1 = obj];
        obj.fsj_action = @{@"app_action":@"test"};//fMsgPack(@"ttTest:",@"fansj");
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
    }
    return _btn1;
}

- (UIView *)view1 {
    if (!_view1) {
        UIView *obj = [UIView new];
        [obj setBackgroundColor:[UIColor fsj_randomColor]];
        [self.view addSubview:_view1 = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.btn1.mas_bottom);
            make.height.mas_equalTo(44);
        }];
        obj.fsj_action = fMsg(@"ttTestView");
    }
    return _view1;
}

- (void)ttTest:(id)sender {
    NSLog(@"%s %@",__FUNCTION__,sender);
}

- (void)ttTestView {
    NSLog(@"%s",__FUNCTION__);
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        NSMutableArray *a = [NSMutableArray new];
        for (NSInteger i = 0; i < 10; i++) {
            TTLocalLibModel *m = [self cModelTitle:[NSString stringWithFormat:@"%ld",i]];
            NSInteger re = i % 4;
            if (re == 0) {
                // 不带参数的方法
                m.action = fMsgForward(@"testClickCell", FWKProxy(self));
            }else if (re == 1) {
                // 带参数的方法
                m.action = fMsgPackForward(@"testTapCell:", FWKProxy(self), FWKProxy(m));
            }else if (re == 2) {
                // 不带参数的跳转
                m.action = fRunCMD(@"tt_basedata");
            }else {
                m.action = fRunCMDINFO(@"tto_controller",@{@"title":@"凡施健"});
            }
            [a addObject:m];
        }
        _dataArray = a;
    }
    return _dataArray;
}

- (TTLocalLibModel *)cModelTitle:(NSString *)title {
    TTLocalLibModel *m = [TTLocalLibModel new];
    m.title = title;
    return m;
}

- (void)testClickCell {
    NSLog(@"%s",__FUNCTION__);
}

- (void)testTapCell:(id)data {
    NSLog(@"%s %@",__FUNCTION__,data);
}

@end
