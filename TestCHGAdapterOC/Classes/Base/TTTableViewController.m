//
//  TTTableViewController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/20.
//

#import "TTTableViewController.h"
#import <objc/message.h>

@interface TTTableViewController ()

@end

@implementation TTTableViewController
@synthesize tableView = _tableView;

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super init];
    _style = style;
    [self setup];
    return self;
}

- (instancetype)init {
    self = [self initWithStyle:UITableViewStylePlain];
    return self;
}

- (void)setup {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if ( !_tableView ) {
        NSString *clsStr = nil;
        if (self.clsBlock) {
            clsStr = self.clsBlock();
        }
        if (clsStr) {
            Class cls = NSClassFromString(clsStr);
            id myobjc = ((id (*)(id, SEL))objc_msgSend)(cls, @selector(alloc));
            _tableView = ((id (*)(id, SEL, CGRect, UITableViewStyle))objc_msgSend)(myobjc, @selector(initWithFrame:style:), self.view.bounds, self.style);
        }else {
            _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.style];
        }
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView setBackgroundColor:[UIColor whiteColor]];
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedRowHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
