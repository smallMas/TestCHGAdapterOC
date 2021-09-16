//
//  TTTurnTableView.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/8/5.
//

#import "TTTurnTableView.h"

@implementation TTTurnItemModel

@end

@interface TTTurnItemView : UIView
@property (weak, nonatomic) UILabel *lab;

@property (strong, nonatomic) NSString *text;
@property (assign, nonatomic) NSTextAlignment textAlignment;
@property (strong, nonatomic) UIFont *font;

@end

@implementation TTTurnItemView

- (UILabel *)lab {
    if (!_lab) {
        UILabel *obj = [UILabel new];
        [self addSubview:_lab = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeLRV(0);
            kMakeTV(20);
        }];
    }
    return _lab;
}

- (void)setText:(NSString *)text {
    self.lab.text = text;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    self.lab.textAlignment = textAlignment;
}

- (void)setFont:(UIFont *)font {
    self.lab.font = font;
}

@end

@interface TTTurnTableView ()

@property (strong, nonatomic) TTTurnItemModel *resultModel;

@property (weak, nonatomic) UIView *bgView;
@property (weak, nonatomic) UIImageView *zzView;
@property (weak, nonatomic) UIButton *playButton;
@property (strong, nonatomic) NSArray *numberArray;

@end

@implementation TTTurnTableView

- (void)layoutSubviews {
    [super layoutSubviews];
    [self initUI];
}

- (UIView *)bgView {
    if (!_bgView) {
        UIView *obj = [[UIView alloc] init];
        [self addSubview:_bgView = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeEdge0;
        }];
        obj.backgroundColor = [UIColor fsj_colorWithHexString:@"#f47920"];
    }
    return _bgView;
}

-(void)initUI {
    // 转盘
    int count = (int)self.numberArray.count;
    for (int i = 0; i < count; i ++) {
        TTTurnItemView *label = [[TTTurnItemView alloc]initWithFrame:CGRectMake(0, 0,M_PI * CGRectGetHeight(self.bounds)/count,
                                                                  CGRectGetHeight(self.bounds)/2)];
        label.layer.anchorPoint = CGPointMake(0.5, 1);
        label.center = CGPointMake(CGRectGetHeight(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
        TTTurnItemModel *model = self.numberArray[i];
        label.text = model.title;
        CGFloat angle = M_PI * 2 / count * i;
        model.angle = angle/M_PI*180.0;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:20];
        label.transform = CGAffineTransformMakeRotation(angle);
        [self.bgView addSubview:label];
    }
    
    [self playButton];
    [self bringSubviewToFront:self.playButton];
}

- (NSArray *)numberArray {
    if (!_numberArray) {
        _numberArray = @[
            [self createTitle:@"1个水果" type:TTTurnType1],
            [self createTitle:@"1个贴纸" type:TTTurnType1],
            [self createTitle:@"谢谢惠顾" type:TTTurnTypeNormal],
            [self createTitle:@"1级动画片" type:TTTurnType3],
            [self createTitle:@"谢谢惠顾" type:TTTurnTypeNormal],
            [self createTitle:@"谢谢惠顾" type:TTTurnTypeNormal],
            [self createTitle:@"1个糖果" type:TTTurnType2],
            [self createTitle:@"谢谢惠顾" type:TTTurnTypeNormal],
        ];
    }
    return _numberArray;
}

- (TTTurnItemModel *)createTitle:(NSString *)string type:(TTTurnType)type {
    TTTurnItemModel *model = TTTurnItemModel.new;
    model.title = string;
    model.type = type;
    return model;
}

- (UIImageView *)zzView {
    if (!_zzView) {
        UIImageView *obj = [UIImageView new];
        [self addSubview:_zzView = obj];
        obj.image = [UIImage imageNamed:@"指针"];
        CGFloat ratio = 268.0/158.0;
        CGFloat w = 100;
        CGFloat h = w*ratio;
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeWHV(w, h);
            kMakeB(self.mas_centerY).offset(h*0.5);
            kMakeCenterXV(0);
        }];
    }
    return _zzView;
}

- (UIButton *)playButton {
    if (!_playButton) {
        [self zzView];
        
        UIButton *obj = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_playButton = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeWHV(100, 100);
            kMakeCenterYV(0);
            kMakeCenterXV(0);
        }];
        obj.backgroundColor = [UIColor fsj_colorWithHexString:@"#7fb80e"];
        [obj setTitle:@"启动" forState:UIControlStateNormal];
        [obj setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [obj fsj_setRoundRadius:50 borderColor:[UIColor clearColor]];
        obj.layer.zPosition = 1000;
        [obj addTarget:self action:@selector(startAnimaition) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

- (void)startAnimaition {
    self.resultModel = nil;
    [self callBack];
    
    self.playButton.userInteractionEnabled = NO;
    CGFloat turnAngle = 0;
    NSInteger randomNum = arc4random()%100;//控制概率
    NSInteger turnsNum = arc4random()%2+5;//控制圈数
    
    TTTurnItemModel *tmpModel = nil;
    NSString *string = nil;
    NSArray *array = nil;
    
    if (randomNum>=0 && randomNum<20) {//20%的概率
        array = [self.numberArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.type in %@",@[@(TTTurnType1)]]];
    } else if (randomNum>=20 && randomNum<40) {
        array = [self.numberArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.type in %@",@[@(TTTurnType2)]]];
    } else if (randomNum >=40 && randomNum<50) {
        array = [self.numberArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.type in %@",@[@(TTTurnType3)]]];
    } else {
        array = [self.numberArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.type in %@",@[@(TTTurnTypeNormal)]]];
    }
    
    if (array) {
        NSInteger count = array.count;
        NSInteger num = arc4random()%count;
        TTTurnItemModel *model = array[num];
        turnAngle = model.angle;
        NSInteger index = [self.numberArray indexOfObject:model];
        string = model.title;
        tmpModel = model;
    }
    
    CGFloat perAngle = M_PI/180.0;
    
    CGFloat offset = M_PI*2-turnAngle * perAngle;
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:360 * perAngle * turnsNum + offset];
    rotationAnimation.duration = 3.0f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.delegate = (id <CAAnimationDelegate>)self;
    //由快变慢
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotationAnimation.fillMode=kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [self.bgView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    self.resultModel = tmpModel;
}

- (void)callBack {
    if (self.block) {
        self.block(self.resultModel);
    }
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.playButton.userInteractionEnabled = YES;
    [self callBack];
}


@end
