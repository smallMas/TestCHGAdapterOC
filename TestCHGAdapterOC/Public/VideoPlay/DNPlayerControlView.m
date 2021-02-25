//
//  DNPlayerControlView.m
//  DnaerApp
//
//  Created by dnaer5 on 2020/5/20.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "DNPlayerControlView.h"
#import "DNPlayerNetworkErrView.h"
#import "AFNetworking.h"

@interface DNPlayerControlView()

@property (nonatomic, strong) UIActivityIndicatorView * activity;
@property (nonatomic, strong) DNPlayerNetworkErrView * networkErrView;
@property (nonatomic, strong) UIButton * playBtn;
@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, assign) AFNetworkReachabilityStatus networkStatus;//当前网络状态
@end

@implementation DNPlayerControlView

@synthesize player;

- (void)createUI {
    [super createUI];
    self.backgroundColor = UIColor.clearColor;
    [self addSubview:self.bgView];
    [self addSubview:self.activity];
    [self addSubview:self.networkErrView];
    [self addSubview:self.playBtn];
}



- (void)removeFromSuperview {
    [super removeFromSuperview];
}

- (void)layoutUI {
    [super layoutUI];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.activity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.networkErrView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30+12.67+9.33+20+14+10);
        make.center.equalTo(self); 
    }];
    
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(49);
        make.left.bottom.mas_equalTo(0);
    }];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = UIColor.clearColor;
//        _bgView.userInteractionEnabled = NO
        [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewTap:)]];
    }
    return _bgView;
}

-(void)bgViewTap:(id)sender {
    
}

- (DNPlayerNetworkErrView *)networkErrView {
    if (!_networkErrView) {
        _networkErrView = [DNPlayerNetworkErrView new];
        _networkErrView.hidden = YES;
        FSJ_WEAK_SELF
        _networkErrView.eventTransmissionBlock = ^id(id target, id params, NSInteger tag, CHGCallBack callBack) {
            FSJ_STRONG_SELF
            if ([target isKindOfClass:[DNPlayerNetworkErrView class]]) {
                if (tag == 0) {//重试
                    [self hiddenNetworkErr];
                    [self.player reTry];
                }
            }
            return nil;
        };
    }
    return _networkErrView;
}

- (UIActivityIndicatorView *)activity {
    if (!_activity) {
        _activity = [[UIActivityIndicatorView alloc] init];
        _activity.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        _activity.hidden = NO;
        _activity.frame = CGRectMake(0, 0, 40, 40);
        _activity.color = UIColor.whiteColor;
        _activity.layer.cornerRadius = 3;
        _activity.layer.masksToBounds = YES;
    }
    return _activity;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton new];
//        _playBtn.backgroundColor = UIColor.redColor;
        _playBtn.hidden = YES;
        [_playBtn setImage:[UIImage imageNamed:@"found_play"] forState:UIControlStateNormal];
        [_playBtn setImage:[UIImage imageNamed:@"found_play_suspended"] forState:UIControlStateSelected];
        [_playBtn addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

-(void)btnTap:(id)sender {
    [self startMonitoring];
    if (self.playBtn.selected) {
        self.playBtn.selected = NO;
        [self.player pause];
    } else {
        self.playBtn.selected = YES;
        [self.player play];
    }
    
}

- (void)playerStartLoad {
    self.playBtn.selected = YES;
    [self hiddenNetworkErr];
}

- (void)playerStartPlay {
    [self startMonitoring];
    self.playBtn.selected = YES;
}

- (void)playerPause {
    self.playBtn.selected = NO;
}

-(void)timeChangeCurDuration:(NSTimeInterval)curDuration duration:(NSTimeInterval)duration {
    NSLog(@"cv 时间变化：%f/%f",curDuration, duration);
}

- (void)isLoading:(BOOL)isLoading {
    self.activity.hidden = !isLoading;
    if (isLoading) {
        [self.activity startAnimating];
    } else {//显示加载动画
        [self.activity stopAnimating];
    }
}

- (void)playerItem:(AVPlayerItem*)playerItem status:(AVPlayerItemStatus)status {
    switch (status) {
       case AVPlayerItemStatusUnknown:
           NSLog(@"播放状态未知");
           break;
       case AVPlayerItemStatusReadyToPlay:
           NSLog(@"准备开始播放调用");
           [self playerStartPlay];
           break;
       case AVPlayerItemStatusFailed:
           [self playerPlayError:playerItem];
       break;
           
       default:
           break;
   }
}

-(void)playerPlayError:(AVPlayerItem *) playerItem {
    NSLog(@"播放失败的日志：%@",playerItem.error.userInfo[@"NSLocalizedDescription"]);
    //播放失败
    if (playerItem.error.domain == NSURLErrorDomain) {
        if (self.networkStatus == AFNetworkReachabilityStatusNotReachable) {//如果当前为无网络的状态则启动网络监听
            [self startMonitoring];
        }
        NSLog(@"网络错误");
        [self showNetworkErr];
    } else if (playerItem.error.domain == AVFoundationErrorDomain) {
        NSLog(@"播放错误");
    }
}

-(void)showNetworkErr{
    self.networkErrView.hidden = NO;
    self.bgView.backgroundColor = [UIColor fsj_colorWithHexString:@"#464646"];
    self.bgView.userInteractionEnabled = YES;
}


-(void)hiddenNetworkErr {
    self.networkErrView.hidden = YES;
    self.bgView.backgroundColor = UIColor.clearColor;
    self.bgView.userInteractionEnabled = NO;
}

/// 开始监听网络变化
-(void)startMonitoring {
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    FSJ_WEAK_SELF
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        FSJ_STRONG_SELF
        self.networkStatus = status;
        switch(status) {
            case AFNetworkReachabilityStatusUnknown:
                
                break;
            case AFNetworkReachabilityStatusNotReachable:
                //无网络
                
                break;

            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                NSLog(@"-------------wifi------------------");
                //当前是wifi网络
                [self hiddenNetworkErr];
                if (self.player.status == DNPlayerStatusError) {
                    [self.player reTry];
                }
                
            }
                break;

            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                [self hiddenNetworkErr];
                if (self.player.status == DNPlayerStatusError) {
                    [self.player reTry];
                }
            }
                break;
            default:
                break;
        }
    }];
    [mgr startMonitoring];

}


/// 停止监听网络变化
-(void)stopMonitoring {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

@end
