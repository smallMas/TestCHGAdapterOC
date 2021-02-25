//
//  DNPlayer.h
//  DnaerApp
//
//  Created by dnaer5 on 2020/5/19.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "DNBaseView.h"
#import <AVFoundation/AVFoundation.h>

@class DNPlayer;

NS_ASSUME_NONNULL_BEGIN


typedef enum : NSUInteger {
    DNPlayerStatusDefault,
    DNPlayerStatusLoading,      //数据加载中
    DNPlayerStatusPlay,         //播放中
    DNPlayerStatusPause,        //暂停
    DNPlayerStatusStop,         //停止
    DNPlayerStatusError         //播放错误
} DNPlayerStatus;


/// 播放器控制视图
@protocol DNPlayerControlViewProtocol <NSObject>

///播放器
@property (nonatomic, weak) DNPlayer *player;

/// 开始加载
-(void)playerStartLoad;

/// 播放
-(void)playerStartPlay;

/// 暂停
-(void)playerPause;

/// 时间发生变化
/// @param CurDuration 当前时间
/// @param duration 总共时间
-(void)timeChangeCurDuration:(NSTimeInterval)CurDuration duration:(NSTimeInterval)duration;

/// 播放器状态发生变化
/// @param playerItem playerItem description
/// @param status status description
- (void)playerItem:(AVPlayerItem*)playerItem status:(AVPlayerItemStatus)status;

/// 是否在进行IO加载（一般是网络请求）
/// @param isLoading isLoading description
- (void)isLoading:(BOOL)isLoading;

@end


@interface DNPlayer : DNBaseView

///描述
@property (nonatomic, strong) NSString *url;
///是否循环播放
@property (nonatomic, assign) BOOL cyclePlay;
///控制视图
@property (nonatomic, strong) UIView<DNPlayerControlViewProtocol> * controlView;

///播放器状态
@property (nonatomic, assign) DNPlayerStatus status;




@property (nonatomic, copy) void(^PlayerStartLoadBlock)(AVPlayer * player);

@property (nonatomic, copy) void(^PlayerPauseBlock)(AVPlayer * player);

@property (nonatomic, copy) void(^PlayerStartPlayBlock)(AVPlayer * player);

@property (nonatomic, copy) void(^PlayerPlayErrorBlock)(AVPlayer * player, NSError * err);

@property (nonatomic, copy) void(^MoviePlayDidEndBlock)(AVPlayer * player);

@property (nonatomic, copy) void(^PlayerItemTimeJumpedBlock)(AVPlayer * player);

@property (nonatomic, copy) void(^PlayerItemFailedToPlayToEndTimeBlock)(AVPlayer * player);

@property (nonatomic, copy) void(^PlayerItemPlaybackStalledBlock)(AVPlayer * player);

@property (nonatomic, copy) void(^PlayerItemNewAccessLogEntryBlock)(AVPlayer * player);

@property (nonatomic, copy) void(^PlayerItemNewErrorLogEntryBlock)(AVPlayer * player);

@property (nonatomic, copy) void(^PlayerItemFailedToPlayToEndTimeErrorBlock)(AVPlayer * player);

-(void)play;

-(void)pause;

-(void)reTry;

-(void)stop:(_Nullable CHGCallBack)callback;

@end

NS_ASSUME_NONNULL_END
