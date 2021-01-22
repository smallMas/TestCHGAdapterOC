//
//  TTAnimationPositionController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/22.
//

#import "TTAnimationPositionController.h"

@interface TTAnimationPositionController ()
@property (nonatomic, strong) UIView *centerView;
@end

@implementation TTAnimationPositionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.centerView];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(50);
        make.center.mas_equalTo(self.view);
    }];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)]];
}

- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [UIView new];
        [_centerView setBackgroundColor:[UIColor fsj_randomColor]];
    }
    return _centerView;
}

- (void)tapClick:(id)sender {
    [self animation2];
}

- (void)animation1 {
    CGFloat margin = 20;
    NSTimeInterval duration = 0.5;
    [self.centerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(50);
        make.left.mas_equalTo(margin);
        make.top.mas_equalTo(margin);
    }];
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:duration animations:^{
        [self.centerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(50);
            make.right.mas_equalTo(margin);
            make.top.mas_equalTo(margin);
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration animations:^{
            [self.centerView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.height.mas_equalTo(50);
                make.right.mas_equalTo(margin);
                make.bottom.mas_equalTo(self.view).inset(margin);
            }];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:duration animations:^{
                [self.centerView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.width.height.mas_equalTo(50);
                    make.left.mas_equalTo(margin);
                    make.bottom.mas_equalTo(self.view).inset(margin);
                }];
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:duration animations:^{
                    [self.centerView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.width.height.mas_equalTo(50);
                        make.left.mas_equalTo(margin);
                        make.top.mas_equalTo(margin);
                    }];
                    [self.view layoutIfNeeded];
                }];
            }];
        }];
    }];
}

// 帧动画
// 缺点 : 控制不到每一段的动画时间
- (void)animation2 {
    CGFloat margin = 20;
    UIBezierPath *movePath = [UIBezierPath bezierPathWithRect:CGRectMake(margin, margin, self.view.fsj_width-margin*2, self.view.fsj_height-margin*2)];
    
    // 划线
    CGFloat half = self.centerView.fsj_width*0.5;
    UIBezierPath *linePath = [UIBezierPath bezierPathWithRect:CGRectMake(margin+half, margin+half, self.view.fsj_width-margin*2-half*2, self.view.fsj_height-margin*2-half*2)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = 2;
    layer.strokeColor = [UIColor blueColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.path = linePath.CGPath;
    [self.view.layer addSublayer:layer];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = movePath.CGPath;
    animation.duration = 2; // 动画时间
    animation.autoreverses = NO;//执行的动画按照原动画返回执行
    // removedOnCompletion和 kCAFillModeForwards同时设置，动画结束停在最后一帧
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.centerView.layer addAnimation:animation forKey:@"position"];
}

- (void)animation3 {
    CGFloat margin = 20;
    CGPoint point1 = CGPointMake(margin, margin);
    CGPoint point2 = CGPointMake(self.view.fsj_width-margin, margin);
    CGPoint point3 = CGPointMake(self.view.fsj_width-margin, self.view.fsj_height-margin);
    CGPoint point4 = CGPointMake(margin, self.view.fsj_height-margin);
    
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.values = @[[NSValue valueWithCGPoint:point1],
                         [NSValue valueWithCGPoint:point2],
                         [NSValue valueWithCGPoint:point3],
                         [NSValue valueWithCGPoint:point4],
                         [NSValue valueWithCGPoint:point1]];
    animation.duration = 20;
    animation.keyTimes = @[@(0), @(0.1), @(0.5), @(0.6), @(1)]; // 取值0-1，数组中递增
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.centerView.layer addAnimation:animation forKey:@"position"];
}

@end
