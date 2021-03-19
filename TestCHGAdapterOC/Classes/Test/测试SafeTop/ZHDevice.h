//
//  ZHDevice.h
//  
//
//  Created by mac book on 2020/4/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 设备相关
#define IS_Phone          (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_Pad            (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//iPhone刘海屏
#define IS_IPhoneX         ([ZHDevice is_iPhoneX])
//iPad全面屏
#define IS_FULLSCREEN_PAD  ([ZHDevice is_FullScreenIpad])

NSString* machine(void);

NSDictionary *systemInfo(void);

NSString * machineModelName(void);

@interface ZHDevice : NSObject

+ (BOOL)is_iPhoneX;
+ (BOOL)is_FullScreenIpad;

/** 获取🔋电量百分比 */
+ (double)getCurrentBatteryLevel;
//获取Wifi信号强度
+ (int)getNetSignalStrength:(BOOL)isWifi;
+ (BOOL)canGetNetSignalStrength:(BOOL)isWifi;
+ (UIView *)getStatusBar;
+ (UIView *)getStatusForegroundView;//iOS13 无法获得当前状态栏

@end

NS_ASSUME_NONNULL_END
