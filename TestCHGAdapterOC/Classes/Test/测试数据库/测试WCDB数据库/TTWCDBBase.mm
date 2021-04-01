//
//  TTWCDBBase.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/19.
//

#import "TTWCDBBase.h"
#import "TTWCDBService.h"

@interface TTWCDBBase () <WCTTableCoding>

@end

@implementation TTWCDBBase

+ (WCTDatabase *)database {
    TTWCDBService *dm = [TTWCDBService manager];
    WCTDatabase *database = dm.database;
    if (database && [database canOpen]) {
        if ([database isOpened]) {
            NSString *tableName = NSStringFromClass([self class]);
            if ([database isTableExists:tableName]) {
                NSLog(@"%@表已存在",tableName);
                BOOL is = [database createTableAndIndexesOfName:tableName withClass:self.class];
                NSLog(@"is >>> %d",is);
            }else{
                NSLog(@"创建%@表",tableName);
                [database createTableAndIndexesOfName:tableName withClass:self.class];
            }
        }
    }
    
    return database;
}

+ (NSString *)tableName {
    NSString *tableName = NSStringFromClass([self class]);
    return tableName;
}

#pragma mark - 插入
+ (BOOL)insertToDatabase:(TTWCDBBase *)data {
    NSString *tableName = [self tableName];
    return [[self database] insertOrReplaceObject:data into:tableName];
}

#pragma mark - 查询
+ (NSArray *)selectedAllData {
    return [[self database] getAllObjectsOfClass:self.class fromTable:[self tableName]];
}

@end
