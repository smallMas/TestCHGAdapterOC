//
//  TTMenuViewController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/20.
//

#import "TTMenuViewController.h"

@interface TTMenuViewController ()

@end

@implementation TTMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self.view addSubview:self.tableView];
    self.tableView.tableViewAdapter.headerHeight = 0;
    self.tableView.tableViewAdapter.footerHeight = 0;
    self.tableView.cellDatas = @[self.dataArray];
    
    FSJ_WEAK_SELF
    self.tableView.tableViewDidSelectRowBlock = ^(UITableView *tableView, NSIndexPath *indexPath, id itemData) {
        FSJ_STRONG_SELF
        TTMenuModel *model = itemData;
        if (model.toClassString) {
            NSString *clsStr = model.toClassString;
            Class cls = NSClassFromString(clsStr);
            UIViewController *vc = [cls new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    NSLog(@"======");
}

- (void)initData {
    if (!self.dataArray) {
        self.dataArray = @[[TTMenuModel createT:@"测试load方法" toCS:@"TTViewControllerB"]];
    }
}


@end
