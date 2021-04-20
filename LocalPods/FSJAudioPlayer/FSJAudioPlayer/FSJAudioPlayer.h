//
//  FSJAudioPlayer.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/4/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class FSJAudioPlayer;
@interface FSJAudioPlayerManager : NSObject
@property (strong, nonatomic) FSJAudioPlayer *currentAudioPlayer;
+ (instancetype)shareInstance;
- (void)play:(FSJAudioPlayer *)player;
- (void)pause;
@end


typedef NS_ENUM(NSInteger, FsjAudioState) {
    FsjAudioStateNone,
    FsjAudioStatePlay,
    FsjAudioStateStop,
    FsjAudioStateEnd
};
typedef void (^ AuPlayVoidBlock)(void);
typedef void (^ AuStateBlock)(FsjAudioState state, NSString *url);
typedef void (^ AuPlayProgressBlock)(Float64 current, Float64 duration, CGFloat progress);

@interface FSJAudioPlayer : NSObject

@property (assign, nonatomic, readonly) float duration;
@property (assign, nonatomic, readonly) float currentTime;
@property (assign, nonatomic, readonly) FsjAudioState state;

// 是否静音
@property (assign, nonatomic) BOOL muted;

@property (copy, nonatomic) AuPlayVoidBlock playEndBlock;
@property (copy, nonatomic) AuStateBlock stateBlock;
@property (copy, nonatomic) AuPlayProgressBlock progressBlock;

- (void)setUrlString:(NSString *)urlString;
- (void)seekToTime:(float)time;
- (void)play;
- (void)pause;
- (void)rate:(float)rate;
@end

NS_ASSUME_NONNULL_END
