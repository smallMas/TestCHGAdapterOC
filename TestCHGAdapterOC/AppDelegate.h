//
//  AppDelegate.h
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/20.
//  https://github.com/smallMas/TestCHGAdapterOC.git

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) UIWindow * window;
- (void)saveContext;


@end

