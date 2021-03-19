//
//  TTTestSafeViewController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/18.
//

#import "TTTestSafeViewController.h"
#import "UIImageView+WebCache.h"
#import "KLLiveGradientView.h"
#import "ZHDevice.h"
#import "SceneDelegate.h"

#define kIPX_BangHeight (24)
#define kSafeLayout_T (IS_IPhoneX ? (kIPX_BangHeight) : 0)

@interface TTTestSafeViewController ()
@property (strong, nonatomic) UIView *headerView;
@property (nonatomic, strong) UIImageView *coverImgView;
@property (strong, nonatomic) KLLiveGradientView *upView;
@end

@implementation TTTestSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self coverImgView];
    [self.view setBackgroundColor:[UIColor blackColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    NSString *url = @"http://img.klxt.com/3450501615970811018.png";
    [self.coverImgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    
    [self upView];
    
    NSArray *array =[[[UIApplication sharedApplication] connectedScenes] allObjects];
    UIWindowScene *windowScene = (UIWindowScene *)array[0];
    SceneDelegate *delegate =(SceneDelegate *)windowScene.delegate;
    UIWindow *window = delegate.window;
    NSLog(@"=== : %f",window.safeAreaInsets.top);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CGFloat x = (kSafeLayout_T+20);
    NSLog(@"xx : %f",x);
    NSLog(@"yy : %f",self.view.safeAreaInsets.top);
}

- (UIView *)headerView {
    if (!_headerView) {
        UIView *obj = [UIView new];
        [self.view addSubview:_headerView = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            if (@available(iOS 11.0, *)) {
                make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
            } else {
                make.top.mas_equalTo(0);
            }
            make.height.mas_equalTo(FSJSCREENWIDTH/16*9);
        }];
        [obj setBackgroundColor:[UIColor fsj_randomColor]];
    }
    return _headerView;
}

- (UIImageView *)coverImgView {
    if (!_coverImgView) {
        UIImageView *obj = [UIImageView new];
        [self.headerView addSubview:_coverImgView = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return _coverImgView;
}

- (KLLiveGradientView *)upView {
    if (!_upView) {
        KLLiveGradientView *obj = [[KLLiveGradientView alloc] init];
        
        obj.colorsBlock(@[[UIColor fsj_colorWithHexString:@"#000000" alpha:1],[UIColor fsj_colorWithHexString:@"#000000" alpha:0]]);
        [self.view addSubview:_upView = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
//            make.top.mas_equalTo(kSafeLayout_T+20);
            make.top.mas_equalTo(self.headerView);
//            if (@available(iOS 11.0, *)) {
//                make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
//            } else {
//                make.top.mas_equalTo(0);
//            }
            make.height.mas_equalTo(44);
        }];
    }
    return _upView;
}

- (void)orientChange:(NSNotification *)notification {
    UIInterfaceOrientation interfaceOritation = [[UIApplication sharedApplication] statusBarOrientation];
    NSLog(@"interfaceOritation : %d",interfaceOritation);
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    if (interfaceOritation == UIInterfaceOrientationLandscapeLeft ||
        interfaceOritation == UIInterfaceOrientationLandscapeRight) {
        [self.headerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }else {
        [self.headerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            if (@available(iOS 11.0, *)) {
                make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
            } else {
                make.top.mas_equalTo(0);
            }
            make.height.mas_equalTo(FSJSCREENWIDTH/16*9);
        }];
    }
}

@end
