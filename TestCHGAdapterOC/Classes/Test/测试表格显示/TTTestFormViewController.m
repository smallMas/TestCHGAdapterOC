//
//  TTTestFormViewController.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/6/21.
//

#import "TTTestFormViewController.h"
#import "TTChainModel.h"
#import <SMChainBlocker/SMChainBlocker.h>
#import "TTFormCollectionView.h"
#import "TTFormScrollView.h"

#import "TTFormView.h"
#import "TTFormModel.h"

@interface TTTestFormViewController ()
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (weak, nonatomic) TTFormScrollView *scrollView;
@property (strong, nonatomic) TTFormCollectionView *collectionView;
@property (weak, nonatomic) UIView *containerView;
@property (weak, nonatomic) UIView *subView;

@property (weak, nonatomic) TTFormView *formView;

@end

@implementation TTTestFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self initData];
//
//    self.collectionView.sm_cellDatas(@[self.dataArray]).sm_reloadData();
    
//    [self containerView];
//    [self subView];
    
    [self initData];
}

//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    self.scrollView.contentSize = self.collectionView.frame.size;
//}

//- (TTFormScrollView *)scrollView {
//    if (!_scrollView) {
//        TTFormScrollView *obj = TTFormScrollView.new;
//        [self.view addSubview:_scrollView = obj];
//        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
////            kMakeEdge0;
//            make.edges.mas_equalTo(self.view);
//        }];
//        obj.bounces = NO;
//    }
//    return _scrollView;
//}
//
//- (UIView *)containerView {
//    if (!_containerView) {
//        UIView *obj = [UIView new];
//        [self.scrollView addSubview:_containerView = obj];
//        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
//            kMakeEdge0;
//            kMakeWV(FSJSCREENWIDTH*2);
////            make.edges.mas_equalTo(self.scrollView);
////            make.width.mas_equalTo(self.scrollView);
//        }];
//        [obj setBackgroundColor:[UIColor fsj_randomColor]];
//    }
//    return _containerView;
//}
//
//- (UIView *)subView {
//    if (!_subView) {
//        UIView *obj = [UIView new];
//        [self.containerView addSubview:_subView = obj];
//        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.containerView);
//            make.left.right.equalTo(self.containerView);//左右约束
//            make.height.mas_equalTo(40);
//            make.bottom.equalTo(self.containerView);//这个不能忘记
//        }];
//        [obj setBackgroundColor:[UIColor redColor]];
//    }
//    return _subView;
//}
//
//- (TTFormCollectionView *)collectionView {
//    if (!_collectionView) {
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        // cell的行边距[ = ](上下边距)
//        layout.minimumLineSpacing = 0.0f;
//        // cell的纵边距[ || ](左右边距)
//        layout.minimumInteritemSpacing = 0.0f;
//        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
//        TTFormCollectionView *obj = [[TTFormCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//        [self.scrollView addSubview:_collectionView = obj];
//        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
////            kMakeLV(0);
////            kMakeTV(0);
////            kMakeBV(0);
//            make.edges.equalTo(self.scrollView);
//            kMakeWV(FSJSCREENWIDTH*2);
//            kMakeHV(FSJSCREENHEIGHT-FSJSafeAreaEdgeInsets.top-44);
//        }];
//        obj.showsHorizontalScrollIndicator = NO;
//        [obj setBackgroundColor:[UIColor clearColor]];
//        obj.bounces = NO;
//    }
//    return _collectionView;
//}
//
//- (void)initData {
//    for (NSInteger i = 0; i < 100; i++) {
//        TTChainModel *model = TTChainModel.new;
//        model.name = [NSString stringWithFormat:@"name : %ld",(long)i];
//        [self.dataArray addObject:model];
//    }
//}
//
//- (NSMutableArray *)dataArray {
//    if (!_dataArray) {
//        _dataArray = NSMutableArray.new;
//    }
//    return _dataArray;
//}

// -----------------------
- (TTFormView *)formView {
    if (!_formView) {
        TTFormView *obj = TTFormView.new;
        [self.view addSubview:_formView = obj];
        
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeEdge0;
        }];
    }
    return _formView;
}

- (void)initData {
    NSMutableArray *topArray = NSMutableArray.new;
    [topArray addObject:[self createFormModel:@"消息名称" w:100]];
    [topArray addObject:[self createFormModel:@"场景" w:120]];
    [topArray addObject:[self createFormModel:@"类型" w:80]];
    [topArray addObject:[self createFormModel:@"跳转界面" w:150]];
    [topArray addObject:[self createFormModel:@"参数" w:80]];
    
    NSMutableArray *leftArray = NSMutableArray.new;
    NSMutableArray *contentArray = NSMutableArray.new;
    for (NSInteger i = 1; i < 100; i++) {
        [leftArray addObject:[self createFormModel:kStringFormat(@"%d",i) w:50]];
        for (NSInteger j = 0; j < topArray.count; j++) {
            TTFormModel *tm = topArray[j];
            NSString *name = kStringFormat(@"%ld行%ld列",(long)i,j+1);
            [contentArray addObject:[self createFormModel:name w:tm.size.width]];
        }
    }
    
    CGFloat l_w = 50;
    CGFloat t_h = 50;
    CGFloat c_w = 0;
    for (TTFormModel *tm in topArray) {
        c_w += tm.size.width;
    }
    self.formView.l_w = l_w;
    self.formView.t_h = t_h;
    self.formView.c_w = c_w;
    self.formView.leftCornerValue = @"序号";
    self.formView.menuColor = [UIColor grayColor];
    [self.formView setLeftMenu:leftArray topMenu:topArray contents:contentArray];
}

- (TTFormModel *)createFormModel:(NSString *)title w:(CGFloat)w {
    TTFormModel *model = TTFormModel.new;
    model.title = title;
    model.size = kSize(w, 50);
    return model;
}

@end
