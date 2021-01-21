//
//  TTMenuViewController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/20.
//

#import "TTMenuViewController.h"
#import "TTLeiZuViewController.h"

typedef NS_ENUM(NSInteger, TTMenuType) {
    TTMenuTypeGCD = 1,
};

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
            if ([model.toClassString isEqualToString:@"TTLeiZuViewController"]) {
                TTLeiZuViewController *vc = [TTLeiZuViewController new];
                vc.name = @"fansj";
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                NSString *clsStr = model.toClassString;
                Class cls = NSClassFromString(clsStr);
                UIViewController *vc = [cls new];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else {
            // 没有class，走type逻辑
            TTMenuType type = model.type;
            switch (type) {
                case TTMenuTypeGCD:
                {
                    // GCD 功能测试集合
                    TTMenuViewController *vc = [TTMenuViewController new];
                    vc.dataArray = @[
                        [TTMenuModel createT:@"GCD 测试Group用法" toCS:@"TTGCDGroupController"],
                        [TTMenuModel createT:@"GCD 测试信号量用法" toCS:@"TTGCDSemaphoreController"]];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
    };
}

- (void)initData {
    if (!self.dataArray) {
        self.dataArray = @[
            [TTMenuModel createT:@"测试load方法" toCS:@"TTViewControllerB"],
            [TTMenuModel createT:@"测试类簇" toCS:@"TTLeiZuViewController"],
            [TTMenuModel createT:@"测试分类中相同方法调用逻辑" toCS:@"TTSameMethodCallLogicController"],
            [TTMenuModel createT:@"测试GCD" type:TTMenuTypeGCD]];
    }
}


@end
