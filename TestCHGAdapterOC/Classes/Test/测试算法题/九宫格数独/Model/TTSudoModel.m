//
//  TTSudoModel.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/28.
//

#import "TTSudoModel.h"

@implementation TTSudoModel

+ (instancetype)createV:(NSInteger)value {
    TTSudoModel *model = [[self class] new];
    model.isHaveValue = YES;
    model.value = value;
    return model;
}

+ (instancetype)createNoV {
    TTSudoModel *model = [[self class] new];
    model.isHaveValue = NO;
    return model;
}

- (NSString *)showString {
    if (self.isHaveValue) {
        return [NSString stringWithFormat:@"%ld",(long)self.value];
    }else {
        if (self.result) {
            return [NSString stringWithFormat:@"%@",self.result];
        }else {
            return @"?";
        }
    }
}

- (void)setNumValue:(NSNumber *)value {
    self.value = value.intValue;
    self.result = value;
}

#pragma mark - adapter
- (NSString *)cellClassNameInCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    return @"TTSudoCollectionViewCell";
}

-(CGSize)chg_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.fsj_width/3.0, collectionView.fsj_width/3.0);
}

@end
