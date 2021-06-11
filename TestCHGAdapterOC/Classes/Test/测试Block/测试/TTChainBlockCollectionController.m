//
//  TTChainBlockCollectionController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/6/11.
//

#import "TTChainBlockCollectionController.h"
#import "TTChainModel.h"
#import <SMChainBlocker/SMChainBlocker.h>

@interface TTChainBlockCollectionController ()
@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation TTChainBlockCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self dataArray];
    [self.view addSubview:self.collectionView];
    self.collectionView.sm_keyPathOfSubData(@"subArray");
    
    [self ansc_getData];
}

- (void)reload {
    self.collectionView.sm_cellDatas(self.dataArray)
    .sm_headerDatas(self.dataArray)
    .sm_reloadData();
}

- (void)ansc_getData {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self dataArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reload];
        });
    });
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
