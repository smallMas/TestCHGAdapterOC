//
//  SceneDelegate.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/20.
//

#import "SceneDelegate.h"
#import "AppDelegate.h"
#import "TTMenuViewController.h"
#import "TTNavigationViewController.h"
#import "IQKeyboardManager.h"
#import <AVFAudio/AVAudioSession.h>

@interface SceneDelegate ()
@property (assign, nonatomic) UIBackgroundTaskIdentifier bgTaskId;
@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
    // 告诉app支持后台播放
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    
    TTMenuViewController *vc = [TTMenuViewController new];
    vc.title = @"OC 知识点总结";
    TTNavigationViewController *nav = [[TTNavigationViewController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self initIQKeyboardManager];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    NSLog(@"%s",__FUNCTION__);
    if (_bgTaskId) {
        [[UIApplication sharedApplication] endBackgroundTask:_bgTaskId];
    }
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
    NSLog(@"%s",__FUNCTION__);
    
    //开启后台处理多媒体事件
   [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
   AVAudioSession *session=[AVAudioSession sharedInstance];
   [session setActive:YES error:nil];
   //后台播放
   [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    //这样做，可以在按home键进入后台后 ，播放一段时间，几分钟吧。但是不能持续播放，若需要持续播放，还需要申请后台任务id，具体做法是：
    _bgTaskId = [SceneDelegate backgroundPlayerID:_bgTaskId];
    //其中的_bgTaskId是后台任务UIBackgroundTaskIdentifier _bgTaskId;
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
    NSLog(@"%s",__FUNCTION__);
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.

    // Save changes in the application's managed object context when the application transitions to the background.
    NSLog(@"%s",__FUNCTION__);
    [(AppDelegate *)UIApplication.sharedApplication.delegate saveContext];
}

- (void)initIQKeyboardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;//    控制整个功能是否启用。
    manager.shouldResignOnTouchOutside = YES;
    manager.enableAutoToolbar = NO;
}

+(UIBackgroundTaskIdentifier)backgroundPlayerID:(UIBackgroundTaskIdentifier)backTaskId
{
    //设置并激活音频会话类别
    AVAudioSession *session=[AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    //允许应用程序接收远程控制
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    //设置后台任务ID
    UIBackgroundTaskIdentifier newTaskId=UIBackgroundTaskInvalid;
    newTaskId=[[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    if(newTaskId!=UIBackgroundTaskInvalid&&backTaskId!=UIBackgroundTaskInvalid)
    {
        [[UIApplication sharedApplication] endBackgroundTask:backTaskId];
    }
    return newTaskId;
}

@end
