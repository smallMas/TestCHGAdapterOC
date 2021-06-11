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
//    [RYTRSAEncryptor keyWith:^(NSString *pubKey, NSString *priKey) {
//        FSJ_STRONG_SELF
//        self.pubKey = pubKey;
//        self.priKey = priKey;
//        NSLog(@"公钥 : %@",pubKey);
//        NSLog(@"私钥 : %@",priKey);
//    }];
    
    self.pubKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCArfE9riI9f6kmsed4J55Pl/mc2XEwEfeQQOSbaVIKZK+NtKxeQqrigEwxzTQIf5Yv3fExX1cQJOCkiz1FOkmCwO14EQ44e6NSA5gWtf+ZKtd5jB0hSTz13lWW0AUn5l5cIS5UnFUgZYc/80ZpeDQ4Wv4M0WsC/GVwfI0zDCVoJQIDAQAB";
    self.priKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBANFcoVBFZ+dO64CdvxHX5FKzCzloulwA18h99ZNHxS6X0OM/j7hwaadJcuc/zX9f3ZHFARwgfuH/fKOo3ewGYt8fjuD0cmDKZDTCyNH+HxhNCdxIPtj7K80bA78/G63N4wCRjFzQRISUmSJxRVAgzV11B4xGYCEkoqJTGUjBlhdHAgEDAoGBAIuTFjWDmpo0nQBpKgvlQuHMsiZF0ZKrOoWpTmIv2Mm6i0IqX9BK8Row90TVM6o/6QvYq2gVqev/qG0bPp1Zlz40+GsiEWU/Pnl14IiyqUJZCHGGUFVdMyM9YXV+d/vT7bY8wQLqLHY4Soakn06KOTFpcim3vhaUmdXgpo8MIvSLAkEA9+Y9mjjkNLKB/pzNnchraBs8OIxTO4cG4OO9QDZ8vceJW3WPLuJDB60DXBrT0xZxAtx2W9y2drfE7of8fBwXXwJBANg0AqcfZLbT/JNbN1RYyV9h9cY6BbPYEV4N0cExN1I25dr1SUIfkDh8VR47hn5hIlP/11bmSM8EHJOXdbNFkRkCQQClRCkRe0LNzFapvd5pMEeavNLQXYzSWgSV7SjVeah+hQY8+QofQYIFHgI9ZzfiDvYB6E7n6HmkeoNJr/2oEro/AkEAkCKsb2pDJI1TDOd6ODsw6kFOhCaud+Vg6V6L1iDPjCSZPKOGLBUK0FLjaX0EVEDBjVU6Oe7bNK1oYmT5Ii5guwJBAJ3Unu6Vct8IqalbCLU5TjSrrZMEN8VJBwIExg9xWzvDTwxpP2YR4+hOYTkVlxy06g0snGjVCGGOA3EHexoIaJI=";
    self.result = @"A207AEFF60679FD00C3190DA7EBA77F80B19DEC09937B704FD293BD949A21050A5876893198574A23274455B7314E3A35B45260E35EECD59560513A813A6A5ED202887A6F2D82DC9B44841283007DBEA3B1A3789D500CB88DF003CAC3CD370E50F6FD0C233809C5C2A9064E918CA95D6FE4A994ECFAE9EA7D06F9AB5B3B97B26";
    [self initData];
    
    self.oriStr = @"xtsgpq6lgaomtb97";
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
        }else if (itemData.type == 4) {
            self.result = [RSAHandle encryptHEXString:self.oriStr publicKey:self.pubKey];
        }else if (itemData.type == 5) {
            self.decryptionStr = [RSAHandle decryptHEXString:self.result privateKey:self.priKey];
        }
        NSLog(@"%@ : %@",itemData.title,(itemData.type == 0 || itemData.type == 2 || itemData.type == 4)?self.result:self.decryptionStr);
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
    [self.dataSource addObject:[TTMenuModel createT:@"RSA公钥加密(HEX)" type:4]];
    [self.dataSource addObject:[TTMenuModel createT:@"RSA私钥钥解密(HEX)" type:5]];
}


@end
