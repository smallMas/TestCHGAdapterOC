//
//  TTFormView.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/6/21.
//

#import "TTFormView.h"
#import "TTFormScrollView.h"
#import "TTFormCollectionView.h"

@interface TTFormView () <CHGScrollViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) TTFormScrollView *scrollView;
@property (strong, nonatomic) TTFormCollectionView *collectionView;
@property (strong, nonatomic) TTFormCollectionView *lView;
@property (strong, nonatomic) TTFormCollectionView *tView;
@property (weak, nonatomic) UILabel *leftCornerLab;
@end

@implementation TTFormView

- (TTFormScrollView *)scrollView {
    if (!_scrollView) {
        TTFormScrollView *obj = TTFormScrollView.new;
        [self addSubview:_scrollView = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeL(self.tView);
            kMakeT(self.tView.mas_bottom);
            kMakeBV(0);
            kMakeRV(0);
        }];
        obj.bounces = NO;
        obj.delegate = self;
    }
    return _scrollView;
}

- (UILabel *)leftCornerLab {
    if (!_leftCornerLab) {
        UILabel *obj = [UILabel new];
        obj.font = [UIFont systemFontOfSize:16];
        [self addSubview:_leftCornerLab = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeLTV(0);
            kMakeWHV(self.l_w, self.t_h);
        }];
        obj.numberOfLines = 0;
        obj.textAlignment = NSTextAlignmentCenter;
        obj.text = self.leftCornerValue;
        obj.backgroundColor = self.menuColor;
    }
    return _leftCornerLab;
}

- (TTFormCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // cell的行边距[ = ](上下边距)
        layout.minimumLineSpacing = 0.0f;
        // cell的纵边距[ || ](左右边距)
        layout.minimumInteritemSpacing = 0.0f;
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        TTFormCollectionView *obj = [[TTFormCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.scrollView addSubview:_collectionView = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.scrollView);
            kMakeWV(self.c_w);
            kMakeB(self);
//            kMakeHV(FSJSCREENHEIGHT-FSJSafeAreaEdgeInsets.top-44);
        }];
        obj.showsHorizontalScrollIndicator = NO;
        [obj setBackgroundColor:[UIColor clearColor]];
        obj.bounces = NO;
        [obj addCHGScrollViewDelegate:self];
    }
    return _collectionView;
}

- (TTFormCollectionView *)lView {
    if (!_lView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // cell的行边距[ = ](上下边距)
        layout.minimumLineSpacing = 0.0f;
        // cell的纵边距[ || ](左右边距)
        layout.minimumInteritemSpacing = 0.0f;
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        TTFormCollectionView *obj = [[TTFormCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_lView = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeT(self.leftCornerLab.mas_bottom);
            kMakeLV(0);
            kMakeBV(0);
            kMakeWV(self.l_w);
        }];
        obj.showsHorizontalScrollIndicator = NO;
        [obj setBackgroundColor:[UIColor clearColor]];
        obj.bounces = NO;
        obj.backgroundColor = self.menuColor;
        obj.showsVerticalScrollIndicator = NO;
        
        [obj addCHGScrollViewDelegate:self];
    }
    return _lView;
}

- (TTFormCollectionView *)tView {
    if (!_tView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // cell的行边距[ = ](上下边距)
        layout.minimumLineSpacing = 0.0f;
        // cell的纵边距[ || ](左右边距)
        layout.minimumInteritemSpacing = 0.0f;
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        TTFormCollectionView *obj = [[TTFormCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_tView = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeTV(0);
            kMakeL(self.lView.mas_right);
            kMakeRV(0);
            kMakeHV(self.t_h);
        }];
        obj.showsHorizontalScrollIndicator = NO;
        [obj setBackgroundColor:[UIColor clearColor]];
        obj.bounces = NO;
        obj.backgroundColor = self.menuColor;
        
        [obj addCHGScrollViewDelegate:self];
    }
    return _tView;
}

- (void)setLeftCornerValue:(NSString *)leftCornerValue {
    _leftCornerValue = leftCornerValue;
    if (_leftCornerLab) {
        _leftCornerLab.text = leftCornerValue;
    }
}

- (void)setMenuColor:(UIColor *)menuColor {
    _menuColor = menuColor;
    if (_lView) {
        _lView.backgroundColor = menuColor;
    }
    if (_tView) {
        _tView.backgroundColor = menuColor;
    }
}

- (void)setLeftMenu:(NSArray *)leftMenu topMenu:(NSArray *)topMenu contents:(NSArray *)contents {
    self.lView.cellDatas = leftMenu?@[leftMenu]:nil;
    
    self.tView.cellDatas = topMenu?@[topMenu]:nil;
    
    self.collectionView.cellDatas = contents?@[contents]:nil;
    
    NSLog(@"lView : %@ tView : %@ collectionView : %@",self.lView,self.tView,self.collectionView);
}

#pragma mark - CHGScrollViewDelegate
- (void)chg_scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.collectionView) {
        // 同步左边菜单 y
        self.lView.contentOffset = CGPointMake(self.lView.contentOffset.x, scrollView.contentOffset.y);
    }else if (scrollView == self.lView) {
        // 同步数据 y
        self.collectionView.contentOffset = CGPointMake(self.collectionView.contentOffset.x, scrollView.contentOffset.y);
    }else if (scrollView == self.tView) {
        // 同步数据 x
        self.scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, self.collectionView.contentOffset.y);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        // 同步上菜单 x
        self.tView.contentOffset = CGPointMake(scrollView.contentOffset.x, self.tView.contentOffset.y);
    }
}

@end
