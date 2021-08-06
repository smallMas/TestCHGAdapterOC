//
//  TTHomeBaseModel.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/8/6.
//

#import "TTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTHomeLayout : NSObject
/** item大小  */
@property (assign, nonatomic) CGSize itemSize;

@end


@interface TTHomeBaseModel : TTBaseModel <CHGCollectionViewCellModelProtocol>

@property (strong, nonatomic) TTHomeLayout *layout;
/** 重用标识符  */
@property (readonly, nonatomic) NSString *idf;
@property (copy, nonatomic) NSString *(^idfBlock)(void);
@end

NS_ASSUME_NONNULL_END
