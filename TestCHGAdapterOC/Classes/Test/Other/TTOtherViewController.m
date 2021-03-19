//
//  TTOtherViewController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/2/2.
//

#import "TTOtherViewController.h"
#import <Photos/Photos.h>
#import "UITextView+TT.h"

@interface TTOtherViewController ()
@property (nonatomic, copy) dispatch_block_t block;
@end

@implementation TTOtherViewController

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
    if (self.block) {
        dispatch_block_cancel(self.block);
    }
}

- (void)loadView {
    NSLog(@"%s",__FUNCTION__);
//    self.view = [UIView new];
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%s",__FUNCTION__);
//    dispatch_block_t blockT = dispatch_block_create(DISPATCH_BLOCK_BARRIER, ^{
//        NSLog(@"---------");
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            BOOL is = YES;
//            while (is) {
//                NSLog(@"============");
//            }
//        });
//    });
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), blockT);
//    self.block = blockT;
    
    UITextView *text = [[UITextView alloc] init];
    text.obj.a = @"fansj";
    [self.view addSubview:text];
    [text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(44);
        make.center.mas_equalTo(self.view);
    }];
    [text setBackgroundColor:[UIColor fsj_randomColor]];
}



@end
