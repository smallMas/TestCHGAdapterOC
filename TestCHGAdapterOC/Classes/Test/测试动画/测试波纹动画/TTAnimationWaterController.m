//
//  TTAnimationWaterController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/22.
//

#import "TTAnimationWaterController.h"
#import "TTWaterView.h"

@interface TTAnimationWaterController ()
@property (nonatomic, strong) TTWaterView *waterView;
@end

@implementation TTAnimationWaterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.waterView];
}

#pragma mark - 懒加载
- (TTWaterView *)waterView {
    if (!_waterView) {
        _waterView = [[TTWaterView alloc] initWithFrame:self.view.bounds];
    }
    return _waterView;
}

@end
