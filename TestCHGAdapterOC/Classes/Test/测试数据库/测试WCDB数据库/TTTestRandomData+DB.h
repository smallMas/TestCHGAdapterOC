//
//  TTTestRandomData+DB.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/19.
//  https://www.jianshu.com/p/aeee3f38a084
//  https://www.bookstack.cn/read/tencent-wcdb/108727

#import "TTTestRandomData.h"
#import <WCDB/WCDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTTestRandomData (DB) <WCTTableCoding>

WCDB_PROPERTY(uuid)
WCDB_PROPERTY(randomNum)
WCDB_PROPERTY(name)

@end

NS_ASSUME_NONNULL_END
