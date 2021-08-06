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
    self.priKey = @"X1FACP69GOQ9LUDQ";//[RYTAESEncryptor randomlyGenerated16BitString];
//    self.iv = @"6859505890402435";
    NSLog(@"self.prikey1 : %@",self.priKey);
//    NSString *s = [NSString hexStringFromString:self.priKey];
//    NSLog(@"s >>> %@",s);
//    self.priKey = [self.priKey toHexString];
//    NSLog(@"self.prikey2 : %@",self.priKey);
//    self.priKey = [self.priKey uppercaseString];
//    NSLog(@"self.prikey3 : %@",self.priKey);
    self.result = @"fTVHai3pM2+7WPrxAdI4w8CKVy3FLGqwjEEZIQKHvFoyaKwLymxcP3kZ3JbpbeKxMBLyJw0q4L7rtfa0/kAbrg6LpZIzWdjeGeVYQSr5cJR6+2dSdXeW6oLxNaU9g3dtgAzqRZC9QL6PuPBMWlj/uM6ITmjAObrW4XwgBgZ6nExd3GF09VoIN1TFjS8664I9Aa+cj7Y708CHau34lF9toHPp3afsF+15obCQRb2SW9VNxzvuS7iX5+juCK7XN+SJBPfcz35oaR69eMWT00IqqtqfC7sXBIjiOd7WhKWVj80Ejt3Uj7tWH76q84eToFidJPdUzruhYodvWrNFFrAkYqbSFzjCEaR6Jb2f0kgDW3YfOu4Cp1mecdPUqWAvVDX6bz6lC7ruNDdxwNfz5GE6Y7rbunFyS0dMY3cwqRqVslTwI15UYnQoIMuhdyvkp9vVqofad4SNFGpa5qITINQjrsnYH/UrtMYKp4LU1bY1A/bjvJp/eY9AG1v7PC81EOkS";
    
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
