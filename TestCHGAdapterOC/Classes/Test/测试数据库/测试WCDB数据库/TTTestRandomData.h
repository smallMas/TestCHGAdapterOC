//
//  TTTestRandomData.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/19.
//

#import "TTWCDBBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTTestRandomData : TTWCDBBase <CHGTableViewCellModelProtocol>
@property (strong, nonatomic) NSString *uuid;
@property (strong, nonatomic) NSString *randomNum;
@property (strong, nonatomic) NSString *name;
@end


NS_ASSUME_NONNULL_END
