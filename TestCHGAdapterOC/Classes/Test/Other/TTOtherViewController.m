//
//  TTOtherViewController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/2/2.
//

#import "TTOtherViewController.h"
#import <Photos/Photos.h>
#import "UITextView+TT.h"

@interface TTOtherViewController ()
@property (nonatomic, copy) dispatch_block_t block;
@end

@implementation TTOtherViewController

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
    
    [self testLabToLab];
    
    [self testLabToBtn];
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
