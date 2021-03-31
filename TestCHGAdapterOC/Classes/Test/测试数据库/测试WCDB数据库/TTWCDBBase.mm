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
            }else{
                NSLog(@"创建%@表",tableName);
                [database createTableAndIndexesOfName:tableName withClass:self.class];
            }
        }
    }
    
    return database;
}

+ (BOOL)insertToDatabase:(TTWCDBBase *)data {
//    NSArray *arr = [[self class] AllProperties];
    
    
    NSString *tableName = NSStringFromClass([self class]);
    return [[self database] insertOrReplaceObject:data into:tableName];
}

@end
