//
//  DNVideoPlayHandle.m
//  DnaerApp
//
//  Created by DNAER5 on 2019/5/9.
//  Copyright © 2019 燕来秋. All rights reserved.
//

#import "DNVideoPlayHandle.h"
//#import <KTVHTTPCache/KTVHTTPCache.h>
#import "DNPlayerControlView.h"

#import "DNPlayerNetworkErrView.h"

@interface DNVideoPlayHandle()



@end

@implementation DNVideoPlayHandle

+ (_Nonnull instancetype) sharedInstance {
    static dispatch_once_t pred;
    static id baseSingleTon = nil;
    dispatch_once(&pred, ^{
        baseSingleTon = [super new];
    });
    return baseSingleTon;
}

- (DNPlayer *)createPlayerLayerWithUrl:(NSString *)url rect:(CGRect)rect {
    [self.player removeFromSuperview];
    self.player.url = url;
    self.player.frame = rect;
    return self.player;
}

- (DNPlayer *)player {
    if (!_player) {
        _player = [DNPlayer new];
        _player.controlView = [DNPlayerControlView new];
    }
    return _player;
}


@end
