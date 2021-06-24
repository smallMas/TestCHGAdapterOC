//
//  TTFormModel.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/6/21.
//

#import "TTFormModel.h"

@implementation TTFormModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

#pragma mark - CHGCollectionViewCellModelProtocol
- (NSString*)cellClassNameInCollectionView:(UICollectionView*)collectionView atIndexPath:(NSIndexPath*)indexPath {
    return @"TTFormCell";
}

- (CGSize)chg_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.size;
}

@end
