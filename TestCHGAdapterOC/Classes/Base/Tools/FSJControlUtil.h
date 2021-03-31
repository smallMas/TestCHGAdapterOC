//
//  FSJControlUtil.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


BOOL showController(UIViewController *vc,BOOL animate,void (^_Nullable completion)(void));

UIViewController *currentTopViewController(void);

@interface FSJControlUtil : NSObject

@end

NS_ASSUME_NONNULL_END
