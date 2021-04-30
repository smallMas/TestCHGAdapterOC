//
//  TTTestAESViewController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/4/30.
//

#import "TTTestAESViewController.h"
#import "TTMenuModel.h"
#import "RYTAESEncryptor.h"

@interface TTTestAESViewController ()

@property (strong, nonatomic) NSString *priKey;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) NSString *result;
@property (strong, nonatomic) NSString *oriStr;
@property (strong, nonatomic) NSString *decryptionStr;
@end

@implementation TTTestAESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.priKey = [RYTAESEncryptor randomlyGenerated16BitString];
    
    [self initData];
    
    FSJ_WEAK_SELF
    self.oriStr = @"你好吗？造化主宰";
    [self.view addSubview:self.tableView];
    self.tableView.tableViewAdapter.headerHeight = 0;
    self.tableView.tableViewAdapter.footerHeight = 0;
    self.tableView.cellDatas = @[self.dataSource];
    self.tableView.tableViewDidSelectRowBlock = ^(UITableView *tableView, NSIndexPath *indexPath, TTMenuModel * itemData) {
        FSJ_STRONG_SELF
        if (itemData.type == 0) {
            self.result = [self.oriStr fsj_AES128EncryptKey:self.priKey];
        }else if (itemData.type == 1) {
            self.decryptionStr = [self.result fsj_AES128DecryptKey:self.priKey];
        }else if (itemData.type == 2) {
            self.result = [self.oriStr fsj_AES256EncryptKey:self.priKey];
        }else if (itemData.type == 3) {
            self.decryptionStr = [self.result fsj_AES256DecryptKey:self.priKey];
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
    [self.dataSource addObject:[TTMenuModel createT:@"AES128加密" type:0]];
    [self.dataSource addObject:[TTMenuModel createT:@"AES128解密" type:1]];
    [self.dataSource addObject:[TTMenuModel createT:@"AES256加密" type:2]];
    [self.dataSource addObject:[TTMenuModel createT:@"AES256解密" type:3]];
}

@end
