//
//  UICollectionView+SMBlocker.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/6/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (SMBlocker)

- (UICollectionView *(^)(NSString *))sm_keyPathOfSubData;

- (UICollectionView *(^)(NSArray *))sm_cellDatas;
- (UICollectionView *(^)(NSArray *))sm_headerDatas;
- (UICollectionView *(^)(NSArray *))sm_footerDatas;

- (UICollectionView *(^)(void))sm_reloadData;

@end

NS_ASSUME_NONNULL_END
