//
//  TTAnimationPropertyController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/22.
//

#import "TTAnimationPropertyController.h"
#import "TTAnimationModel.h"

@interface TTAnimationPropertyController ()
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, strong) UIView *view3;
@property (nonatomic, strong) UIView *view4;
@property (nonatomic, strong) UIView *view5;
@property (nonatomic, strong) UIView *view6;
@property (nonatomic, strong) UIView *view7;
@end

@implementation TTAnimationPropertyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self setupView];
    
    [self setupTableView];
}

- (void)setupTableView {
    [self.view addSubview:self.tableView];
    self.tableView.tableViewAdapter.headerHeight = 0;
    self.tableView.tableViewAdapter.footerHeight = 0;
    self.tableView.cellDatas = @[[self dataArray]];
}

- (NSArray *)dataArray {
    return @[
        [TTAnimationModel createT:TTAnimationTypePosition],
        [TTAnimationModel createT:TTAnimationTypeTransformTotationZ],
        [TTAnimationModel createT:TTAnimationTypeTransformTotationY],
        [TTAnimationModel createT:TTAnimationTypeTransformTotationX],
        [TTAnimationModel createT:TTAnimationTypeTransformScale],
        [TTAnimationModel createT:TTAnimationTypeOpacity],
        [TTAnimationModel createT:TTAnimationTypeBackgroundColor],
        [TTAnimationModel createT:TTAnimationTypeTransformRotation],
    ];
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    [self animation1:self.view1];
//    [self animation2:self.view2];
//    [self animation3:self.view3];
//    [self animation4:self.view4];
//    [self animation5:self.view5];
//    [self animation6:self.view6];
//    [self animation7:self.view7];
//}

- (void)setupView {
    [self.view addSubview:self.view1];
    [self.view addSubview:self.view2];
    [self.view addSubview:self.view3];
    [self.view addSubview:self.view4];
    [self.view addSubview:self.view5];
    [self.view addSubview:self.view6];
    [self.view addSubview:self.view7];
    
    CGFloat wh = 60;
    [self.view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(wh);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).inset(20);
    }];
    
    [self.view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(wh);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view1.mas_bottom).inset(20);
    }];
    
    [self.view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(wh);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view2.mas_bottom).inset(20);
    }];
    
    [self.view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(wh);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view3.mas_bottom).inset(20);
    }];
    
    [self.view5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(wh);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view4.mas_bottom).inset(20);
    }];
    
    [self.view6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(wh);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view5.mas_bottom).inset(20);
    }];
    
    [self.view7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(wh);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view6.mas_bottom).inset(20);
    }];
}

#pragma mark - 懒加载
- (UIView *)createView {
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor fsj_randomColor]];
    return view;
}

- (UIView *)view1 {
    if (!_view1) {
        _view1 = [self createView];
    }
    return _view1;
}

- (UIView *)view2 {
    if (!_view2) {
        _view2 = [self createView];
    }
    return _view2;
}

- (UIView *)view3 {
    if (!_view3) {
        _view3 = [self createView];
    }
    return _view3;
}

- (UIView *)view4 {
    if (!_view4) {
        _view4 = [self createView];
    }
    return _view4;
}

- (UIView *)view5 {
    if (!_view5) {
        _view5 = [self createView];
    }
    return _view5;
}

- (UIView *)view6 {
    if (!_view6) {
        _view6 = [self createView];
    }
    return _view6;
}

- (UIView *)view7 {
    if (!_view7) {
        _view7 = [self createView];
    }
    return _view7;
}

#pragma mark - 动画
- (void)animation1:(UIView *)view {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(view.fsj_width*0.5, view.fsj_top+view.fsj_height*0.5)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.fsj_width-view.fsj_width*0.5, view.fsj_top+view.fsj_height*0.5)];
    animation.duration = 4.0;
    animation.repeatCount = INFINITY;
    [view.layer addAnimation:animation forKey:nil];
}

- (void)animation2:(UIView *)view {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = @(M_PI*2);
    animation.duration = 4.0;
    animation.repeatCount = INFINITY;
    [view.layer addAnimation:animation forKey:nil];
}

- (void)animation3:(UIView *)view {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.toValue = @(M_PI*2);
    animation.duration = 4.0;
    animation.repeatCount = INFINITY;
    [view.layer addAnimation:animation forKey:nil];
}

- (void)animation4:(UIView *)view {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation.toValue = @(M_PI*2);
    animation.duration = 4.0;
    animation.repeatCount = INFINITY;
    [view.layer addAnimation:animation forKey:nil];
}

- (void)animation5:(UIView *)view {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @(0.2);
    animation.toValue = @(1.5);
    animation.duration = 4;
    animation.repeatCount = INFINITY;
    [view.layer addAnimation:animation forKey:nil];
}

- (void)animation6:(UIView *)view {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @(1);
    animation.toValue = @(0);
    animation.duration = 4;
    animation.repeatCount = INFINITY;
    [view.layer addAnimation:animation forKey:nil];
}

- (void)animation7:(UIView *)view {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.toValue = (__bridge id _Nullable)(UIColor.greenColor.CGColor);
    animation.duration = 4;
    animation.repeatCount = INFINITY;
    [view.layer addAnimation:animation forKey:nil];
}

@end
