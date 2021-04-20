//
//  TTTestAudioViewController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/2/26.
//

#import "TTTestAudioViewController.h"
#import <FSJAudioPlayer/FSJAudioPlayer.h>
@interface TTTestAudioViewController ()
@property (strong, nonatomic) FSJAudioPlayer *player;

@property (strong, nonatomic) UIButton *btn1;
@property (strong, nonatomic) UIButton *btn2;
@end

@implementation TTTestAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // http://music.163.com/song/media/outer/url?id=447925558.mp3
    // https://super-img.oss-cn-beijing.aliyuncs.com/5722391613987997279.mp3
    // http://img.klxt.com/8703321614087760384.pcm
    // http://img.klxt.com/6172561614250910736.mp3
    
    [self btn1];
    [self btn2];
    
    NSString *url = @"http://img.klxt.com/6172561614250910736.mp3";
    [self.player setUrlString:url];
}

- (UIButton *)btn1 {
    if (!_btn1) {
        UIButton *obj = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_btn1 = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeWHV(100, 40);
            kMakeCenterXV(0);
            kMakeTV(20);
        }];
        [obj setTitle:@"播放" forState:UIControlStateNormal];
        [obj setBackgroundColor:[UIColor fsj_randomColor]];
        obj.fsj_action = fMsg(@"clickPlay");
    }
    return _btn1;
}

- (UIButton *)btn2 {
    if (!_btn2) {
        UIButton *obj = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_btn2 = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeWHV(100, 40);
            kMakeCenterXV(0);
            kMakeT(self.btn1.mas_bottom).offset(20);
        }];
        [obj setTitle:@"暂停" forState:UIControlStateNormal];
        [obj setBackgroundColor:[UIColor fsj_randomColor]];
        obj.fsj_action = fMsg(@"clickPause");
    }
    return _btn2;
}

- (FSJAudioPlayer *)player {
    if (!_player) {
        FSJAudioPlayer *obj = [FSJAudioPlayer new];
        _player = obj;
        obj.progressBlock = ^(Float64 current, Float64 duration, CGFloat progress) {
            NSLog(@"播放进度 : %f current : %f duration : %f",progress,current,duration);
        };
    }
    return _player;
}

- (void)clickPlay {
    [[FSJAudioPlayerManager shareInstance] play:self.player];
}

- (void)clickPause {
    [[FSJAudioPlayerManager shareInstance] pause];
}

@end
