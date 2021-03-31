//
//  TTTestWCDBDataController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/19.
//

#import "TTTestWCDBDataController.h"
#import "TTTestRandomData.h"

@interface TTTestWCDBDataController ()
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation TTTestWCDBDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"add" style:UIBarButtonItemStyleDone target:self action:@selector(addAction:)];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableViewAdapter.headerHeight = 0;
    self.tableView.tableViewAdapter.footerHeight = 0;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)addAction:(id)sender {
    TTTestRandomData *data = [TTTestRandomData new];
    data.uuid = [FSJUtility fsj_uuid];
    data.randomNum = [NSString stringWithFormat:@"%d",arc4random()/100000];
    data.name = [NSString stringWithFormat:@"%dshijian",arc4random()/100];
    
    if ([TTTestRandomData insertToDatabase:data]) {
        [self.dataArray addObject:data];
        [self reload];
    }
}

- (void)reload {
    self.tableView.cellDatas = @[self.dataArray];
    [self.tableView reloadData];
}


@end
