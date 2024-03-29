//
//  TTMenuViewController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/20.
//

#import "TTMenuViewController.h"
#import "TTLeiZuViewController.h"
#import "TTGongShiViewController.h"
#import "TTTreeSortViewController.h"

#import "TTExerciseModel.h"

typedef NS_ENUM(NSInteger, TTMenuType) {
    TTMenuTypeGCD = 1,
    TTMenuTypeAnimation,
    TTMenuTypeRunloop,
    TTMenuTypeTimer,
    TTMenuTypeSuanFa,
    // 公式
    TTMenuTypeGongShi,
    // 二叉树
    TTMenuTypeTree,
    // 9宫格数独
    TTMenuTypeNineSudoku,
    // 数据库
    TTMenuTypeDataBase,
    // 本地库
    TTMenuTypeLocalLib,
    // 加密
    TTMenuTypeEncryption,
    // block链式编程
    TTMenuTypeBlock,
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
                vc.dict = @{@"model":model};
//                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
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
                    [self gotoSecondMenuTitle:model.title menuArray:[self gcdArray]];
                }
                    break;
                    
                case TTMenuTypeAnimation:
                {
                    // 动画 功能测试集合
                    [self gotoSecondMenuTitle:model.title menuArray:[self animationArray]];
                }
                    break;
                    
                case TTMenuTypeRunloop:
                {
                    // RunLoop 功能测试集合
                    [self gotoSecondMenuTitle:model.title menuArray:[self runloopArray]];
                }
                    break;
                    
                case TTMenuTypeTimer:
                {
                    // 定时器 功能
                    [self gotoSecondMenuTitle:model.title menuArray:[self timerArray]];
                }
                    break;
                    
                case TTMenuTypeSuanFa:
                {
                    // 算法
                    [self gotoSecondMenuTitle:model.title menuArray:[self suanfaArray]];
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
                        [self gotoSecondMenuTitle:model.title menuArray:[self gongShiArray]];
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
                        [self gotoSecondMenuTitle:model.title menuArray:[self treeArray]];
                    }
                }
                    break;
                    
                case TTMenuTypeNineSudoku:
                {
                    // 九宫格数独
                    [self gotoSecondMenuTitle:model.title menuArray:[self sudoKuArray]];
                }
                    break;
                    
                case TTMenuTypeDataBase:
                {
                    // 数据库
                    [self gotoSecondMenuTitle:model.title menuArray:[self databaseArray]];
                }
                    break;
                    
                case TTMenuTypeLocalLib:
                {
                    // 测试本地库
                    [self gotoSecondMenuTitle:model.title menuArray:[self localLibArray]];
                }
                    break;
                    
                case TTMenuTypeEncryption:
                {
                    // 加密
                    [self gotoSecondMenuTitle:model.title menuArray:[self encryptionLibArray]];
                }
                    break;
                    
                case TTMenuTypeBlock:
                {
                    // block链式编程
                    [self gotoSecondMenuTitle:model.title menuArray:[self blockChainArray]];
                }
                    break;
                default:
                    break;
            }
        }
    };
}

- (void)gotoSecondMenuTitle:(NSString *)title menuArray:(NSArray *)menus {
    TTMenuViewController *vc = [TTMenuViewController new];
    vc.title = title;
    vc.dataArray = menus;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initData {
    if (!self.dataArray) {
        self.dataArray = @[
            [TTMenuModel createT:@"测试其他的" toCS:@"TTOtherViewController"],
            [TTMenuModel createT:@"测试load方法" toCS:@"TTViewControllerB"],
            [TTMenuModel createT:@"测试类簇" toCS:@"TTLeiZuViewController"],
            [TTMenuModel createT:@"测试分类中相同方法调用逻辑" toCS:@"TTSameMethodCallLogicController"],
            [TTMenuModel createT:@"测试GCD" type:TTMenuTypeGCD],
            [TTMenuModel createT:@"测试动画" type:TTMenuTypeAnimation],
            [TTMenuModel createT:@"测试RunLoop" type:TTMenuTypeRunloop],
            [TTMenuModel createT:@"测试定时器" type:TTMenuTypeTimer],
            [TTMenuModel createT:@"测试算法" type:TTMenuTypeSuanFa],
            [TTMenuModel createT:@"测试KVC原理" toCS:@"TTTestKVCViewController"],
            [TTMenuModel createT:@"测试深拷贝浅拷贝" toCS:@"TTTestCopyViewController"],
            [TTMenuModel createT:@"还原方法调用的本质和方法崩溃的原因" toCS:@"TTCallFunViewController"],
            [TTMenuModel createT:@"OC层级以及偏移问题" toCS:@"TTOCOffsetViewController"],
            [TTMenuModel createT:@"IsKindOf和isMemberOf的区别" toCS:@"TTKindMemberViewController"],
            [TTMenuModel createT:@"测试视频播放" toCS:@"TTTestVideoViewController"],
            [TTMenuModel createT:@"测试音频播放" toCS:@"TTTestAudioViewController"],
            [TTMenuModel createT:@"测试WK加载PDF" toCS:@"TTTestWKShowPDFController"],
            [TTMenuModel createT:@"测试上一页数据下一页数据(tableview)" toCS:@"TTTestLoadDataController"],
            [TTMenuModel createT:@"测试上一页数据下一页数据(collcetion)" toCS:@"TTTestLoadDataCollectionController"],
            [TTMenuModel createT:@"测试Safe布局" toCS:@"TTTestSafeViewController"],
            [TTMenuModel createT:@"测试数据库" type:TTMenuTypeDataBase],
            [TTMenuModel createT:@"测试UIStackView" toCS:@"TTTestStackViewController"],
            [TTMenuModel createT:@"测试本地库" type:TTMenuTypeLocalLib],
            [TTMenuModel createT:@"测试YYText" toCS:@"TTTestYYTextController"],
            [TTMenuModel createT:@"测试加密" type:TTMenuTypeEncryption],
            [TTMenuModel createT:@"测试Block及链式编程" type:TTMenuTypeBlock],
            [TTMenuModel createT:@"测试表格样式显示" toCS:@"TTTestFormViewController"],
            [TTMenuModel createT:@"测试load优先级" toCS:@"TTTestLoadController"],
            [TTMenuModel createT:@"测试方法交换" toCS:@"TTChangedMethodController"]
        ];
    }
}

- (NSArray *)gcdArray {
    return @[
        [TTMenuModel createT:@"GCD 测试Group用法" toCS:@"TTGCDGroupController"],
        [TTMenuModel createT:@"GCD 测试信号量用法" toCS:@"TTGCDSemaphoreController"],
        [TTMenuModel createT:@"GCD 执行两组数据完成之后再执行其他任务" toCS:@"TTGCDBarrierController"],
        [TTMenuModel createT:@"NSThread 常驻内存" toCS:@"TTTestThreadViewController"]
    ];
}

- (NSArray *)animationArray {
    return @[
        [TTMenuModel createT:@"动画 测试postion动画" toCS:@"TTAnimationPositionController"],
        [TTMenuModel createT:@"动画 测试属性动画" toCS:@"TTAnimationPropertyController"],
        [TTMenuModel createT:@"动画 测试组合动画" toCS:@"TTAnimationGroupController"],
        [TTMenuModel createT:@"动画 测试波浪动画" toCS:@"TTAnimationWaterController"],
        [TTMenuModel createT:@"动画 测试转场动画" toCS:@"TTTrainsViewController"]
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
        [TTMenuModel createT:@"测试公式算法" type:TTMenuTypeGongShi],
        [TTMenuModel createT:@"测试九宫格数独" type:TTMenuTypeNineSudoku]
    ];
}

- (NSArray *)treeArray {
    return @[
        [TTMenuModel createT:@"二叉树前序遍历" type:TTMenuTypeTree data:[TTTreeQuestionModel createT:TTTreeTypeBeforeSort]],
        [TTMenuModel createT:@"二叉树中序遍历" type:TTMenuTypeTree data:[TTTreeQuestionModel createT:TTTreeTypeCenterSort]],
        [TTMenuModel createT:@"二叉树后序遍历" type:TTMenuTypeTree data:[TTTreeQuestionModel createT:TTTreeTypeAfterSort]],
        [TTMenuModel createT:@"二叉树自上而下，自左而右遍历" type:TTMenuTypeTree data:[TTTreeQuestionModel createT:TTTreeTypeUpDownLeftRight]],
        [TTMenuModel createT:@"二叉树自下而上，自左而右遍历" type:TTMenuTypeTree data:[TTTreeQuestionModel createT:TTTreeTypeDownUpLeftRight]]
    ];
}

- (NSArray *)gongShiArray {
    return @[
        [TTMenuModel createT:@"根据字母计算在第几行" type:TTMenuTypeGongShi data:[TTExerciseModel createExeType:TTExerciseTypeZiMuToColum]]
    ];
}

- (NSArray *)sudoKuArray {
    return @[
        [TTMenuModel createT:@"计算九宫格数独" toCS:@"TTSudoKuViewController"],
        [TTMenuModel createT:@"9X9数独" toCS:@"TTSudok9Controller"],
        [TTMenuModel createT:@"儿童数独" toCS:@"KLUnSudoViewController"],
        [TTMenuModel createT:@"幸运大转盘" toCS:@"TTRotaryViewController"]
    ];
}

- (NSArray *)databaseArray {
    return @[
        [TTMenuModel createT:@"测试WCDB数据库" toCS:@"TTTestWCDBDataController"]
    ];
}

- (NSArray *)localLibArray {
    return @[
        [TTMenuModel createT:@"测试本地库[事件引擎]" toCS:@"TTTestLocalEventLibController"]
    ];
}

- (NSArray *)encryptionLibArray {
    return @[
        [TTMenuModel createT:@"测试base64加密" toCS:@"TTTestBase64Controller"],
        [TTMenuModel createT:@"测试RSA加密" toCS:@"TTTestRSAController"],
        [TTMenuModel createT:@"测试文件权限" toCS:@"TTFileSecretViewController"],
        [TTMenuModel createT:@"测试AES加密" toCS:@"TTTestAESViewController"]
    ];
}

- (NSArray *)blockChainArray {
    return @[
        [TTMenuModel createT:@"测试链式开发-TableView" toCS:@"TTChainBlockTableController"],
        [TTMenuModel createT:@"测试链式开发-Collection" toCS:@"TTChainBlockCollectionController"]
    ];
}

@end
