//
//  TTHomeBaseModel.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/8/6.
//

#import "TTHomeBaseModel.h"

@implementation TTHomeLayout

- (instancetype)init{
    if (self = [super init]) {
        self.itemSize = CGSizeMake(FSJSCREENWIDTH, 44.f);
    }
    return self;
}

@end


@implementation TTHomeBaseModel

- (TTHomeLayout *)layout{
    if (!_layout) _layout = [[TTHomeLayout alloc] init];
    return _layout;
}

- (NSString *)idf{
    if (self.idfBlock) return self.idfBlock();
    NSAssert(0, @"未知类型cell标识符");
    return nil;
}

#pragma mark - CHGCollectionViewCellModelProtocol
- (NSString *)cellClassNameInCollectionView:(UICollectionView*)collectionView atIndexPath:(NSIndexPath*)indexPath {
    return self.idf;
}

- (CGSize)chg_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.layout.itemSize;
}

@end
