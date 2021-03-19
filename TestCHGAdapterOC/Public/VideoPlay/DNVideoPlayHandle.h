//
//  DNVideoPlayHandle.h
//  DnaerApp
//
//  Created by DNAER5 on 2019/5/9.
//  Copyright © 2019 燕来秋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "DNPlayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface DNVideoPlayHandle : NSObject

@property (nonatomic, strong) DNPlayer * player;

+(_Nonnull instancetype) sharedInstance;

+(_Nonnull instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
-(_Nonnull instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));
+(_Nonnull instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));

-(DNPlayer*)createPlayerLayerWithUrl:(NSString*)url rect:(CGRect)rect;


@end

NS_ASSUME_NONNULL_END
