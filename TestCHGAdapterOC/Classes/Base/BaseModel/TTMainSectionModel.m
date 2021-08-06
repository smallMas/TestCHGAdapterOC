//
//  TTMainSectionModel.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/8/6.
//

#import "TTMainSectionModel.h"

@implementation TTMainSectionModel

/** header  */
+ (instancetype)sectionWithHeaderModel:(__kindof TTHomeBaseModel *)model {
    return [self sectionWithHeader:model footer:nil];
}
/** footer  */
+ (instancetype)sectionWithHeader:(__kindof TTHomeBaseModel *_Nullable)head footer:(__kindof TTHomeBaseModel *_Nullable)footer {
    TTMainSectionModel *m = TTMainSectionModel.new;
    m.h_model = head;
    m.f_model = footer;
    return m;
}

- (void)sectionInsets:(UIEdgeInsets)insets ls:(CGFloat)ls is:(CGFloat)is{
    _sectionInsets = insets;
    _lineSpacing   = ls;
    _itemSpacing   = is;
}

- (NSMutableArray *)items{
    if (!_items)_items = NSMutableArray.array;
    return _items;
}

#pragma mark - CHGCollectionViewSupplementaryElementModelProtocol
- (NSString*)reusableViewInCollectionView:(UICollectionView*)collectionView supplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    TTMainSectionModel *s = self;
    TTHomeBaseModel *obj = s.h_modelBlock ? s.h_modelBlock(s) : s.h_model;
    return obj.idf?obj.idf:@"CHGCollectionReusableView";
}

///动态设置某个分区头视图大小
- (CGSize)chg_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    do {
        TTMainSectionModel *s = self;
        if (!s) break;
        TTHomeBaseModel *obj = s.h_modelBlock ? s.h_modelBlock(s) : s.h_model;
        return obj ? obj.layout.itemSize : CGSizeZero;
    } while (0);
    return CGSizeZero;
}

//动态设置某个分区尾视图大小
- (CGSize)chg_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    TTMainSectionModel *s = self;
    TTHomeBaseModel *obj = s.f_modelBlock ? s.f_modelBlock(s) : s.f_model;
    return obj ? obj.layout.itemSize : CGSizeZero;
}

///动态设置每个分区的EdgeInsets 不包括header和footer
- (UIEdgeInsets)chg_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    TTMainSectionModel *s = self;
    if (s.sectionInsetsBlock) {
        return s.sectionInsetsBlock(s);
    }else{
        return s.sectionInsets;
    }
}

//动态设置每行的间距大小
- (CGFloat)chg_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.lineSpacing;
}

//动态设置每列的间距大小
- (CGFloat)chg_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.itemSpacing;
}

@end
