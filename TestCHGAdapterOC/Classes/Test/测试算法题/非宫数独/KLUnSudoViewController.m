//
//  KLUnSudoViewController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/8/3.
//

#import "KLUnSudoViewController.h"
#import "TTUnSudoku.h"
#import "TTSudokuPropertyModel.h"
#import "TTRotaryViewController.h"

@interface KLUnSudoViewController ()
@property (strong, nonatomic) TTUnSudoku *sudo;
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (nonatomic, strong) UICollectionView *numCollectionView;
@property (strong, nonatomic) NSMutableArray *numArray;

@property (strong, nonatomic) TTSudokuPropertyModel *tmpModel;
@end

@implementation KLUnSudoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.index == 0) {
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Seleted" style:UIBarButtonItemStyleDone target:self action:@selector(selectedAction:)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }else {
        self.sudo.factorial = self.index;
    }
    
    FSJ_WEAK_SELF
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        kMakeLRV(0);
        kMakeTV(0);
        make.height.mas_equalTo(self.collectionView.mas_width);
    }];
    
    self.collectionView.collectionViewDidSelectItemAtIndexPathBlock = ^(UICollectionView *collectionView, NSIndexPath *indexPath, id itemData) {
        FSJ_STRONG_SELF
        TTSudokuPropertyModel *model = itemData;
        model.indexPath = indexPath;
        self.tmpModel = model;
        [self selectedNum:model.num indexPath:indexPath];
    };
    
    [self.view addSubview:self.numCollectionView];
    [self.numCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        kMakeLV(10);
        kMakeRV(-10);
        kMakeT(self.collectionView.mas_bottom).offset(15);
        kMakeHV((FSJSCREENWIDTH-20)/9);
    }];
    self.numCollectionView.collectionViewDidSelectItemAtIndexPathBlock = ^(UICollectionView *collectionView, NSIndexPath *indexPath, id itemData) {
        FSJ_STRONG_SELF
        TTSudokuPropertyModel *model = itemData;
        [self fillNum:model.num];
    };
    [self resetData];
}

#pragma mark - 懒加载
- (TTUnSudoku *)sudo {
    if (!_sudo) {
        _sudo = TTUnSudoku.new;
    }
    return _sudo;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

- (NSMutableArray *)numArray {
    if (!_numArray) {
        _numArray = NSMutableArray.new;
    }
    return _numArray;
}

- (UICollectionView *)numCollectionView {
    if (!_numCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // cell的行边距[ = ](上下边距)
        layout.minimumLineSpacing = 0.0f;
        // cell的纵边距[ || ](左右边距)
        layout.minimumInteritemSpacing = 0.0f;
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _numCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _numCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_numCollectionView setBackgroundColor:[UIColor clearColor]];
    }
    return _numCollectionView;
}

#pragma mark - EVENT
- (void)selectedAction:(id)sender {
    FSJ_WEAK_SELF
    FSJAlertSheetView *sheetView = [[FSJAlertSheetView alloc] initWithTitle:@"选择" message:@"" style:UIAlertControllerStyleActionSheet cancelButtonTitle:@"取消" otherButtonTitles:@"3x3",@"4x4",@"5x5", nil];
    [sheetView show:^(NSInteger index) {
        FSJ_STRONG_SELF
        if (index > 0) {
            if (index == 1) {
                self.sudo.factorial = 3;
            }else if (index == 2) {
                self.sudo.factorial = 4;
            }else if (index == 3) {
                self.sudo.factorial = 5;
            }
            [self resetData];
        }
    }];
}

#pragma mark - 内部方法
- (void)updateTitle {
    NSString *str = kStringFormat(@"%dX%d",(int)self.sudo.factorial,(int)self.sudo.factorial);
    self.title = str;
}

- (void)resetData {
    self.tmpModel = nil;
    
    [self.numArray removeAllObjects];
    int count = (int)self.sudo.factorial;
    for (int i = 1; i <= count ; i++) {
        TTSudokuPropertyModel *model = TTSudokuPropertyModel.new;
        model.num = @(i);
        model.size = CGSizeMake((FSJSCREENWIDTH-20)/count, 60);
        model.idf = @"TTSelectNumCell";
        model.font = [UIFont systemFontOfSize:34];
        [self.numArray addObject:model];
    }
    
    FSJ_WEAK_SELF
    [self.sudo randomDataBlock:^(NSArray * _Nonnull array) {
        FSJ_STRONG_SELF
        [self handleArray:array];
        
        [self reloadData];
    }];
    
    [self updateTitle];
}

- (void)handleArray:(NSArray *)array {
    [self.dataSource removeAllObjects];
    
    FSJ_WEAK_SELF
    [array enumerateObjectsUsingBlock:^(NSArray * _Nonnull arr, NSUInteger idx, BOOL * _Nonnull stop) {
        FSJ_STRONG_SELF
        NSMutableArray *a = NSMutableArray.new;
        [arr enumerateObjectsUsingBlock:^(NSNumber *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TTSudokuPropertyModel *model = TTSudokuPropertyModel.new;
            model.font = [UIFont systemFontOfSize:28];
            model.num = obj;
            model.factorial = self.sudo.factorial;
            [a addObject:model];
        }];
        [self.dataSource addObject:a];
    }];
}

- (void)reloadData {
    self.collectionView.cellDatas = self.dataSource;
    [self.collectionView reloadData];
    
    [self reloadSelectData];
}

- (void)reloadSelectData {
    self.numCollectionView.cellDatas = @[self.numArray];
    [self.numCollectionView reloadData];
}

- (void)fillNum:(NSNumber *)num {
    if (self.tmpModel) {
        self.tmpModel.num = num;
        if (![self judgeIsCorrect]) {
            [self showError];
        }else {
            [self reloadData];
            if ([self isSuccess]) {
                FSJAlertSheetView *alert = [[FSJAlertSheetView alloc] initWithTitle:@"提示" message:@"恭喜你获得一次抽奖活动" style:UIAlertControllerStyleAlert cancelButtonTitle:@"放弃" otherButtonTitles:@"去抽奖", nil];
                [alert show:^(NSInteger index) {
                    if (index == 1) {
                        // 完成
                        TTRotaryViewController *vc = [TTRotaryViewController new];
                        [self.navigationController pushViewController:vc animated:YES];
                    }else {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }];
            }
        }
    }
}

- (void)showError {
    FSJ_WEAK_SELF
    FSJAlertSheetView *alert = [[FSJAlertSheetView alloc] initWithTitle:@"错误" message:@"请仔细思考" style:UIAlertControllerStyleAlert cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show:^(NSInteger index) {
        FSJ_STRONG_SELF
        self.tmpModel.num = @(0);
    }];
}

- (void)selectedNum:(NSNumber *)num indexPath:(NSIndexPath *)indexPath {
    [self.dataSource enumerateObjectsUsingBlock:^(NSArray * _Nonnull arr, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL isLine = idx == indexPath.section;
        [arr enumerateObjectsUsingBlock:^(TTSudokuPropertyModel *  _Nonnull obj, NSUInteger idxx, BOOL * _Nonnull stop) {
            if (num.intValue > 0) {
                // 已经有值了,将所有相同的值颜色都是选中颜色  #F8C882
                if (num.intValue == obj.num.intValue) {
                    obj.bgColor = @"#F8C882";
                }else {
                    obj.bgColor = nil;
                }
            }else {
                // 还没有值，将选中的行，列，宫全部高亮 #F9EBD2
                if (isLine) {
                    // 行
                    obj.bgColor = @"#F9EBD2";
                }else if (idxx == indexPath.row) {
                    // 列
                    obj.bgColor = @"#F9EBD2";
                }else {
                    obj.bgColor = nil;
                }
            }

            if (isLine && idxx == indexPath.row) {
                obj.selected = YES;
                obj.bgColor = @"#F8C882";
            }else {
                obj.selected = NO;
            }
        }];
    }];
    
    [self reloadData];
}

- (BOOL)judgeIsCorrect {
    __block BOOL is = YES;
    if (self.tmpModel) {
        NSIndexPath *indexPath = self.tmpModel.indexPath;
        [self.dataSource enumerateObjectsUsingBlock:^(NSArray * _Nonnull arr, NSUInteger idx, BOOL * _Nonnull stop) {
            BOOL isLine = idx == indexPath.section;
            [arr enumerateObjectsUsingBlock:^(TTSudokuPropertyModel *  _Nonnull obj, NSUInteger idxx, BOOL * _Nonnull stop2) {
                if (isLine) {
                    if (idxx != indexPath.row) {
                        // 行
                        if (self.tmpModel.num == obj.num) {
                            is = NO;
                        }
                    }
                }else if (idxx == indexPath.row) {
                    // 列
                    if (self.tmpModel.num == obj.num) {
                        is = NO;
                    }
                }
                if (!is) {
                    *stop2 = YES;
                }
            }];
            if (!is) {
                *stop = YES;
            }
        }];
    }
    return is;
}

- (BOOL)isSuccess {
    __block BOOL is = YES;
    [self.dataSource enumerateObjectsUsingBlock:^(NSArray * _Nonnull arr, NSUInteger idx, BOOL * _Nonnull stop) {
        [arr enumerateObjectsUsingBlock:^(TTSudokuPropertyModel *  _Nonnull obj, NSUInteger idxx, BOOL * _Nonnull stop2) {
            if (obj.num.intValue == 0) {
                is = NO;
            }
            if (!is) {
                *stop2 = YES;
            }
        }];
        if (!is) {
            *stop = YES;
        }
    }];
    return is;
}

@end
