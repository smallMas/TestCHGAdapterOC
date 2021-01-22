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
    TTMenuTypeAnimation = 2,
    TTMenuTypeRunloop = 3,
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
                    vc.title = @"测试GCD";
                    vc.dataArray = [self gcdArray];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                case TTMenuTypeAnimation:
                {
                    // 动画 功能测试集合
                    TTMenuViewController *vc = [TTMenuViewController new];
                    vc.title = @"测试动画";
                    vc.dataArray = [self animationArray];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                case TTMenuTypeRunloop:
                {
                    // RunLoop 功能测试集合
                    TTMenuViewController *vc = [TTMenuViewController new];
                    vc.title = @"测试RunLoop";
                    vc.dataArray = [self runloopArray];
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
            [TTMenuModel createT:@"测试GCD" type:TTMenuTypeGCD],
            [TTMenuModel createT:@"测试动画" type:TTMenuTypeAnimation],
            [TTMenuModel createT:@"测试RunLoop" type:TTMenuTypeRunloop]];
    }
}

- (NSArray *)gcdArray {
    return @[
        [TTMenuModel createT:@"GCD 测试Group用法" toCS:@"TTGCDGroupController"],
        [TTMenuModel createT:@"GCD 测试信号量用法" toCS:@"TTGCDSemaphoreController"],
        [TTMenuModel createT:@"GCD 执行两组数据完成之后再执行其他任务" toCS:@"TTGCDBarrierController"]];
}

- (NSArray *)animationArray {
    return @[
        [TTMenuModel createT:@"动画 测试postion动画" toCS:@"TTAnimationPositionController"],
        [TTMenuModel createT:@"动画 测试属性动画" toCS:@"TTAnimationPropertyController"],
        [TTMenuModel createT:@"动画 测试组合动画" toCS:@"TTAnimationGroupController"],
        [TTMenuModel createT:@"动画 测试波浪动画" toCS:@"TTAnimationWaterController"]
    ];
}

- (NSArray *)runloopArray {
    return @[
        [TTMenuModel createT:@"RunLoop 测试子线程中调用PerformSelector" toCS:@"TTRunLoopPerformController"],
        [TTMenuModel createT:@"Runloop 测试观察者" toCS:@"TTRunloopObserverController"]
    ];
}

@end
