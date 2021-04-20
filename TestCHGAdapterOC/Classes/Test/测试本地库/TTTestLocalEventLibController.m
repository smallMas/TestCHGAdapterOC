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
        obj.fsj_action = fMsg(@"ttTest");
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

- (void)ttTest {
    NSLog(@"%s ",__FUNCTION__);
//    UIViewController *vc = [self.view currentTopViewController];
//    NSLog(@"vc : %@",vc);
    
}

- (void)ttTestView {
    NSLog(@"%s",__FUNCTION__);
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        void(^reloadTop)(NSString *) = ^(NSString *string){
            NSLog(@"string : %@",string);
        };
        
        NSMutableArray *a = [NSMutableArray new];
        [a addObject:[self cModelTitle:@"不带参数的方法" action:fMsgForward(@"testClickCell", FWKProxy(self))]];
        [a addObject:[self cModelTitle:@"带参数的方法" action:fMsgPackForward(@"testTapCell:", FWKProxy(self), @"aaaaaa")]];
        [a addObject:[self cModelTitle:@"不带参数的跳转" action:fRunCMD(@"tt_basedata")]];
        [a addObject:[self cModelTitle:@"带参数的跳转" action:fRunCMDINFO(@"tto_controller",@{@"title":@"凡施健"})]];
        [a addObject:[self cModelTitle:@"不带参数的跳转，并回调，回调在VC的meta" action:fRunCMDINFO(@"tto_controller",@{@"title":@"凡施健",@"callback":[reloadTop copy]})]];
        [a addObject:[self cModelTitle:@"不带参数的跳转，并回调，回调在setHandle" action:fMsg(@"gotoVC")]];
        _dataArray = a;
    }
    return _dataArray;
}

- (TTLocalLibModel *)cModelTitle:(NSString *)title action:(id)action {
    TTLocalLibModel *m = [TTLocalLibModel new];
    m.title = title;
    m.action = action;
    return m;
}

- (void)testClickCell {
    NSLog(@"%s",__FUNCTION__);
}

- (void)testTapCell:(id)data {
    NSLog(@"%s %@",__FUNCTION__,data);
}

- (void)gotoVC {
    void(^reloadTop)(NSString *) = ^(NSString *string){
        NSLog(@"string : %@",string);
    };
    
    TT_RunEngine(fRunCMDINFO(@"tto_controller",@{@"title":@"凡施健"}), reloadTop);
}

@end
