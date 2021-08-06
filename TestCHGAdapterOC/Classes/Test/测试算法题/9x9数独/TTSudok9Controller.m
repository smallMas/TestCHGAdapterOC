//
//  TTSudok9Controller.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/7/22.
//

#import "TTSudok9Controller.h"
#import "TTSudoku.h"
#import "TTSudokuPropertyModel.h"

@interface TTSudok9Controller ()
@property (strong, nonatomic) TTSudoku *sudoku;
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) TTSudokuPropertyModel *tmpModel;

@property (nonatomic, strong) UICollectionView *numCollectionView;
@property (strong, nonatomic) NSMutableArray *numArray;
@end

@implementation TTSudok9Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        kMakeLRV(0);
        kMakeTV(0);
        make.height.mas_equalTo(self.collectionView.mas_width);
    }];
    
    FSJ_WEAK_SELF
    self.collectionView.collectionViewDidSelectItemAtIndexPathBlock = ^(UICollectionView *collectionView, NSIndexPath *indexPath, id itemData) {
        FSJ_STRONG_SELF
        TTSudokuPropertyModel *model = itemData;
        self.tmpModel = model;
        [self selectedNum:model.num indexPath:indexPath];
    };
    
    [self.sudoku randomDataBlock:^(NSArray * _Nonnull array) {
        FSJ_STRONG_SELF
        [self handleArray:array];
        
        [self reloadData];
    }];
    
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
    [self reloadSelectData];
}

- (void)handleArray:(NSArray *)array {
    [self.dataSource removeAllObjects];
    
    [array enumerateObjectsUsingBlock:^(NSArray * _Nonnull arr, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *a = NSMutableArray.new;
        [arr enumerateObjectsUsingBlock:^(NSNumber *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TTSudokuPropertyModel *model = TTSudokuPropertyModel.new;
            model.num = obj;
            [a addObject:model];
        }];
        [self.dataSource addObject:a];
    }];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

- (TTSudoku *)sudoku {
    if (!_sudoku) {
        _sudoku = TTSudoku.new;
    }
    return _sudoku;
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

- (NSMutableArray *)numArray {
    if (!_numArray) {
        _numArray = NSMutableArray.new;
        for (int i = 1; i <= 9 ; i++) {
            TTSudokuPropertyModel *model = TTSudokuPropertyModel.new;
            model.num = @(i);
            model.size = CGSizeMake((FSJSCREENWIDTH-20)/9, 60);
            model.idf = @"TTSelectNumCell";
            [_numArray addObject:model];
        }
    }
    return _numArray;
}

- (void)reloadData {
    self.collectionView.cellDatas = self.dataSource;
    [self.collectionView reloadData];
}

- (void)reloadSelectData {
    self.numCollectionView.cellDatas = @[self.numArray];
    [self.numCollectionView reloadData];
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
                }else if ([self gongWithSection:idx row:idxx indexPath:indexPath]) {
                    // 宫
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

- (BOOL)gongWithSection:(NSInteger)section row:(NSInteger)row indexPath:(NSIndexPath *)indexPath {
    NSInteger currentS = indexPath.section;
    NSInteger currentR = indexPath.row;
    NSInteger s = 0;
    NSInteger r = 0;
    if (currentS < 3) {
        s = 3;
    }else if (currentS < 6) {
        s = 6;
    }else if (currentS < 9) {
        s = 9;
    }
    if (currentR < 3) {
        r = 3;
    }else if (currentR < 6) {
        r = 6;
    }else if (currentR < 9) {
        r = 9;
    }
    if (section >= s-3 && section < s && row >= r-3 && row < r) {
        return YES;
    }
    return NO;
}
    
- (void)fillNum:(NSNumber *)num {
    if (self.tmpModel) {
        self.tmpModel.num = num;
        [self reloadData];
    }
}

@end
