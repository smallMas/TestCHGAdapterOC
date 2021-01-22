//
//  TTAnimationTableViewCell.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/22.
//

#import "TTAnimationTableViewCell.h"
#import "TTAnimationModel.h"

@interface TTAnimationTableViewCell ()
@property (nonatomic, strong) UIView *centerView;
@end

@implementation TTAnimationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self.contentView addSubview:self.centerView];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(self.contentView).inset(10);
        make.width.mas_equalTo(self.centerView.mas_height).multipliedBy(1.0);
        make.centerX.mas_equalTo(self.contentView);
    }];
}

#pragma mark - 懒加载
- (UIView *)createView {
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor fsj_randomColor]];
    return view;
}

- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [self createView];
    }
    return _centerView;
}

#pragma mark - adapter
- (void)cellWillAppear {
    [super cellWillAppear];
    TTAnimationModel *model = self.model;
    
    switch (model.type) {
        case TTAnimationTypePosition:
            [self animation1:self.centerView];
            break;
        case TTAnimationTypeTransformTotationZ:
            [self animation2:self.centerView];
            break;
        case TTAnimationTypeTransformTotationY:
            [self animation3:self.centerView];
            break;
        case TTAnimationTypeTransformTotationX:
            [self animation4:self.centerView];
            break;
        case TTAnimationTypeTransformScale:
            [self animation5:self.centerView];
            break;
        case TTAnimationTypeOpacity:
            [self animation6:self.centerView];
            break;
        case TTAnimationTypeBackgroundColor:
            [self animation7:self.centerView];
            break;
        case TTAnimationTypeTransformRotation:
            [self animation8:self.centerView];
            break;
        default:
            break;
    }
}

- (void)animation1:(UIView *)view {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:
                           CGPointMake(view.fsj_width*0.5, self.contentView.fsj_height*0.5)];
    animation.toValue = [NSValue valueWithCGPoint:
                         CGPointMake(self.contentView.fsj_width-view.fsj_width*0.5, self.contentView.fsj_height*0.5)];
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

- (void)animation8:(UIView *)view {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.fromValue = @(- M_PI/180.0 * 8);
    animation.toValue = @(M_PI/180.0 * 8);
    animation.duration = 4.0;
    animation.repeatCount = INFINITY;
    [view.layer addAnimation:animation forKey:nil];
}

@end
