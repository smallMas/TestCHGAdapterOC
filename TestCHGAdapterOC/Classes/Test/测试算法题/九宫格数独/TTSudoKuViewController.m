//
//  TTSudoKuViewController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/28.
//

#import "TTSudoKuViewController.h"
#import "TTSudoCalculateUtility.h"

@interface TTSudoKuViewController ()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation TTSudoKuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(300);
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(self.view);
    }];
    
    FSJ_WEAK_SELF
    self.collectionView.collectionViewDidSelectItemAtIndexPathBlock = ^(UICollectionView *collectionView, NSIndexPath *indexPath, id itemData) {
        FSJ_STRONG_SELF
        TTSudoModel *model = itemData;
        if (!model.isHaveValue && !model.result) {
            NSNumber *value = [TTSudoCalculateUtility valueForArray:self.dataArray];
            [model setNumValue:value];
            [self reloadData];
        }
    };
    
    [self reloadData];
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
            @[[TTSudoModel createNoV],[TTSudoModel createV:10],[TTSudoModel createV:28]],
            @[[TTSudoModel createV:6],[TTSudoModel createV:15],[TTSudoModel createV:36]],
            @[[TTSudoModel createV:3],[TTSudoModel createV:3],[TTSudoModel createV:9]],
        ];
    }
    return _dataArray;
}

- (void)reloadData {
    self.collectionView.cellDatas = self.dataArray;
    [self.collectionView reloadData];
}

@end
