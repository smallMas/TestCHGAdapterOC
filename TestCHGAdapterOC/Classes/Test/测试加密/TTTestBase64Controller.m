//
//  TTTestBase64Controller.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/4/28.
//

#import "TTTestBase64Controller.h"
#import "TTMenuModel.h"
#import "RYTBase64.h"

@interface TTTestBase64Controller ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) NSString *result;
@property (strong, nonatomic) NSString *oriStr;
@property (strong, nonatomic) NSString *decryptionStr;

@end

@implementation TTTestBase64Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    
    self.oriStr = @"你好吗？万财神";
    [self.view addSubview:self.tableView];
    self.tableView.tableViewAdapter.headerHeight = 0;
    self.tableView.tableViewAdapter.footerHeight = 0;
    self.tableView.cellDatas = @[self.dataSource];
    FSJ_WEAK_SELF
    self.tableView.tableViewDidSelectRowBlock = ^(UITableView *tableView, NSIndexPath *indexPath, TTMenuModel * itemData) {
        FSJ_STRONG_SELF
        if (itemData.type == 0) {
            self.result = [RYTBase64 base64StringFromText:self.oriStr];
        }else if (itemData.type == 1) {
            self.decryptionStr = [RYTBase64 textFromBase64String:self.result];
        }else if (itemData.type == 2) {
            NSData *data = [self.oriStr dataUsingEncoding:NSUTF8StringEncoding];
            self.result = [data base64EncodedStringWithOptions:0];
        }else if (itemData.type == 3) {
            NSData *data = [[NSData alloc]initWithBase64EncodedString:self.result options:0];
            self.decryptionStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        }
        NSLog(@"%@ : %@",itemData.title,(itemData.type == 0 || itemData.type == 2)?self.result:self.decryptionStr);
    };
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        NSMutableArray *obj = [NSMutableArray new];
        _dataSource = obj;
    }
    return _dataSource;
}

- (void)initData {
    [self.dataSource addObject:[TTMenuModel createT:@"base64加密" type:0]];
    [self.dataSource addObject:[TTMenuModel createT:@"base64解密" type:1]];
    [self.dataSource addObject:[TTMenuModel createT:@"ios base64加密" type:2]];
    [self.dataSource addObject:[TTMenuModel createT:@"ios base64解密" type:3]];
}

@end
