//
//  ZHDevice.m
//  
//
//  Created by mac book on 2020/4/29.
//

#import "ZHDevice.h"
#include "sys/sysctl.h"
//#import "KLCacheHandle.h"
#import "SceneDelegate.h"

static BOOL iPhoneXSeries           = NO;

static BOOL ipx_flag                = NO;

static BOOL is_fullscreen_iPad      = NO;

NSString *deviceResolution(){
    if ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]) {
        CGSize size_screen = [UIScreen mainScreen].nativeBounds.size;
        return [NSString stringWithFormat:@"%.f*%.f",size_screen.width, size_screen.height];
    }
    CGRect rect_screen = [[UIScreen mainScreen] bounds];
    CGSize size_screen = rect_screen.size;
    
    //获得scale：
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    
    return [NSString stringWithFormat:@"%.f*%.f",size_screen.width*scale_screen,size_screen.height*scale_screen];
}

NSString* machine()
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char* name = (char*)malloc(size);
    sysctlbyname("hw.machine", name, &size, NULL, 0);
    NSString *machine = [[NSString alloc] initWithCString:(const char*)name
                                                 encoding:NSASCIIStringEncoding];
    free(name);
    return machine;
}

NSDictionary *systemInfo(){
//    //系统运行参数
//    NSString *net =  [KLDataCenter shareInstance].currentTelephonyNet == TELEPHONY_NET_WIFI ? @"WIFI":@"DATACONNECT";
//
//    NSDictionary* sysEnvDic = @{@"os_version":app_systerm_version,
//                                @"os_name":[[UIDevice currentDevice] systemName],
//                                @"network":net};
//
//    //硬件参数
//    NSDictionary* hardWareDic = @{@"model":machine(),
//                                  @"resolution":deviceResolution(),
//                                  @"dev_id":[KLDataCenter shareInstance].UDID,
//                                  @"memory":freeDiskSpace(),
//                                  @"storage":totalDiskSpace()};
//
//    //app运行参数
//    NSString*cacheSize = [NSString stringWithFormat:@"%.1f M",calcureCache()/1024/1024];
//
//    NSString *shortVersion = app_version;
//    NSDictionary* appEnvDic = @{@"app_version":shortVersion,
//                                @"cache_size":cacheSize};
//
//    return @{@"sys_env":sysEnvDic,
//             @"hardware":hardWareDic,
//             @"app_env":appEnvDic};
    return @{};
}


NSString *machineModel(void){
    static dispatch_once_t one;
    static NSString *model;
    dispatch_once(&one, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        model = [NSString stringWithUTF8String:machine];
        free(machine);
    });
    return model;
}

NSString *machineModelName(void){
    static dispatch_once_t one;
    static NSString *name;
    dispatch_once(&one, ^{
        NSString *model = machineModel();
        if (!model) return;
        NSDictionary *dic = @{@"iPod1,1":@"iPod Touch 1",
                              @"iPod2,1":@"iPod Touch 2",
                              @"iPod3,1":@"iPod Touch 3",
                              @"iPod4,1":@"iPod Touch 4",
                              @"iPod5,1":@"iPod Touch 5",
                              @"iPod7,1":@"iPod Touch 6",
                              
                              @"iPhone1,1":@"iPhone",
                              @"iPhone1,2":@"iPhone 3g",
                              @"iPhone2,1":@"iPhone 3gs",
                              @"iPhone3,1":@"iPhone 4",
                              @"iPhone3,2":@"iPhone 4",
                              @"iPhone3,3":@"iPhone 4",
                              @"iPhone4,1":@"iPhone 4s",
                              @"iPhone5,1":@"iPhone 5",
                              @"iPhone5,2":@"iPhone 5",
                              @"iPhone5,3":@"iPhone 5c",
                              @"iPhone5,4":@"iPhone 5c",
                              @"iPhone6,1":@"iPhone 5s",
                              @"iPhone6,2":@"iPhone 5s",
                              @"iPhone7,2":@"iPhone 6",
                              @"iPhone7,1":@"iPhone 6 Plus",
                              @"iPhone8,1":@"iPhone 6s",
                              @"iPhone8,2":@"iPhone 6s Plus",
                              @"iPhone8,4":@"iPhone SE",
                              @"iPhone9,1":@"iPhone 7",
                              @"iPhone9,3":@"iPhone 7",
                              @"iPhone9,2":@"iPhone 7 Plus",
                              @"iPhone9,4":@"iPhone 7 Plus",
                              @"iPhone10,1":@"iPhone 8",
                              @"iPhone10,4":@"iPhone 8",
                              @"iPhone10,2":@"iPhone 8 Plus",
                              @"iPhone10,5":@"iPhone 8 Plus",
                              @"iPhone10,3":@"iPhone X",
                              @"iPhone10,6":@"iPhone X",
                              @"iPhone11,2":@"iPhone XS",
                              @"iPhone11,4":@"iPhone XS Max",
                              @"iPhone11,6":@"iPhone XS Max",
                              @"iPhone11,8":@"iPhone XR",
                              @"iPhone12,1":@"iPhone 11",
                              @"iPhone12,3":@"iPhone 11 Pro",
                              @"iPhone12,5":@"iPhone 11 Pro Max",


                              @"iPad1,1":@"iPad 1",
                              @"iPad2,1":@"iPad 2",
                              @"iPad2,2":@"iPad 2",
                              @"iPad2,3":@"iPad 2",
                              @"iPad2,4":@"iPad 2",
                              @"iPad3,1":@"iPad 3",
                              @"iPad3,2":@"iPad 3",
                              @"iPad3,3":@"iPad 3",
                              @"iPad3,4":@"iPad 4",
                              @"iPad3,5":@"iPad 4",
                              @"iPad3,6":@"iPad 4",
                              @"iPad4,1":@"iPad Air",
                              @"iPad4,2":@"iPad Air",
                              @"iPad4,3":@"iPad Air",
                              @"iPad5,3":@"iPad Air 2",
                              @"iPad5,4":@"iPad Air 2",
                              @"iPad2,5":@"iPad Mini",
                              @"iPad2,6":@"iPad Mini",
                              @"iPad2,7":@"iPad Mini",
                              @"iPad4,4":@"iPad Mini 2",
                              @"iPad4,5":@"iPad Mini 2",
                              @"iPad4,6":@"iPad Mini 2",
                              @"iPad4,7":@"iPad Mini 3",
                              @"iPad4,8":@"iPad Mini 3",
                              @"iPad4,9":@"iPad Mini 3",
                              @"iPad5,1":@"iPad Mini 4",
                              @"iPad5,2":@"iPad Mini 4",
                              @"iPad6,3":@"iPad Pro 9.7",
                              @"iPad6,4":@"iPad Pro 9.7",
                              @"iPad6,7":@"iPad Pro 12.9",
                              @"iPad6,8":@"iPad Pro 12.9",
                              @"iPad6,11":@"iPad 5",
                              @"iPad6,12":@"iPad 5",
                              @"iPad7,1":@"iPad Pro 12.9",
                              @"iPad7,2":@"iPad Pro 12.9",
                              @"iPad7,3":@"iPad Pro 10.5",
                              @"iPad7,4":@"iPad Pro 10.5",
                              @"iPad7,5":@"iPad 6",
                              @"iPad7,6":@"iPad 6",
                              @"iPad8,1":@"iPad Pro 11",
                              @"iPad8,2":@"iPad Pro 11",
                              @"iPad8,3":@"iPad Pro 11",
                              @"iPad8,4":@"iPad Pro 11",
                              @"iPad8,5":@"iPad Pro 12.9",
                              @"iPad8,6":@"iPad Pro 12.9",
                              @"iPad8,7":@"iPad Pro 12.9",
                              @"iPad8,8":@"iPad Pro 12.9",
                              @"iPad8,9":@"iPad Pro 11吋",
                              @"iPad8,10":@"iPad Pro 11吋",
                              @"iPad8,11":@"iPad Pro 12.9吋",
                              @"iPad8,12":@"iPad Pro 12.9吋",

                              @"AppleTV2,1":@"Apple TV 2",
                              @"AppleTV3,1":@"Apple TV 3",
                              @"AppleTV3,2":@"Apple TV 3",
                              @"AppleTV5,3":@"Apple TV 4",
                              @"AppleTV6,2":@"Apple TV 4K",
                              @"i386" : @"Simulator x86",
                              @"x86_64" : @"Simulator x64"};
        name = dic[model];
        if (!name) name = model;
    });
    return name;
}

@implementation ZHDevice

+ (BOOL)IS_IPhoneXSeriesDevice{
    if (ipx_flag) {return iPhoneXSeries;}
    if (@available(iOS 11.0, *)) {
        NSArray *array =[[[UIApplication sharedApplication] connectedScenes] allObjects];
        UIWindowScene *windowScene = (UIWindowScene *)array[0];
        SceneDelegate *delegate =(SceneDelegate *)windowScene.delegate;
        
//        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        UIWindow *window = delegate.window;
        if (window) {ipx_flag = YES;}
        if (!window) {window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];}
        CGFloat iPhoneNotchDirectionSafeAreaInsets = 0;
        UIEdgeInsets safeAreaInsets = window.safeAreaInsets;
        switch ([UIApplication sharedApplication].statusBarOrientation) {
            case UIInterfaceOrientationPortrait:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.top;
                is_fullscreen_iPad  =   (IS_Pad && safeAreaInsets.bottom > 0);
            }
                break;
            case UIInterfaceOrientationLandscapeLeft:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.left;
                is_fullscreen_iPad  =   (IS_Pad && safeAreaInsets.right > 0);
            }
                break;
            case UIInterfaceOrientationLandscapeRight:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.right;
                is_fullscreen_iPad  =   (IS_Pad && safeAreaInsets.left > 0);
            }
                break;
            case UIInterfaceOrientationPortraitUpsideDown:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.bottom;
                is_fullscreen_iPad  =   (IS_Pad && safeAreaInsets.top > 0);
            }
                break;
            default:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.top;
                is_fullscreen_iPad  =   (IS_Pad && safeAreaInsets.bottom > 0);
            }
                break;
        }
        iPhoneXSeries = (iPhoneNotchDirectionSafeAreaInsets > 20);
    }
    return iPhoneXSeries;
}

+ (BOOL)is_iPhoneX {
    return [self IS_IPhoneXSeriesDevice] && !IS_Pad;
}
+ (BOOL)is_FullScreenIpad{
    if (!ipx_flag) {[self IS_IPhoneXSeriesDevice];}
    return is_fullscreen_iPad;
}

#pragma mark -获取电量
+ (double)getCurrentBatteryLevel{
    if(![UIDevice currentDevice].batteryMonitoringEnabled){
        [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    }
    return [UIDevice currentDevice].batteryLevel;
}

static int canGetNetSignalStrengthWifiFlag = 0;
static int canGetNetSignalStrengthFlag = 0;
static BOOL ipadPro10 = FALSE;
+ (BOOL)canGetNetSignalStrength:(BOOL)isWifi{
    if(isWifi){
        if(canGetNetSignalStrengthWifiFlag == 2){
            return YES;
        }else if (canGetNetSignalStrengthWifiFlag == 1){
            return NO;
        }
    }else{
        if(canGetNetSignalStrengthFlag == 2){
            return YES;
        }else if (canGetNetSignalStrengthFlag == 1){
            return NO;
        }
    }
    
       if (@available(iOS 13.0, *)) {
           UIApplication *appl = [UIApplication sharedApplication];
                   UIWindow *window = appl.keyWindow;
                   UIStatusBarManager *statusBarManager = window.windowScene.statusBarManager;
                   id statusBar = nil;
           #pragma clang diagnostic push
           #pragma clang diagnostic ignored "-Wundeclared-selector"
                   if ([statusBarManager respondsToSelector:@selector(createLocalStatusBar)]) {
                       UIView *localStatusBar = [statusBarManager performSelector:@selector(createLocalStatusBar)];
                       if ([localStatusBar respondsToSelector:@selector(statusBar)]) {
                           statusBar = [localStatusBar performSelector:@selector(statusBar)];
                       }
                   }
           #pragma clang diagnostic pop
           if (statusBar) {
               //NSLog(@"statusBar = %p",statusBar);
               if([ZHDevice getVariableWithClass:statusBar varName:@"statusBar"]){
                    id statusBarView = [statusBar valueForKeyPath:@"statusBar"];
                   if([ZHDevice getVariableWithClass:statusBarView varName:@"currentData"]){
                       id currentData = [statusBarView valueForKeyPath:@"currentData"];
                       if(isWifi){
                           if([ZHDevice getVariableWithClass:currentData varName:@"wifiEntry"]){
                               id wifiEntry = [currentData valueForKeyPath:@"wifiEntry"];
                               if([ZHDevice getVariableWithClass:wifiEntry varName:@"displayValue"]){
                                   canGetNetSignalStrengthWifiFlag = 2;
                                   return YES;
                               }
                           }
                       }else{
                           if([ZHDevice getVariableWithClass:currentData varName:@"cellularEntry"]){
                                id cellularEntry = [currentData valueForKeyPath:@"cellularEntry"];
                                if([ZHDevice getVariableWithClass:cellularEntry varName:@"displayValue"]){
                                    canGetNetSignalStrengthFlag = 2;
                                    return YES;
                                }
                           }
                       }
                   }
               }
            }
           if(isWifi){
               canGetNetSignalStrengthWifiFlag = 1;
               return NO;
           }else{
               canGetNetSignalStrengthFlag = 1;
               return NO;
           }
       }else{
           if (IS_IPhoneX||IS_FULLSCREEN_PAD) {
                id statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
                if(statusBar){
                    if([ZHDevice getVariableWithClass:statusBar varName:@"statusBar"]){
                    id statusBarView = [statusBar valueForKey:@"statusBar"];

                           if(statusBarView){
                    
                                if([ZHDevice getVariableWithClass:statusBarView varName:@"foregroundView"]){
                                       id foregroundView = [statusBarView valueForKey:@"foregroundView"];
                                    
                                       if([foregroundView isKindOfClass:UIView.class]){
                                           NSArray *arr = [(UIView *)foregroundView subviews];
                                           if(IS_FULLSCREEN_PAD){
                                                if(isWifi){
                                                   for (id subview in arr) {
                                                           if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarWifiSignalView")]) {
                                                               if([ZHDevice getVariableWithClass:subview varName:@"numberOfActiveBars"]){
                                                                   canGetNetSignalStrengthWifiFlag = 2;
                                                                   return YES;
                                                               }
                                                           }
                                                    }
                                                }
                                            }else{
                                                if([arr count]>2){
                                                       NSArray *subviews = [arr[2] subviews];
                                                       for (id subview in subviews) {
                                                           if(isWifi){
                                                               if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarWifiSignalView")]) {
                                                                   if([ZHDevice getVariableWithClass:subview varName:@"numberOfActiveBars"]){
                                                                       canGetNetSignalStrengthWifiFlag = 2;
                                                                       return YES;
                                                                   }
                                                               }
                                                           }else{
                                                               if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarPersistentAnimationView")]) {
                                                                        if([ZHDevice getVariableWithClass:subview varName:@"numberOfActiveBars"]){
                                                                            canGetNetSignalStrengthFlag = 2;
                                                                            return YES;
                                                                        }
                                                                     }
                                                           }
                                                                  
                                                      }
                                                 }
                                           }
                                        
                                        }
                                   }
                            }
                       }
                  }
                  if(isWifi){
                       canGetNetSignalStrengthWifiFlag = 1;
                       return NO;
                  }else{
                       canGetNetSignalStrengthFlag = 1;
                       return NO;
                  }
               
            }else {
                   id statebar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
                   if([ZHDevice getVariableWithClass:statebar varName:@"foregroundView"]){
                        id foregroundView = [statebar valueForKey:@"foregroundView"];
                        if([foregroundView isKindOfClass:UIView.class]){
                             NSArray *subviews = [(UIView *)foregroundView subviews];
                             for (id subview in subviews) {
                                 if(isWifi){
                                     if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
                                         if([ZHDevice getVariableWithClass:subview varName:@"wifiStrengthBars"]){
                                             canGetNetSignalStrengthWifiFlag = 2;
                                             return YES;
                                         }
                                     }
                                 }else{
                                     if ([subview isKindOfClass:[NSClassFromString(@"UIStatusBarSignalStrengthItemView") class]]) {
                                           if([ZHDevice getVariableWithClass:subview varName:@"signalStrengthBars"]){
                                                canGetNetSignalStrengthFlag = 2;
                                               return YES;
                                           }
                                     }
                                 }
                            }
                        }
                   }else if([statebar isKindOfClass:UIView.class]){
                       UIView *newstatusBar = [[(UIView *)statebar subviews] firstObject];
                       if([newstatusBar isKindOfClass:NSClassFromString(@"_UIStatusBar")]){
                           if([ZHDevice getVariableWithClass:newstatusBar varName:@"foregroundView"]){
                               id foregroundView = [newstatusBar valueForKey:@"foregroundView"];
                               if([foregroundView isKindOfClass:UIView.class]){
                                    NSArray *subviews = [(UIView *)foregroundView subviews];
                                    for (id subview in subviews) {
                                        if(isWifi){
                                            if([subview isKindOfClass:[NSClassFromString(@"_UIStatusBarWifiSignalView") class]]) {
                                                if([ZHDevice getVariableWithClass:subview varName:@"numberOfBars"]){
                                                    canGetNetSignalStrengthWifiFlag = 2;
                                                    ipadPro10 = TRUE;
                                                    return YES;
                                                }
                                            }
                                        }else{
                                            if ([subview isKindOfClass:[NSClassFromString(@"UIStatusBarSignalStrengthItemView") class]]) {
                                                  if([ZHDevice getVariableWithClass:subview varName:@"signalStrengthBars"]){
                                                       canGetNetSignalStrengthFlag = 2;
                                                    ipadPro10 = TRUE;
                                                      return YES;
                                                  }
                                            }
                                        }
                                   }

                               }
                           }
                       }
                   }
                    if(isWifi){
                        canGetNetSignalStrengthWifiFlag = 1;
                        return NO;
                    }else{
                        canGetNetSignalStrengthFlag = 1;
                        return NO;
                    }
             }
    }
        
}

#pragma mark 获取状态栏
+(UIView *)getStatusBar{
    UIView *statusBar = nil;
    if (@available(iOS 13.0, *)) {
            UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].keyWindow.windowScene.statusBarManager;
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wundeclared-selector"
            if ([statusBarManager respondsToSelector:@selector(createLocalStatusBar)]) {
                UIView *localStatusBar = [statusBarManager performSelector:@selector(createLocalStatusBar)];
                if ([localStatusBar respondsToSelector:@selector(statusBar)]) {
                    statusBar = [localStatusBar performSelector:@selector(statusBar)];
                }
                if ([statusBar respondsToSelector:@selector(statusBar)]) {
                    statusBar = [statusBar performSelector:@selector(statusBar)];
                }
            }
        #pragma clang diagnostic pop
    }else{
       statusBar = [[UIApplication sharedApplication] valueForKeyPath:@"statusBar"];
    }
    return statusBar;
}

+(UIView *)getStatusForegroundView{
    UIView *view = nil;
    if (@available(iOS 13.0, *)) {

    }else{
       view = [[UIApplication sharedApplication] valueForKeyPath:@"statusBar"];
       if (IS_IPhoneX||IS_FULLSCREEN_PAD) {
           if([ZHDevice getVariableWithClass:view varName:@"statusBar"]){
               view = [view valueForKey:@"statusBar"];
               if([ZHDevice getVariableWithClass:view varName:@"foregroundView"]){
                   view = [view valueForKey:@"foregroundView"];
               }
           }
       }else if([ZHDevice getVariableWithClass:view varName:@"foregroundView"]){//ipad pro 10.5.5 foregroundView 在subviews内
           view = [view valueForKey:@"foregroundView"];
       }else if([view isKindOfClass:UIView.class]){
           view = view.subviews.firstObject.subviews.firstObject;//_UIStatusBarForegroundView
       }
    }
    return view;
}


#pragma mark 获取Wifi信号强度
+ (int)getNetSignalStrength:(BOOL)isWifi{
    int signalStrength = 4;
    if(isWifi){
        if (canGetNetSignalStrengthWifiFlag == 1){
            return 4;
        }else if(canGetNetSignalStrengthWifiFlag == 0){
            if(![ZHDevice canGetNetSignalStrength:isWifi]){
                return 4;
            }
        }
    }else{
        if (canGetNetSignalStrengthFlag == 1){
            return 4;
        }else if(canGetNetSignalStrengthFlag == 0){
            if(![ZHDevice canGetNetSignalStrength:isWifi]){
                return 4;
            }
        }
    }
    
    if (@available(iOS 13.0, *)) {
        UIApplication *appl = [UIApplication sharedApplication];
        UIWindow *window = appl.keyWindow;
        UIStatusBarManager *statusBarManager = window.windowScene.statusBarManager;
        id statusBar = nil;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([statusBarManager respondsToSelector:@selector(createLocalStatusBar)]) {
            UIView *localStatusBar = [statusBarManager performSelector:@selector(createLocalStatusBar)];
            if ([localStatusBar respondsToSelector:@selector(statusBar)]) {
                statusBar = [localStatusBar performSelector:@selector(statusBar)];
            }
        }
#pragma clang diagnostic pop
        
        if (statusBar) {
            //NSLog(@"statusBar = %p",statusBar);
            id currentData = [[statusBar valueForKeyPath:@"_statusBar"] valueForKeyPath:@"currentData"];
            if(isWifi){
                //wifi
                id wifiEntry = [currentData valueForKeyPath:@"wifiEntry"];
                if ([wifiEntry isKindOfClass:NSClassFromString(@"_UIStatusBarDataIntegerEntry")]) {
                    //层级：_UIStatusBarDataNetworkEntry、_UIStatusBarDataIntegerEntry、_UIStatusBarDataEntry
                    signalStrength = [[wifiEntry valueForKey:@"displayValue"] intValue];
                }
            }else{
                //运营商
                id cellularEntry = [currentData valueForKeyPath:@"cellularEntry"];
                if ([cellularEntry isKindOfClass:NSClassFromString(@"_UIStatusBarDataCellularEntry")]){
                    signalStrength = [[cellularEntry valueForKey:@"displayValue"] intValue];
                }
            }
        }
    }else{
        id statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
        if (IS_IPhoneX||IS_FULLSCREEN_PAD) {
            if(statusBar){
                id statusBarView = [statusBar valueForKey:@"statusBar"];
                if(statusBarView){
                    UIView *foregroundView = [statusBarView valueForKey:@"foregroundView"];
                    if([foregroundView isKindOfClass:UIView.class]){
                        NSArray *arr = [foregroundView subviews];
                        if(IS_FULLSCREEN_PAD){
                            if(isWifi){
                                for (id subview in arr) {
                                    if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarWifiSignalView")]) {
                                        signalStrength = [[subview valueForKey:@"numberOfActiveBars"] intValue];
                                        break;
                                    }
                                }
                            }else{
                                return 4;
                            }
                        }else{
                            NSArray *foregroundViewSubviews = [foregroundView subviews];
                            if(foregroundViewSubviews.count > 2){
                                NSArray *subviews = [foregroundViewSubviews[2] subviews];
                                for (id subview in subviews) {
                                    if(isWifi){
                                        if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarWifiSignalView")]) {
                                            signalStrength = [[subview valueForKey:@"numberOfActiveBars"] intValue];
                                            break;
                                        }
                                    }else{
                                        if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarPersistentAnimationView")]) {
                                            signalStrength = [[subview valueForKey:@"numberOfActiveBars"] intValue];
                                            break;
                                        }
                                    }
                                }
                            }else{
                                return 4;
                            }
                        }
                    }
                }
            }
        } else {
            if([statusBar isKindOfClass:UIView.class]){
                if(ipadPro10){
                    UIView *newstatusBar = [[(UIView *)statusBar subviews] firstObject];
                    if([newstatusBar isKindOfClass:NSClassFromString(@"_UIStatusBar")]){
                        id foregroundView = [newstatusBar valueForKey:@"foregroundView"];
                        if([foregroundView isKindOfClass:UIView.class]){
                            NSArray *subviews = [(UIView *)foregroundView subviews];
                            for (id subview in subviews) {
                                if(isWifi){
                                    if([subview isKindOfClass:[NSClassFromString(@"_UIStatusBarWifiSignalView") class]]) {
                                        signalStrength = [[subview valueForKey:@"numberOfBars"] intValue];
                                        break;
                                    }
                                }else{
                                    if ([subview isKindOfClass:[NSClassFromString(@"UIStatusBarSignalStrengthItemView") class]]) {
                                        signalStrength = [[subview valueForKey:@"signalStrengthBars"] intValue];
                                        break;
                                    }
                                }
                            }
                        }
                    }
                }else{
                    id foregroundView = [statusBar valueForKey:@"foregroundView"];
                    if([foregroundView isKindOfClass:UIView.class]){
                        NSArray *subviews = [foregroundView subviews];
                        for (id subview in subviews) {
                            if(isWifi){
                                if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
                                    signalStrength = [[subview valueForKey:@"wifiStrengthBars"] intValue];
                                    break;
                                }
                            }else{
                                if ([subview isKindOfClass:[NSClassFromString(@"UIStatusBarSignalStrengthItemView") class]]) {
                                    signalStrength = [[subview valueForKey:@"signalStrengthBars"] intValue];
                                    break;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    // showDebugTips([NSString stringWithFormat:@"signalStrength = %d",signalStrength]);
    return signalStrength;
}

+ (BOOL)getVariableWithClass:(NSObject *)obj varName:(NSString *)name{
    return [self getAllIvar:object_getClass(obj) name:name];
}

+ (BOOL)getAllIvar:(Class)cls name:(NSString *)name{
    if([self getClassIvar:cls name:name]){
        return YES;
    }else if([cls superclass]){
        return [self getAllIvar:[cls superclass] name:name];
    }else{
        return NO;
    }
}

+ (BOOL)getClassIvar:(Class)cls name:(NSString *)name{
    if (!cls) return NO;
    unsigned int a;
    Ivar * iv = class_copyIvarList(cls, &a);
    for (unsigned int i = 0; i < a; i++) {
        Ivar i_v = iv[i];
        NSString *keyName = [NSString stringWithCString:ivar_getName(i_v) encoding:NSUTF8StringEncoding];
        keyName = [keyName stringByReplacingOccurrencesOfString:@"_" withString:@""];
        NSLog(@"%@ : keyName = %@,name = %@",cls,keyName,name);
        if([keyName isEqualToString:name]){
             free(iv);
            return YES;
        }
    }
    free(iv);
    return NO;

}
@end
