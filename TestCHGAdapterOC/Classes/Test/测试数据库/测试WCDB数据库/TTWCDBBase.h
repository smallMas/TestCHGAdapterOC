//
//  TTWCDBBase.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTWCDBBase : NSObject
+ (id)database;
+ (NSString *)tableName;

#pragma mark - 插入
+ (BOOL)insertToDatabase:(TTWCDBBase *)data;

#pragma mark - 查询
+ (NSArray *)selectedAllData;

@end

NS_ASSUME_NONNULL_END
