//
//  TTTestLoadDataCollectionController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/12.
//

#import "TTTestLoadDataCollectionController.h"
#import <MJRefresh/MJRefresh.h>
#import "TTMenuModel.h"

@interface TTTestLoadDataCollectionController ()
@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation TTTestLoadDataCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.clsBlock = ^NSString * _Nullable{
        return @"TTCollectionView";
    };
 
    self.collectionView.alwaysBounceVertical = YES;
    [self.view addSubview:self.collectionView];
    
    FSJ_WEAK_SELF
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.collectionView.mj_header endRefreshing];
        FSJ_STRONG_SELF
        [self insertData];
    }];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.collectionView.mj_footer endRefreshing];
        FSJ_STRONG_SELF
        [self addData];
    }];
//    self.tableView.tableViewAdapter.headerHeight = 0;
//    self.tableView.tableViewAdapter.footerHeight = 0;
    
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
    
    if (first.type > 900) {
        NSArray *a = [self createModelIsNext:NO idx:first.type];
        FSJ_WEAK_SELF
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [a enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FSJ_STRONG_SELF
            [self.dataSource insertObject:obj atIndex:0];
            [array addObject:[NSIndexPath indexPathForItem:idx inSection:0]];
        }];
        
        
        [UIView performWithoutAnimation:^{
            [self reload];
        }];
        
        // 取消动画
    //    [UIView performWithoutAnimation:^{
    //        [self.collectionView reloadItemsAtIndexPaths:array];
    //    }];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:a.count inSection:0];
//        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    }
}

- (void)addData {
    TTMenuModel *last = self.dataSource.lastObject;
    NSArray *a = [self createModelIsNext:YES idx:last.type];
    [self.dataSource addObjectsFromArray:a];
    
    [self reload];
}

- (void)reload {
    self.collectionView.cellDatas = @[self.dataSource];
    [self.collectionView reloadData];
}

@end
