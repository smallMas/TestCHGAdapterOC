//
//  TTCollectionViewController.h
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/28.
//

#import "TTBaseViewController.h"
#import "TTMainSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSString * _Nullable (^ TTCollectionClassStringBlock) (void);

@interface TTCollectionViewController : TTBaseViewController

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (copy, nonatomic) TTCollectionClassStringBlock clsBlock;

@property (strong, nonatomic) NSMutableArray *datasources;

@end

NS_ASSUME_NONNULL_END
