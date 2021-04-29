//
//  TTTestWCDBDataController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/19.
//

#import "TTTestWCDBDataController.h"
#import "TTTestRandomData.h"

@interface TTTestWCDBDataController ()
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation TTTestWCDBDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *items = @[
        [[UIBarButtonItem alloc] initWithTitle:@"add" style:UIBarButtonItemStyleDone target:self action:@selector(addAction:)],
        [[UIBarButtonItem alloc] initWithTitle:@"delete" style:UIBarButtonItemStyleDone target:self action:@selector(deleteAction:)]
    ];
    
    self.navigationItem.rightBarButtonItems = items;
    
    [self.view addSubview:self.tableView];
    self.tableView.tableViewAdapter.headerHeight = 0;
    self.tableView.tableViewAdapter.footerHeight = 0;
    
    [self selectedALL];
}

- (void)selectedALL {
//    NSArray *a = [TTTestRandomData selectedAllData];
//    [self.dataArray addObjectsFromArray:a];
    [self reload];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

#pragma mark - 操作
- (void)op:(id)sender {
//    FSJAlertSheetView *alert = [[FSJAlertSheetView alloc] initWithTitle:@"操作" message:nil style:UIAlertControllerStyleActionSheet cancelButtonTitle:@"取消" otherButtonTitles:@"添加",@"删除",@"修改", nil];
//    [alert show:^(NSInteger index) {
//        NSLog(@"index >>> %d",index);
//    }];
}

- (void)addAction:(id)sender {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        FSJ_WEAK_SELF
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            FSJ_STRONG_SELF
            dispatch_async(dispatch_get_main_queue(), ^{
                [self addData];
            });
        }];
        self.timer = timer;
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    });
}

- (void)addData {
    TTTestRandomData *data = [TTTestRandomData new];
    data.uuid = [FSJUtility fsj_uuid];
    data.randomNum = [NSString stringWithFormat:@"%d",arc4random()/100000];
    data.name = [NSString stringWithFormat:@"%dshijian",arc4random()/100];
    
    BOOL isToBottom = YES;
    
//    if ([TTTestRandomData insertToDatabase:data]) {
        [self.dataArray addObject:data];
        
        
        NSIndexPath *idxPath = self.tableView.indexPathsForVisibleRows.lastObject;
        if ( !idxPath || self.dataArray.count - idxPath.row > 3) {
            isToBottom = NO;
        }
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.dataArray.count-1) inSection:0];
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        [self.tableView endUpdates];
//    }
    
    if (isToBottom) {
        // 滚动到最底部
        [self scrollToBottom];
    }
}


- (void)scrollToBottom {
    // 滚动到最底部
    NSArray *array = self.dataArray;
    NSLog(@"array >>> %d",array.count);
    if ([array count] > 0 && !self.tableView.dragging) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[array count] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)deleteAction:(id)sender {
//    TTTestRandomData *model = self.dataArray.lastObject;
//    if (model) {
//        BOOL is = [TTTestRandomData deleteDataWithuuid:model.uuid];
//        if (is) {
//            [self.dataArray removeObject:model];
//            [self reload];
//        }
//    }
    
//    [self updateAction:sender];
}

- (void)updateAction:(id)sender {
    TTTestRandomData *data = self.dataArray.lastObject;
    data.name = [NSString stringWithFormat:@"%dshijian",arc4random()/100];
    BOOL is = [TTTestRandomData updateName:data];
    if (is) {
        
    }
    [self reload];
}

- (void)reload {
    self.tableView.cellDatas = @[self.dataArray];
    [self.tableView reloadData];
}


@end
