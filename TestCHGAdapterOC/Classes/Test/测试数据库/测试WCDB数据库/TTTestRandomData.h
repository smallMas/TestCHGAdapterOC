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

#pragma mark - 删除
+ (BOOL)deleteDataWithuuid:(NSString *)uuid;

#pragma mark - 修改
+ (BOOL)updateName:(TTTestRandomData *)data;
@end


NS_ASSUME_NONNULL_END
