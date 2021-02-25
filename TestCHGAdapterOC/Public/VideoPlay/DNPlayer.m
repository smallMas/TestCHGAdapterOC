//
//  DNPlayer.m
//  DnaerApp
//
//  Created by dnaer5 on 2020/5/19.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "DNPlayer.h"

@interface DNPlayer()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer * playerLayer;

@property (nonatomic, strong) id timeObserve;

@property (nonatomic, strong) CADisplayLink * link;
@property (nonatomic, assign) NSTimeInterval lastTime;

@property (nonatomic, strong) UIActivityIndicatorView * activity;

@property (nonatomic, assign) BOOL isRemoveObserver;

@end

@implementation DNPlayer


-(void)buildUI {
    if (self.controlView) {
        [self addSubview:self.controlView];//添加控制视图
        [self.controlView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
}

-(void)reTry {
    [self create];
    [self.player play];
}

-(void)create {
    if (self.player) {
        FSJ_WEAK_SELF
        [self stop:^id(id data) {
            FSJ_STRONG_SELF
            [self initPlayer];
            return nil;
        }];
        return;
    }
    [self initPlayer];
}

-(void)initPlayer {
    NSURL * url = [NSURL URLWithString:self.url];// [KTVHTTPCache getFinalURLWithURL:self.url];
//    NSURL * url = [NSURL URLWithString:self.url];
    AVPlayerItem * playerItem = [AVPlayerItem playerItemWithURL:url];
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:NULL];
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:NULL];
    
    //用于处理视频加载时候的loading状态
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(upadte)];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    self.player.volume = 0;
    [self addObserver];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.playerLayer.frame = self.frame;
    [self.layer addSublayer:self.playerLayer];
    [self buildUI];
}


- (void)setUrl:(NSString *)url {
    _url = url;
    [self create];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.playerLayer.frame = frame;
}

-(void)addObserver {
    self.isRemoveObserver = NO;
    //播放到末尾
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
    //播放时间发生变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemTimeJumped:) name:AVPlayerItemTimeJumpedNotification object:self.player.currentItem];
    //未能播放到其结束时间就中断时被调用
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemFailedToPlayToEndTime:) name:AVPlayerItemFailedToPlayToEndTimeNotification object:self.player.currentItem];
    //播放器暂停的时候
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemPlaybackStalled:) name:AVPlayerItemPlaybackStalledNotification object:self.player.currentItem];
    //在新的访问日志被添加条目时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemNewAccessLogEntry:) name:AVPlayerItemNewAccessLogEntryNotification object:self.player.currentItem];
    //在新的错误日志被添加条目时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemNewErrorLogEntry:) name:AVPlayerItemNewErrorLogEntryNotification object:self.player.currentItem];
    //视频无法播放
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemFailedToPlayToEndTimeError:) name:AVPlayerItemFailedToPlayToEndTimeErrorKey object:self.player.currentItem];
    //实时监听播放状态
    FSJ_WEAK_SELF
    self.timeObserve = [self.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1,1) queue:nil usingBlock:^(CMTime time) {
        FSJ_STRONG_SELF
        [self timeChange:time];
    }];
}

-(void)removeObserver {
    if (!self.isRemoveObserver) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemTimeJumpedNotification object:self.player.currentItem];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemFailedToPlayToEndTimeNotification object:self.player.currentItem];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemPlaybackStalledNotification object:self.player.currentItem];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemNewAccessLogEntryNotification object:self.player.currentItem];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemNewErrorLogEntryNotification object:self.player.currentItem];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemFailedToPlayToEndTimeErrorKey object:self.player.currentItem];
        [self.player removeTimeObserver:self.timeObserve];
        self.isRemoveObserver = YES;
        NSLog(@"播放器移除观察");
    } else {
        NSLog(@"播放器已经移除过观察，不需要再移除");
    }
}

/// 时间发生变化
/// @param time time description
-(void)timeChange:(CMTime)time {
    AVPlayerItem* currentItem = self.player.currentItem;
    NSArray* loadedRanges = currentItem.seekableTimeRanges;
    if (loadedRanges.count > 0){
        CMTimeRange range = [[loadedRanges objectAtIndex:0] CMTimeRangeValue];
        NSTimeInterval duration = CMTimeGetSeconds(range.start) + CMTimeGetSeconds(range.duration);
        // 当前播放总时间
        NSTimeInterval curDuration = CMTimeGetSeconds(time);
        [self.controlView timeChangeCurDuration:curDuration duration:duration];
    }
}

- (void)setControlView:(UIView<DNPlayerControlViewProtocol> *)controlView {
    _controlView = controlView;
    _controlView.player = self;
}

//更新方法
- (void)upadte {
    NSTimeInterval current = CMTimeGetSeconds(self.player.currentTime);
    [self.controlView isLoading:current == self.lastTime && self.status  == DNPlayerStatusPlay];
    self.lastTime = current;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        if ([object isKindOfClass:[AVPlayerItem class]]) {
            AVPlayerItem * playerItem = object;
            NSLog(@"DNPlayer  kvo监听的播放器的状态：%ld",(long)playerItem.status);
            switch (playerItem.status) {
                case AVPlayerItemStatusUnknown:
                    NSLog(@"DNPlayer  播放状态未知");
                    break;
                case AVPlayerItemStatusReadyToPlay:
                    NSLog(@"DNPlayer  准备开始播放调用");
                    [self playerStartPlay];
                    break;
                case AVPlayerItemStatusFailed:
                    [self playerPlayError:playerItem];
                break;
                    
                default:
                    break;
            }
            [self.controlView playerItem:playerItem status:playerItem.status];
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval p = [self availableDurationWithplayerItem:self.player.currentItem];
        NSLog(@"DNPlayer   ddd p:%.f",p);
    }
}

-(void)playerPlayError:(AVPlayerItem *) playerItem {
    self.status = DNPlayerStatusError;
    if (self.PlayerPlayErrorBlock) {
        self.PlayerPlayErrorBlock(self.player, playerItem.error);
    }
}

/// 开始加载
-(void)playerStartLoad {
    self.status = DNPlayerStatusLoading;
    if (self.PlayerStartLoadBlock) {
        self.PlayerStartLoadBlock(self.player);
    }
}

/// 开始播放
-(void)playerStartPlay {
    if (self.PlayerStartPlayBlock) {
        self.PlayerStartPlayBlock(self.player);
    }
}

///获取视频当前的缓冲进度
- (NSTimeInterval)availableDurationWithplayerItem:(AVPlayerItem *)playerItem
{
    NSArray *loadedTimeRanges = [playerItem loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    NSTimeInterval startSeconds = CMTimeGetSeconds(timeRange.start);
    NSTimeInterval durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

/// 播放完成
/// @param notification notification description
-(void)moviePlayDidEnd:(NSNotification*)notification {
    if (self.MoviePlayDidEndBlock) {
        self.MoviePlayDidEndBlock(self.player);
    }
    if (self.cyclePlay) {
        if (self.player.currentItem == notification.object) {
            [self rePlay];
        }
    }
}

-(void)playerItemTimeJumped:(NSNotification*)notification {
    if (notification.object == self.player) {
        
    }
    if (self.PlayerItemTimeJumpedBlock) {
        self.PlayerItemTimeJumpedBlock(self.player);
    }
}

/// 未能播放到其结束时间就中断时被调用
/// @param notification
-(void)playerItemFailedToPlayToEndTime:(NSNotification*)notification {
    if (self.PlayerItemFailedToPlayToEndTimeBlock) {
        self.PlayerItemFailedToPlayToEndTimeBlock(self.player);
    }
}

/// 暂停播放
/// @param notification notification description
-(void)playerItemPlaybackStalled:(NSNotification*)notification {
    if (self.PlayerItemPlaybackStalledBlock) {
        self.PlayerItemPlaybackStalledBlock(self.player);
    }
}

-(void)playerItemNewAccessLogEntry:(NSNotification*)notification {
    if (self.PlayerItemNewAccessLogEntryBlock) {
        self.PlayerItemNewAccessLogEntryBlock(self.player);
    }
}

/// 在新的错误日志被添加条目时
/// @param notification notification description
-(void)playerItemNewErrorLogEntry:(NSNotification*)notification {
    NSLog(@"DNPlayer  在新的错误日志被添加条目时");
    if (self.PlayerItemNewErrorLogEntryBlock) {
        self.PlayerItemNewErrorLogEntryBlock(self.player);
    }
}

-(void)playerItemFailedToPlayToEndTimeError:(NSNotification*)notification {
    NSLog(@"DNPlayer  视频无法播放");
    NSError *error = notification.userInfo[AVPlayerItemFailedToPlayToEndTimeErrorKey];
    NSLog(@"DNPlayer  发生错误：%@",error);
    if (self.PlayerItemFailedToPlayToEndTimeErrorBlock) {
        self.PlayerItemFailedToPlayToEndTimeErrorBlock(self.player);
    }
}

-(void)play {
    NSLog(@"DNPlayer  播放控制： 调用播放");
    [self playerStartLoad];
    self.status = DNPlayerStatusPlay;
    [self.player play];
}

/// 重新播放
-(void)rePlay {
    NSLog(@"DNPlayer  播放控制： 调用重新播放");
    [self.player.currentItem seekToTime:kCMTimeZero];
    [self play];
}

-(void)pause {
    NSLog(@"DNPlayer  播放控制： 调用暂停播放");
    self.status = DNPlayerStatusPause;
    [self.player pause];
    if (self.PlayerPauseBlock) {
        self.PlayerPauseBlock(self.player);
    }
}

-(void)stop:(_Nullable CHGCallBack)callback {
    NSLog(@"DNPlayer  播放控制： 调用停止播放");
    self.status = DNPlayerStatusStop;
    self.MoviePlayDidEndBlock ? self.MoviePlayDidEndBlock(self.player) : nil;
    [self.player pause];
    @try {
        [self.player.currentItem removeObserver:self forKeyPath:@"status" context:nil];
        [self.player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    } @catch (NSException *exception) {
        NSLog(@"发生了异常：%@",exception.description);
    } @finally {
        NSLog(@"播放器停止播放了，finally");
        [self removeObserver];
        [self.playerLayer removeFromSuperlayer];
        self.player = nil;
        callback ? callback(nil) : nil;
    }
}

@end
