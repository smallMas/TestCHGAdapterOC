//
//  UICollectionView+SMBlocker.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/6/11.
//

#import "UICollectionView+SMBlocker.h"
#import "CHGAdapter.h"

@implementation UICollectionView (SMBlocker)

- (UICollectionView *(^)(NSString *))sm_keyPathOfSubData {
    return ^(NSString *string) {
        self.collectionViewAdapter.keyPathOfSubData = string;
        return self;
    };
}

- (UICollectionView *(^)(NSArray *))sm_cellDatas {
    return ^(NSArray *datas) {
        self.cellDatas = datas;
        return self;
    };
}

- (UICollectionView *(^)(NSArray *))sm_headerDatas {
    return ^(NSArray *datas) {
        self.headerDatas = datas;
        return self;
    };
}

- (UICollectionView *(^)(NSArray *))sm_footerDatas {
    return ^(NSArray *datas) {
        self.footerDatas = datas;
        return self;
    };
}

- (UICollectionView *(^)(void))sm_reloadData {
    return ^(void){
        [self reloadData];
        return self;
    };
}
@end
