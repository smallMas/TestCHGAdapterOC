//
//  TTTestAESViewController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/4/30.
//

#import "TTTestAESViewController.h"
#import "TTMenuModel.h"
#import "RYTAESEncryptor.h"
#import "NSString+TTEncrypty.h"

@interface TTTestAESViewController ()

@property (strong, nonatomic) NSString *priKey;
@property (strong, nonatomic) NSString *iv;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) NSString *result;
@property (strong, nonatomic) NSString *oriStr;
@property (strong, nonatomic) NSString *decryptionStr;
@end

@implementation TTTestAESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.priKey = @"oBgheKHkAjKtqKeL";//@"kunlunxuetang20210403";
    self.priKey = @"kunlunxuetang202";//[RYTAESEncryptor randomlyGenerated16BitString];
//    self.iv = @"6859505890402435";
    NSLog(@"self.prikey1 : %@",self.priKey);
//    NSString *s = [NSString hexStringFromString:self.priKey];
//    NSLog(@"s >>> %@",s);
//    self.priKey = [self.priKey toHexString];
//    NSLog(@"self.prikey2 : %@",self.priKey);
//    self.priKey = [self.priKey uppercaseString];
//    NSLog(@"self.prikey3 : %@",self.priKey);
    self.result = @"o6OJSHQg6LBXdewsI1FSnILy78sVbYGwMRoObyFbsFtPb1jaQLQe3GtlYgWiIug1U1HTpyJANDRq\nWvD7kqomMI2/4+9Ma1D7dsnqOvLRzhloiDoSZcvupJjlFwiFpdFOQEqwmoCbOa9IQCZx60305297\nwdkkRFuTsE08qiXzRCRMbnR0awh9FDT43WNg3pwDyhvcEiFCStIUycD7KfoBQ7gYb220o1UrLjkc\n7NjYWwtZlNLjiK8rRGqT+ECSk7bCEI3yZ5XEs1HOb1I1lM9Gu+NHWw7SXfppYLTv2v/OqRQ=";
    
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
        }else if (itemData.type == 4) {
            self.result = [self.oriStr kl_AES128EncryptKey:self.priKey iv:self.iv];
        }else if (itemData.type == 5) {
            self.decryptionStr = [self.result kl_AES128DecryptKey:self.priKey iv:self.iv];
        }
        NSLog(@"%@ : %@",itemData.title,(itemData.type == 0 || itemData.type == 2|| itemData.type == 4)?self.result:self.decryptionStr);
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
    [self.dataSource addObject:[TTMenuModel createT:@"AES128向量加密" type:4]];
    [self.dataSource addObject:[TTMenuModel createT:@"AES128向量解密" type:5]];
}

@end
