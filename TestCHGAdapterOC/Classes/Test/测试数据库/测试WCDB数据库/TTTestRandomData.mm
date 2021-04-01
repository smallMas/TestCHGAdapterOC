//
//  TTTestRandomData.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/19.
//

#import "TTTestRandomData.h"
#import "TTTestRandomData+DB.h"

@implementation TTTestRandomData
WCDB_IMPLEMENTATION(TTTestRandomData)        //使用WCDB_IMPLEMENTATION宏在类文件定义绑定到数据库表的类。
WCDB_SYNTHESIZE(TTTestRandomData, randomNum) //使用WCDB_SYNTHESIZE宏在类文件定义需要绑定到数据库表的字段
WCDB_SYNTHESIZE(TTTestRandomData, uuid)
WCDB_SYNTHESIZE(TTTestRandomData, name)
WCDB_PRIMARY(TTTestRandomData, uuid) //定义主键自增。
//WCDB_INDEX(IMUSERData, "_index", createTime)


/**
 绑定一个cell 类
 
 @return 返回类名
 */
-(NSString*)cellClassNameInTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    return @"TTWCDBDataTableCell";
}

/**
 返回当前cell的高度
 
 @return cell、headerFooter的高度
 */
-(CGFloat)cellHeighInTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    return 44;
}

#pragma mark - BASE
+ (WCTDatabase *)db {
    return [self database];
}

#pragma mark - 删除
+ (BOOL)deleteDataWithuuid:(NSString *)uuid {
    BOOL result = [[self db] deleteObjectsFromTable:[self tableName]
                                             where:TTTestRandomData.uuid == uuid];

    return result;
}

#pragma mark - 更新
+ (BOOL)updateName:(TTTestRandomData *)data {
    if (!data) {return NO;}
    return [[self db] updateRowsInTable:[self tableName] onProperty:TTTestRandomData.name withObject:data where:TTTestRandomData.uuid == data.uuid];
}

@end
