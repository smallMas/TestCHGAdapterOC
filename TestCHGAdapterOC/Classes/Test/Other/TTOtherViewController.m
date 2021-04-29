//
//  TTOtherViewController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/2/2.
//

#import "TTOtherViewController.h"
#import <Photos/Photos.h>
#import "UITextView+TT.h"

#define kPingFangRegular    @"PingFangSC-Regular"

@interface TTOtherViewController ()
@property (nonatomic, copy) dispatch_block_t block;

@property (weak, nonatomic)   UIButton *rightBtn;
@property (weak, nonatomic)   UIButton *rightButton2;

@end

@implementation TTOtherViewController

static inline UIFont *_PingFangFont(NSString *fontName, CGFloat fontSize){
    if (fontName.length == 0) return nil;
    return [UIFont fontWithName:fontName size:fontSize];
}

+ (UIFont *)kl_systemFontOfSize:(CGFloat)fontSize {
    return _PingFangFont(kPingFangRegular, fontSize) ?: [UIFont systemFontOfSize:fontSize];
}

UIFont *kl_font(CGFloat fontSize){
    return [TTOtherViewController kl_systemFontOfSize:fontSize];
}


- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
    if (self.block) {
        dispatch_block_cancel(self.block);
    }
}

- (void)loadView {
    NSLog(@"%s",__FUNCTION__);
//    self.view = [UIView new];
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self testLabToLab];
//
//    [self testLabToBtn];
    
    
    [self.rightBtn setImage:[UIImage imageNamed:@"视频_循环播放"] forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"循环播放" forState:UIControlStateNormal];
    
    [self.rightButton2 setImage:[UIImage imageNamed:@"赠送好友"] forState:UIControlStateNormal];
    [self.rightButton2 setTitle:@"赠送好友" forState:UIControlStateNormal];
    
    
    CGFloat w1 = [self.rightBtn.titleLabel.text fsj_calculateWidthWithFont:self.rightBtn.titleLabel.font size:CGSizeMake(0, 21)];
    
    CGFloat w2 = [self.rightButton2.titleLabel.text fsj_calculateWidthWithFont:self.rightButton2.titleLabel.font size:CGSizeMake(0, 21)];
    [self.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(w1+22);
    }];
    [self.rightButton2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(w2+23);
    }];
    [self.rightBtn fsj_setIconInTopWithSpacing:0];
    [self.rightButton2 fsj_setIconInTopWithSpacing:0];
}

- (UIButton *)rightBtn{
    if (!_rightBtn) {
        UIButton *obj = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:_rightBtn = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeRV(-20);
            kMakeBV(-100);
            kMakeHV(44);
            kMakeWV(70);
        }];
        obj.titleLabel.font = kl_font(14);
        [obj setTitleColor:[UIColor fsj_colorWithHexString:@"#333333"] forState:(UIControlStateNormal)];
        obj.backgroundColor = [UIColor fsj_randomColor];
    }
    return _rightBtn;
}
- (UIButton *)rightButton2{
    if (!_rightButton2) {
        UIButton *obj = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:_rightButton2 = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeR(self.rightBtn.mas_left).offset(0);
            kMakeBV(-100);
            kMakeHV(44);
            kMakeWV(78);
        }];
        obj.titleLabel.font = kl_font(14);
        [obj setTitleColor:[UIColor fsj_colorWithHexString:@"#333333"] forState:(UIControlStateNormal)];
        obj.backgroundColor = [UIColor fsj_randomColor];
    }
    return _rightButton2;
}

- (void)testLabToLab {
    UILabel *label1 = [UILabel new];
    [self.view addSubview:label1];
    UILabel *label2 = [UILabel new];
    [self.view addSubview:label2];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(20);
//        make.top.mas_equalTo(20);
//        make.height.mas_equalTo(30);
        kMakeLV(20);
        kMakeTV(20);
        kMakeHV(30);
        make.right.lessThanOrEqualTo(label2.mas_left).offset(-10);
    }];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-20);
//        make.centerY.mas_equalTo(label1);
//        make.height.mas_equalTo(30);
        kMakeRV(-20);
        kMakeCenterY(label1);
        kMakeHV(30);
    }];
    [label2 setContentCompressionResistancePriority:UILayoutPriorityRequired
                                            forAxis:UILayoutConstraintAxisHorizontal];
    
    label1.text = @"阿迪六块腹肌阿里斯顿将阿里斯顿费拉达斯";
    
    label2.text = @"赠送好友";
}

- (void)testLabToBtn {
    UILabel *label1 = [UILabel new];
    [self.view addSubview:label1];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(70);
        make.height.mas_equalTo(30);
        make.right.lessThanOrEqualTo(btn.mas_left).offset(-10);
    }];
    
    [label1 setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
                                            forAxis:UILayoutConstraintAxisHorizontal];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(label1);
        make.height.mas_equalTo(30);
    }];
    [btn setContentCompressionResistancePriority:UILayoutPriorityRequired
                                            forAxis:UILayoutConstraintAxisHorizontal];
    
    label1.text = @"阿迪六块腹肌打蜡大量的时间啊地方看见阿里斯顿肌肤阿";
    
    [btn setTitle:@"赠送好友" forState:UIControlStateNormal];
}


@end
