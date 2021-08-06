//
//  TTSudokuPropertyModel.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/7/23.
//

#import "TTSudokuPropertyModel.h"

@implementation TTSudokuPropertyModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _factorial = 9;
        self.selected = NO;
        self.bgColor = nil;
        self.idf = @"TTSudokuNumCell";
        self.font = [UIFont systemFontOfSize:17];
        self.size = CGSizeMake(FSJSCREENWIDTH/self.factorial, FSJSCREENWIDTH/self.factorial);
    }
    return self;
}

- (void)setFactorial:(NSInteger)factorial {
    _factorial = factorial;
    self.size = CGSizeMake(FSJSCREENWIDTH/self.factorial, FSJSCREENWIDTH/self.factorial);
}

#pragma mark - adapter
- (NSString *)cellClassNameInCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    return self.idf;
}

-(CGSize)chg_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.size;
}

@end
