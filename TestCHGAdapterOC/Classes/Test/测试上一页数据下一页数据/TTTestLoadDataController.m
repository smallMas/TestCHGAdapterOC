//
//  TTTestLoadDataController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/12.
//

#import "TTTestLoadDataController.h"
#import <MJRefresh/MJRefresh.h>
#import "TTMenuModel.h"

@interface TTTestLoadDataController ()
@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation TTTestLoadDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.clsBlock = ^NSString *{
        return @"TTTableView";
    };
    [self.view addSubview:self.tableView];
    
    FSJ_WEAK_SELF
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableView.mj_header endRefreshing];
        FSJ_STRONG_SELF
        [self insertData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.tableView.mj_footer endRefreshing];
        FSJ_STRONG_SELF
        [self addData];
    }];
    self.tableView.tableViewAdapter.headerHeight = 0;
    self.tableView.tableViewAdapter.footerHeight = 0;
    
    NSArray *a = [self createModelIsNext:YES idx:1000];
    [self.dataSource addObjectsFromArray:a];
    [self reload];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = NSMutableArray.new;
    }
    return _dataSource;
}

- (NSArray *)createModelIsNext:(BOOL)isNext idx:(NSInteger)idx {
    NSMutableArray *arr = NSMutableArray.new;
    for (int i = 1; i <= 20; i++) {
        TTMenuModel *model = [TTMenuModel new];
        NSInteger index = isNext?(idx+i):(idx-i);
        model.title = [NSString stringWithFormat:@"%ld",index];
        model.type = index;
        [arr addObject:model];
    }
    return arr;
}

- (void)insertData {
    TTMenuModel *first = self.dataSource.firstObject;
    NSArray *a = [self createModelIsNext:NO idx:first.type];
    FSJ_WEAK_SELF
    [a enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FSJ_STRONG_SELF
        [self.dataSource insertObject:obj atIndex:0];
    }];
    
    [self reload];
}

- (void)addData {
    TTMenuModel *last = self.dataSource.lastObject;
    NSArray *a = [self createModelIsNext:YES idx:last.type];
    [self.dataSource addObjectsFromArray:a];
    
    [self reload];
}

- (void)reload {
    self.tableView.cellDatas = @[self.dataSource];
    [self.tableView reloadData];
}


@end
