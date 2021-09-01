//
//  TTRotaryViewController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/8/5.
//

#import "TTRotaryViewController.h"
#import "TTTurnTableView.h"

@interface TTRotaryViewController ()
@property (weak, nonatomic) TTTurnTableView *turnView;
@end

@implementation TTRotaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"幸运大转盘";
    [self turnView];
}

- (TTTurnTableView *)turnView {
    if (!_turnView) {
        TTTurnTableView *obj = TTTurnTableView.new;
        [self.view addSubview:_turnView = obj];
        CGFloat wh = FSJSCREENWIDTH-10*2;
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeCenterXV(0);
            kMakeCenterYV(0);
            kMakeWHV(wh, wh);
        }];
        [obj fsj_setRoundRadius:wh*0.5 borderColor:[UIColor clearColor]];
        
        FSJ_WEAK_SELF
        obj.block = ^(TTTurnItemModel * _Nonnull result) {
            FSJ_STRONG_SELF
            if (result) {
                [self showAlertResult:result];
            }
        };
    }
    return _turnView;
}

- (void)showAlertResult:(TTTurnItemModel *)result {
    FSJ_WEAK_SELF
    if (result.type == TTTurnTypeNormal) {
        FSJAlertSheetView *alert = [[FSJAlertSheetView alloc] initWithTitle:result.title message:nil style:UIAlertControllerStyleAlert cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show:^(NSInteger index) {
            FSJ_STRONG_SELF
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    }else {
        NSString *title = kStringFormat(@"恭喜你中奖了");
        NSString *msg = result.title;
        FSJAlertSheetView *alert = [[FSJAlertSheetView alloc] initWithTitle:title message:msg style:UIAlertControllerStyleAlert cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show:^(NSInteger index) {
            FSJ_STRONG_SELF
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    }
}

@end
