//
//  DNPlayerNetworkErrView.m
//  DnaerApp
//
//  Created by dnaer5 on 2020/5/19.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "DNPlayerNetworkErrView.h"

@interface DNPlayerNetworkErrView()

@property (nonatomic, strong) UILabel * title;
@property (nonatomic, strong) UIButton * reTryBtn;
@property (nonatomic, strong) UIView * bgView;

@end

@implementation DNPlayerNetworkErrView

-(void)createUI {
    [super createUI];
    self.backgroundColor = UIColor.clearColor;
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.bgView];
    [self addSubview:self.title];
    [self addSubview:self.reTryBtn];
}

-(void)layoutUI {
    [super layoutUI];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
    }];
    
    [self.reTryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.title.mas_bottom).offset(20);
        make.height.mas_equalTo(30+12.67+9.33);
    }];
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    [self.reTryBtn setIconInTopWithSpacing:9.33];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewTap)]];
    }
    return _bgView;
}

-(void)bgViewTap {
    
}

- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
        _title.font = [UIFont boldSystemFontOfSize:14];
        _title.numberOfLines = 0;
        _title.textAlignment = NSTextAlignmentCenter;
        _title.text = @"网络不可用，请检查网络";
        _title.textColor = UIColor.whiteColor;
        _title.userInteractionEnabled = YES;
        [_title addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleTap)]];
    }
    return _title;
}

-(void)titleTap {
    
}

- (UIButton *)reTryBtn {
    if (!_reTryBtn) {
        _reTryBtn = [UIButton new];
        [_reTryBtn setImage:[UIImage imageNamed:@"dnplayer_retry"] forState:UIControlStateNormal];
        [_reTryBtn setTitle:@"重试" forState:UIControlStateNormal];
        [_reTryBtn addTarget:self action:@selector(reTryBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reTryBtn;
}

-(void)reTryBtnTap:(id)sender {
    if (self.eventTransmissionBlock) {
        self.eventTransmissionBlock(self, sender, 0, nil);
    }
}

@end
