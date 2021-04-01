//
//  TTWCDBService.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/19.
//

#import "TTWCDBService.h"

@interface TTWCDBService ()

@end

@implementation TTWCDBService
@synthesize database = _database;

+ (instancetype)manager {
    static TTWCDBService *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [TTWCDBService new];
    });
    return manager;
}

- (NSString *)dbPath {
    NSString *documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *cachePath = [documentsPath stringByAppendingPathComponent:@"Cache"];
    NSString *path = [cachePath stringByAppendingPathComponent:@"TTWCDB"];
    
    return path;
}

- (WCTDatabase *)database {
    if (!_database) {
        _database = [[WCTDatabase alloc] initWithPath:[[self dbPath] stringByAppendingString:@"/TTWCDB.db"]];
    }
    return _database;
}

//- (BOOL)createDB {
////    _database = [[WCTDatabase alloc] initWithPath:[_HYBIRD_PATH_USER stringByAppendingFormat:@"/%@/TTWCDB.db",kUSER.userId ?: @"visitor"]];
//    _database = [[WCTDatabase alloc] initWithPath:[[self dbPath] stringByAppendingString:@"/TTWCDB.db"]];
//    //测试数据库是否能够打开
//    if ([_database canOpen]) {
//        // WCDB大量使用延迟初始化（Lazy initialization）的方式管理对象，因此SQLite连接会在第一次被访问时被打开。开发者不需要手动打开数据库。
//        // 先判断表是不是已经存在
////        if ([self.database isOpened]) {
////            if ([self.database isTableExists:kIMTABLE_NAME]) {
////                KLLog(@"IMUSERData表已存在");
////                return NO;
////            }else{
////                return [_database createTableAndIndexesOfName:kIMTABLE_NAME withClass:IMUSERData.class];
////            }
////        }
//    }
//    return NO;
//}

- (WCTDatabase *)db:(NSObject *)object {
    TTWCDBService *dm = [TTWCDBService manager];
    WCTDatabase *database = dm.database;
    if ([database isOpened]) {
        NSString *tableName = NSStringFromClass([object class]);
        if ([database isTableExists:tableName]) {
            NSLog(@"%@表已存在",tableName);
        }else{
            NSLog(@"创建%@表",tableName);
            [database createTableAndIndexesOfName:tableName withClass:self.class];
        }
    }
    return database;
}

- (void)insertData:(NSObject *)object {
    WCTDatabase *db = [self db:object];
    NSString *tableName = NSStringFromClass([object class]);
    [db insertOrReplaceObject:object into:tableName];
}

@end
