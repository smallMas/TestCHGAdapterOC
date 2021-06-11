//
//  TTChainModel.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/6/9.
//

#import "TTChainModel.h"

@implementation TTChainModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSInteger i = 3;//arc4random()%4;
        CGFloat w = FSJSCREENWIDTH/(i+1);
        self.size = kSize(w, w);
        self.bgColor = [UIColor fsj_randomColor];
    }
    return self;
}

#pragma mark - CHGTableViewCellModelProtocol

/**
 绑定一个cell 类
 
 @return 返回类名
 */
-(NSString*)cellClassNameInTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    return @"TTChainTableCell";
}

/**
 返回当前cell的高度
 
 @return cell、headerFooter的高度
 */
-(CGFloat)cellHeighInTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    return 44;
}

#pragma mark - CHGTableViewHeaderFooterModelProtocol
/**
 绑定一个cell、headerFooter 类
 
 @return 返回类名
 */
-(NSString*)headerFooterClassInTableView:(UITableView*)tableView section:(NSInteger)section type:(CHGAdapterViewType)type {
    return @"TChainHeaderView";
}

/**
 返回当前headerFooter的高度
 
 @return headerFooter的高度
 */
-(CGFloat)headerFooterHeighInTableView:(UITableView*)tableView section:(NSInteger)section type:(CHGAdapterViewType)type {
    return 30;
}
-(NSString*)subDataKeyPathWithIndexPath:(NSIndexPath*)indexPath tableView:(UITableView*)tableView {
    return @"subArray";
}

#pragma mark - CHGCollectionViewCellModelProtocol

-(NSString*)cellClassNameInCollectionView:(UICollectionView*)collectionView atIndexPath:(NSIndexPath*)indexPath {
    return @"TTChainCollectionCell";
}

- (CGSize)chg_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.size;
}

#pragma mark - CHGCollectionViewSupplementaryElementModelProtocol
- (NSString*)reusableViewInCollectionView:(UICollectionView*)collectionView supplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return @"TTChainCollectionHeaderView";
}

- (CGSize)chg_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return kSize(FSJSCREENWIDTH, 40);
}


///动态设置每个分区的EdgeInsets 不包括header和footer
- (UIEdgeInsets)chg_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 30, 0);
}

//动态设置每行的间距大小
- (CGFloat)chg_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;//self.lineSpacing;
}

//动态设置每列的间距大小
- (CGFloat)chg_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;//self.itemSpacing;
}

@end
