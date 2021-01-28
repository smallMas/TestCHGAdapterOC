//
//  TTCollectionViewController.h
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/28.
//

#import "TTBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTCollectionViewController : TTBaseViewController

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

NS_ASSUME_NONNULL_END
