//
//  TTLocalLibModel.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/31.
//

#import "TTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTLocalLibModel : TTBaseModel <CHGTableViewCellModelProtocol>
@property (strong, nonatomic) NSString *title;
@end

NS_ASSUME_NONNULL_END
