//
//  TTChainBlockTableController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/6/9.
//

#import "TTChainBlockTableController.h"
#import "TTChainModel.h"
#import <SMChainBlocker/SMChainBlocker.h>

@interface TTChainBlockTableController ()
@property (strong, nonatomic) NSArray *dataArray;
@property (assign, nonatomic) NSTimeInterval time;
@end

@implementation TTChainBlockTableController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.dataSource;
    // Do any additional setup after loading the view.
    [self dataArray];
    [self.view addSubview:self.tableView];
    self.tableView.sm_headerHeight(0)
    .sm_footerHeight(0)
    .sm_keyPathOfSubData(@"subArray")
    .sm_cellDatas(self.dataArray)
    .sm_headerDatas(self.dataArray)
    .sm_reloadData();
}

- (id)getParameterOfUrl:(NSString *)url {
    NSRange range = [url rangeOfString:@"?"];
    if (range.length) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *parameterUrl = [url substringFromIndex:range.location+1];
        NSArray *parameterArr = [parameterUrl componentsSeparatedByString:@"&"];
        for (NSString *parameter in parameterArr) {
            NSArray *parameterBoby = [parameter componentsSeparatedByString:@"="];
            if (parameterBoby.count == 2) {
                [dic setObject:parameterBoby[1] forKey:parameterBoby[0]];
            }else
            {
                return @"非法字符串";
            }
        }
        NSString *localhostStr = [url substringToIndex:range.location];
        [dic setObject:localhostStr forKey:@"localhost"];
        return dic;
    }else
    {
        return @"没有参数";
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.time = CACurrentMediaTime();
    NSLog(@"self.time >>> %f",self.time);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSTimeInterval time = CACurrentMediaTime();
    NSLog(@"self.time >>> %f time : %f %@",self.time,time,@(ceil(time - self.time)));
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        NSMutableArray *arr = NSMutableArray.new;
        for (NSInteger i = 0; i < 100; i++) {
            TTChainModel *model = TTChainModel.new;
            model.name = [NSString stringWithFormat:@"name : %ld",(long)i];
            
            NSMutableArray *subArr = NSMutableArray.new;
            for (NSInteger j = 0; j < 5; j++) {
                TTChainModel *sub = TTChainModel.new;
                sub.name = [NSString stringWithFormat:@"sub name : %ld",j];
                [subArr addObject:sub];
            }
            model.subArray = subArr;
            
            [arr addObject:model];
        }
        _dataArray = arr;
    }
    return _dataArray;
}


@end
