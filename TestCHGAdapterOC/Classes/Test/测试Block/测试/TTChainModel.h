//
//  TTChainModel.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/6/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTChainModel : NSObject <CHGTableViewCellModelProtocol,
CHGTableViewHeaderFooterModelProtocol,
CHGCollectionViewCellModelProtocol,
CHGCollectionViewSupplementaryElementModelProtocol>
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray <TTChainModel *>*subArray;

@property (assign, nonatomic) CGSize size;
@property (strong, nonatomic) UIColor *bgColor;
@end

NS_ASSUME_NONNULL_END
