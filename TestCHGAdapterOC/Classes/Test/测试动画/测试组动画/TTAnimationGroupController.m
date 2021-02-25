//
//  TTAnimationGroupController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/22.
//

#import "TTAnimationGroupController.h"

@interface TTAnimationGroupController ()
@property (nonatomic, strong) UIView *centerView;
@end

@implementation TTAnimationGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
}

- (void)setupView {
    [self.view addSubview:self.centerView];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.center.mas_equalTo(self.view);
    }];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)]];
}

#pragma mark - 懒加载
- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [UIView new];
        [_centerView setBackgroundColor:[UIColor fsj_randomColor]];
    }
    return _centerView;
}

#pragma mark - EVENT
- (void)tapClick:(id)sender {
    [self animation];
}

#pragma mark - 动画
- (void)animation {
    CGFloat margin = 20;
    CGFloat half = self.centerView.fsj_width*0.5;
    UIBezierPath *movePath = [UIBezierPath bezierPathWithRect:CGRectMake(margin+half, margin+half, self.view.fsj_width-margin*2-half*2, self.view.fsj_height-margin*2-half*2)];
    
    // 划线
//    CGFloat half = self.centerView.fsj_width*0.5;
//    UIBezierPath *linePath = [UIBezierPath bezierPathWithRect:CGRectMake(margin+half, margin+half, self.view.fsj_width-margin*2-half*2, self.view.fsj_height-margin*2-half*2)];
//    CAShapeLayer *layer = [CAShapeLayer layer];
//    layer.lineWidth = 2;
//    layer.strokeColor = [UIColor blueColor].CGColor;
//    layer.fillColor = [UIColor clearColor].CGColor;
//    layer.path = linePath.CGPath;
//    [self.view.layer addSublayer:layer];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = movePath.CGPath;
    animation.duration = 12; // 动画时间
    animation.autoreverses = NO;//执行的动画按照原动画返回执行
    // removedOnCompletion和 kCAFillModeForwards同时设置，动画结束停在最后一帧
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = INFINITY;
//    [self.centerView.layer addAnimation:animation forKey:nil];
    
    //
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation2.toValue = @(M_PI*2);
    animation2.duration = 4.0;
    animation2.repeatCount = INFINITY;
//    [self.centerView.layer addAnimation:animation2 forKey:nil];

    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[animation, animation2];
    group.duration = 12;
    
    [self.centerView.layer addAnimation:group forKey:nil];
}

@end
