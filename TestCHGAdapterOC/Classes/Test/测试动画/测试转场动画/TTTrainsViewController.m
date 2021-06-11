//
//  TTTrainsViewController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/6/4.
//

#import "TTTrainsViewController.h"

@interface TTTrainsViewController ()
@property (weak, nonatomic) UIView *redView;
@end

@implementation TTTrainsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *items = @[
        [[UIBarButtonItem alloc] initWithTitle:@"add" style:UIBarButtonItemStyleDone target:self action:@selector(addAction:)],
        [[UIBarButtonItem alloc] initWithTitle:@"remove" style:UIBarButtonItemStyleDone target:self action:@selector(deleteAction:)]
    ];
    self.navigationItem.rightBarButtonItems = items;
}

- (void)addAction:(id)sender {
    [self.view addSubview:self.redView];
    self.redView.hidden = NO;
    [self.redView fsj_transitionAnimationType:FSJTransitionTypeMoveIn subType:FSJTransitionSubTypeRight];
}

- (void)deleteAction:(id)sender {
    [self.redView fsj_transitionAnimationType:FSJTransitionTypeReveal subType:FSJTransitionSubTypeLeft];
//    [self.redView removeFromSuperview];
    self.redView.hidden = YES;
}

- (UIView *)redView {
    if (!_redView) {
        UIView *obj = [UIView new];
        [self.view addSubview:_redView = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeWHV(200, 200);
            kMakeCenter(self.view);
        }];
        obj.backgroundColor = [UIColor redColor];
    }
    return _redView;
}

@end
