//
//  TTMenuViewController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/20.
//

#import "TTMenuViewController.h"
#import "TTLeiZuViewController.h"
#import "TTGongShiViewController.h"
#import "TTExerciseModel.h"
#import "TTTreeSortViewController.h"

typedef NS_ENUM(NSInteger, TTMenuType) {
    TTMenuTypeGCD = 1,
    TTMenuTypeAnimation = 2,
    TTMenuTypeRunloop = 3,
    TTMenuTypeTimer = 4,
    TTMenuTypeSuanFa = 5,
    // 公式
    TTMenuTypeGongShi = 6,
    // 二叉树
    TTMenuTypeTree = 7,
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
                vc.title = model.title;
                vc.name = @"fansj";
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                NSString *clsStr = model.toClassString;
                Class cls = NSClassFromString(clsStr);
                UIViewController *vc = [cls new];
                vc.title = model.title;
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
                    vc.title = model.title;
                    vc.dataArray = [self gcdArray];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                case TTMenuTypeAnimation:
                {
                    // 动画 功能测试集合
                    TTMenuViewController *vc = [TTMenuViewController new];
                    vc.title = model.title;
                    vc.dataArray = [self animationArray];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                case TTMenuTypeRunloop:
                {
                    // RunLoop 功能测试集合
                    TTMenuViewController *vc = [TTMenuViewController new];
                    vc.title = model.title;
                    vc.dataArray = [self runloopArray];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                case TTMenuTypeTimer:
                {
                    // 定时器 功能
                    TTMenuViewController *vc = [TTMenuViewController new];
                    vc.title = model.title;
                    vc.dataArray = [self timerArray];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                case TTMenuTypeSuanFa:
                {
                    // 算法
                    TTMenuViewController *vc = [TTMenuViewController new];
                    vc.title = model.title;
                    vc.dataArray = [self suanfaArray];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                case TTMenuTypeGongShi:
                {
                    if (model.data) {
                        TTGongShiViewController *vc = [TTGongShiViewController new];
                        vc.title = model.title;
                        vc.exeModel = model.data;
                        [self.navigationController pushViewController:vc animated:YES];
                    }else {
                        // 计算公式题目列表
                        TTMenuViewController *vc = [TTMenuViewController new];
                        vc.title = model.title;
                        vc.dataArray = [self gongShiArray];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                }
                    break;
                    
                case TTMenuTypeTree:
                {
                    if (model.data) {
                        TTTreeSortViewController *vc = [TTTreeSortViewController new];
                        vc.title = model.title;
                        vc.queModel = model.data;
                        [self.navigationController pushViewController:vc animated:YES];
                    }else {
                        // 二叉树题目列表
                        TTMenuViewController *vc = [TTMenuViewController new];
                        vc.title = model.title;
                        vc.dataArray = [self treeArray];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
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
            [TTMenuModel createT:@"测试RunLoop" type:TTMenuTypeRunloop],
            [TTMenuModel createT:@"测试定时器" type:TTMenuTypeTimer],
            [TTMenuModel createT:@"测试算法" type:TTMenuTypeSuanFa]
        ];
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

- (NSArray *)timerArray {
    return @[
        [TTMenuModel createT:@"测试NSTimer释放问题" toCS:@"TTTimerReleaseController"]
    ];
}

- (NSArray *)suanfaArray {
    return @[
        [TTMenuModel createT:@"测试二叉树算法" type:TTMenuTypeTree],
        [TTMenuModel createT:@"测试公式算法" type:TTMenuTypeGongShi]
    ];
}

- (NSArray *)treeArray {
    return @[
        [TTMenuModel createT:@"二叉树前序遍历" type:TTMenuTypeTree data:[TTTreeQuestionModel createT:TTTreeTypeBeforeSort]],
        [TTMenuModel createT:@"二叉树中序遍历" type:TTMenuTypeTree data:[TTTreeQuestionModel createT:TTTreeTypeCenterSort]],
        [TTMenuModel createT:@"二叉树后序遍历" type:TTMenuTypeTree data:[TTTreeQuestionModel createT:TTTreeTypeAfterSort]],
        [TTMenuModel createT:@"二叉树从上到下，从左到右遍历" type:TTMenuTypeTree data:[TTTreeQuestionModel createT:TTTreeTypeUpDownLeftRight]],
    ];
}

- (NSArray *)gongShiArray {
    return @[
        [TTMenuModel createT:@"根据字母计算在第几行" type:TTMenuTypeGongShi data:[TTExerciseModel createExeType:TTExerciseTypeZiMuToColum]]
    ];
}

@end
