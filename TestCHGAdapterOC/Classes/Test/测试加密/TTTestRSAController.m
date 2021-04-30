//
//  TTTestRSAController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/4/29.
//

#import "TTTestRSAController.h"
#import "RYTRSAEncryptor.h"
#import "RSAHandle.h"
#import "TTMenuModel.h"

@interface TTTestRSAController ()

@property (strong, nonatomic) NSString *pubKey;
@property (strong, nonatomic) NSString *priKey;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) NSString *result;
@property (strong, nonatomic) NSString *oriStr;
@property (strong, nonatomic) NSString *decryptionStr;
@end

@implementation TTTestRSAController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FSJ_WEAK_SELF
    [RYTRSAEncryptor keyWith:^(NSString *pubKey, NSString *priKey) {
        FSJ_STRONG_SELF
        self.pubKey = pubKey;
        self.priKey = priKey;
        NSLog(@"公钥 : %@ 私钥 : %@",pubKey, priKey);
    }];
    
//    self.pubKey = @"MIGeMA0GCSqGSIb3DQEBAQUAA4GMADCBiAKBgHvqwDsa6v3CQl9Asw1sjXC4EZqajKl1eLEqjgmQUgK0QE7XJ4pVEqu4KUykwsoegl6VdOfFEgCid07Rw5E8jUq6pB6AHqv//Oug8q/tXufETabiqxwOl6PraATmj3eajph5zPRVJ7wTDIJN03Sda0Y6PIBV8ZCGmJSQqdUaaPUJAgMBAAE=";
//    self.priKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAJrjV7pcyeMehpfD+sUoYZxG/MHVKq/Bv2UQaqIfekLX1pK+q5d5HfTWCX/znA+VsshwpdB7D4I5qOOpoUWhdxaVed5cAFuZns82xbJA6HzxqhgRvvZOjsIYLlLsXJgm/plAEP6FX/g1D0nXTEhl/6bL54mjnIVL61vsS8mD4v1nAgMBAAECgYADhrF0mLAv73347olC+8xdFnCiqQuzvKFy15DV6AmMhAVqidS2Oheof0bwFseywyGy1n2v5V1RBacGp9H4F9jyLZWvQNt1W+yN/GsSDu/uTo96yLHp83aHcwpXsh5n5nxzFMvZJtHUPzXMrCJxgQCOPBkpOYtgJl/63a4hvA8LwQJBANZEL62V5DUe4tb+5XcDyR8JcqOynByPYRN6P7zxqgP7lHEXuaGgdT8cx/v9Pg8AE/5EDlSCTvgJzFfJXWtQpY8CQQC5Dmr8MR72W+gW2Dgyj2JooGpgM7SN4g20GH7cAvLJuq99fAX54qyl+3McqVq8OKtmG1ylegHdz4Dh5Krcui6pAkEAgCdcVPiX++WzS2A9oseS3YtrE9naYYKoT1wJD1uDkspAaLwF/VPZjJwMSP2YxqQHUUcnQwiFbvl9TOxVgcBEpQJAeGzBgkwU8gztA7DBIWXdjGiX0PLU1F/+uuwV4eapSE2MVgSXfv3bjEgNqOEsgr/+CfxUVfsHq+iU3muIJQujwQJAXOGZZM8Pkv4lieUs9i748XwGQxcR5/fP3r2toN0AOkjUNG3nSVQuXEOsgFFlQBWRG1nOic3wcQLAf3vqDhJ+Gw==";
//    self.result = @"WDwg1GMs5XOT+MeJvn02QOuwDJdkf4hXPaxlPyVANJ6uq/7DnpdHP3J3FT2HcZ+zqJ1IPFgOziej0rjJaQ+HynAC4QH68r+W/aesURsQRLFaTJljpefZ0s7K/a9anFU+dZWWO7xmV00zua89r/Ff1YUIp+eTwwnF2fcbzA3xg5g=";
    [self initData];
    
    self.oriStr = @"你好吗？万财神";
    [self.view addSubview:self.tableView];
    self.tableView.tableViewAdapter.headerHeight = 0;
    self.tableView.tableViewAdapter.footerHeight = 0;
    self.tableView.cellDatas = @[self.dataSource];
    self.tableView.tableViewDidSelectRowBlock = ^(UITableView *tableView, NSIndexPath *indexPath, TTMenuModel * itemData) {
        FSJ_STRONG_SELF
        if (itemData.type == 0) {
            self.result = [RSAHandle encryptString:self.oriStr privateKey:self.priKey];
        }else if (itemData.type == 1) {
            self.decryptionStr = [RSAHandle decryptString:self.result publicKey:self.pubKey];
        }else if (itemData.type == 2) {
            self.result = [RSAHandle encryptString:self.oriStr publicKey:self.pubKey];
        }else if (itemData.type == 3) {
            self.decryptionStr = [RSAHandle decryptString:self.result privateKey:self.priKey];
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
    [self.dataSource addObject:[TTMenuModel createT:@"RSA私钥加密" type:0]];
    [self.dataSource addObject:[TTMenuModel createT:@"RSA公钥解密" type:1]];
    [self.dataSource addObject:[TTMenuModel createT:@"RSA公钥加密" type:2]];
    [self.dataSource addObject:[TTMenuModel createT:@"RSA私钥解密" type:3]];
}


@end
