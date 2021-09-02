//
//  TTHomeViewController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/8/6.
//

#import "TTHomeViewController.h"
#import "TTHomeMenuModel.h"
#import "KLUnSudoViewController.h"
#import "TTRotaryViewController.h"
#import "TTTetrisViewController.h"

@interface TTHomeViewController ()
@property (weak, nonatomic) UIImageView *bgView;
@end

@implementation TTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bgView];
    
    [self.view addSubview:self.collectionView];
    
    FSJ_WEAK_SELF
    self.collectionView.collectionViewDidSelectItemAtIndexPathBlock = ^(UICollectionView *collectionView, NSIndexPath *indexPath, id itemData) {
        FSJ_STRONG_SELF
        TTHomeMenuModel *model = itemData;
        if (model.type == 4) {
            // 幸运大转盘
            TTRotaryViewController *vc = [TTRotaryViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (model.type == 5) {
            // 俄罗斯方块
            TTTetrisViewController *vc = [TTTetrisViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            KLUnSudoViewController *vc = KLUnSudoViewController.new;
            vc.index = indexPath.row+3;
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    
    TTMainSectionModel *s = TTMainSectionModel.new;
    [s sectionInsets:kEdge(50, 0, 50, 0) ls:50 is:0];
    
    [s.items addObject:[self creaetTitle:@"3X3" type:0 color:@"#00FA9A"]];
    [s.items addObject:[self creaetTitle:@"4X4" type:1 color:@"#B8860B"]];
    [s.items addObject:[self creaetTitle:@"5X5" type:2 color:@"#FF4500"]];
    [s.items addObject:[self creaetTitle:@"6X6" type:3 color:@"#00BFFF"]];
//    [s.items addObject:[self creaetTitle:@"幸运大转盘" type:4 color:nil]];
    [s.items addObject:[self creaetTitle:@"俄罗斯方块" type:5 color:nil]];
    
    [self handleItems:s.items];
    
    [self.datasources addObject:s];
    
    [self reloadData];
}

- (void)handleItems:(NSArray <TTHomeMenuModel *>*)items {
    [items enumerateObjectsUsingBlock:^(TTHomeMenuModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.index = idx;
    }];
}

- (void)reloadData {
    self.collectionView.collectionViewAdapter.keyPathOfSubData = @"items";
    self.collectionView.cellDatas = self.datasources;
    self.collectionView.headerDatas = self.datasources;
    [self.collectionView reloadData];
    
    [self.collectionView layoutIfNeeded];
    [self animateCollection];
}

- (void)animateCollection{
    NSArray *cells = self.collectionView.visibleCells;
    CGFloat collectionHeight = self.collectionView.bounds.size.height;
    for (UICollectionViewCell *cell in cells.objectEnumerator) {
        cell.alpha = 1.0f;
        cell.transform = CGAffineTransformMakeTranslation(0, collectionHeight);
        NSUInteger index = [cells indexOfObject:cell];
        [UIView animateWithDuration:0.7f delay:0.05*index usingSpringWithDamping:0.6 initialSpringVelocity:0 options:0 animations:^{
            cell.transform =  CGAffineTransformMakeTranslation(0, 0);
        } completion:nil];
    }
}
- (TTHomeMenuModel *)creaetTitle:(NSString *)title type:(NSInteger)type color:(NSString *)color {
    TTHomeMenuModel *model = TTHomeMenuModel.new;
    model.title = title;
    model.type = type;
    if (color) model.bgColor = [UIColor fsj_colorWithHexString:color];
    return model;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (UIImageView *)bgView {
    if (!_bgView) {
        UIImageView *obj = [UIImageView new];
        [self.view addSubview:_bgView = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeEdge0;
        }];
        obj.image = [UIImage imageNamed:@"首页_背景"];
        obj.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgView;
}

@end
