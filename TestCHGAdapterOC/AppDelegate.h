//
//  AppDelegate.h
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/20.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

