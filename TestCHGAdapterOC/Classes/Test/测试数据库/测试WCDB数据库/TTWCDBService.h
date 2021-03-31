//
//  TTWCDBService.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/19.
//

#import <Foundation/Foundation.h>
#import <WCDB/WCDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTWCDBService : NSObject
@property (strong, nonatomic, readonly) WCTDatabase *database;
+ (instancetype)manager;
- (void)insertData:(NSObject *)object;
@end

NS_ASSUME_NONNULL_END
