//
//  FSJAudioPlayer.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/4/20.
//

#import "FSJAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

#define FSJA_TIME_BASE 1000000

@implementation FSJAudioPlayerManager

+ (instancetype)shareInstance {
    static FSJAudioPlayerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [FSJAudioPlayerManager new];
    });
    return manager;
}

- (void)play:(FSJAudioPlayer *)player {
    if ([FSJAudioPlayerManager shareInstance].currentAudioPlayer != player) {
        [[FSJAudioPlayerManager shareInstance].currentAudioPlayer pause];
        [FSJAudioPlayerManager shareInstance].currentAudioPlayer = player;
    }
    if (player.state != FsjAudioStatePlay) {
        [player play];
    }
}

- (void)pause {
    FSJAudioPlayer *p = [FSJAudioPlayerManager shareInstance].currentAudioPlayer;
    if (p) {
        [p pause];
    }
}

@end

@interface FSJAudioPlayer ()

@property (nonatomic, strong) AVPlayer *avPlayer;
@property (nonatomic, assign) float duration;

@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) id observer;
@property (strong, nonatomic) NSString *urlString;

@end

@implementation FSJAudioPlayer

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (_avPlayer && self.observer) {
        [self.avPlayer removeTimeObserver:self.observer];
    }
    NSLog(@"%s",__func__);
}

- (instancetype)init {
    if (self = [super init]) {
        _muted = NO;
        self.avPlayer = [[AVPlayer alloc] init];
    }
    return self;
}

- (void)setUrlString:(NSString *)urlString {
    _urlString = urlString;
    NSURL *playerurl = nil;
    if ([urlString containsString:@"https://"]||[urlString containsString:@"http://"]||[urlString containsString:@"ipod-library://"]) {
        playerurl = [NSURL URLWithString:urlString];
    } else {
        playerurl = [NSURL fileURLWithPath:urlString];
    }
    AVAsset *asset = [AVAsset assetWithURL:playerurl];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    self.playerItem = [AVPlayerItem playerItemWithURL:playerurl];
    [self.avPlayer replaceCurrentItemWithPlayerItem:self.playerItem];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    self.avPlayer.muted = _muted;
    
    self.duration = CMTimeGetSeconds(asset.duration);
    //设置一秒10次回调
    //如果有观察者移除
    if (self.observer) {
        [self.avPlayer removeTimeObserver:self.observer];
    }
    __weak typeof(self) weakSelf = self;
    self.observer = [self.avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 10) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        Float64 currentSeconds = CMTimeGetSeconds(time);
        Float64 duration = CMTimeGetSeconds(weakSelf.playerItem.duration);
        CGFloat progress = duration==0?0:currentSeconds/(CGFloat)duration;
        if (weakSelf.duration != 0 && weakSelf.progressBlock) {
            weakSelf.progressBlock(currentSeconds, duration, progress);
        }
    }];
}

- (float)currentTime {
    return CMTimeGetSeconds(self.avPlayer.currentTime);
}

- (void)seekToTime:(float)time {
    [self.avPlayer seekToTime:CMTimeMake((int64_t)(time*FSJA_TIME_BASE), FSJA_TIME_BASE)];
}

- (void)play {
    [self.avPlayer play];
    self.state = FsjAudioStatePlay;
}

- (void)pause {
    if (self.state == FsjAudioStatePlay) {
        if (_avPlayer) {
            [self.avPlayer pause];
        }
    }
    self.state = FsjAudioStateStop;
}

- (void)setState:(FsjAudioState)state {
    _state = state;
    if (self.stateBlock) {
        self.stateBlock(state, self.urlString);
    }
}

- (void)rate:(float)rate {
    self.avPlayer.rate = rate;
}

- (void)setMuted:(BOOL)muted {
    _muted = muted;
    self.avPlayer.muted = muted;
}

- (void)playbackFinished {
    if (self.playEndBlock) {
        self.playEndBlock();
    }
    self.state = FsjAudioStateEnd;
}

@end
