//
//  TTTestVideoViewController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/2/25.
//

#import "TTTestVideoViewController.h"
#import "DNPlayer.h"
#import "DNVideoPlayHandle.h"

@interface TTTestVideoViewController ()
@property (strong, nonatomic) DNPlayer *playerView;
@property (strong, nonatomic) NSString *url;
@end

@implementation TTTestVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.url = @"https://super-video.oss-cn-beijing.aliyuncs.com/%E7%AE%A1%E7%90%86%E4%BC%9A%E8%AE%A1/1.%E8%B4%A2%E5%8A%A1%E6%98%AF%E7%AE%A1%E7%90%86%E7%9A%84%E5%94%AF%E4%B8%80%E8%AF%AD%E8%A8%80.mp4";
    
    [self playerView];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[[DNVideoPlayHandle sharedInstance] player] play];
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    [[[DNVideoPlayHandle sharedInstance] player] play];
//}
//
//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//    [[[DNVideoPlayHandle sharedInstance] player] stop:^id(id data) {
//
//        return nil;
//    }];
//}

- (DNPlayer *)playerView {
    if (!_playerView) {
        DNPlayer *obj = [[DNVideoPlayHandle sharedInstance] createPlayerLayerWithUrl:self.url rect:self.view.bounds];
        [self.view addSubview:_playerView = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(200);
        }];
    }
    return _playerView;
}

@end
