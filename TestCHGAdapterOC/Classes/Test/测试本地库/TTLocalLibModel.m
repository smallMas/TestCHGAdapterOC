//
//  TTLocalLibModel.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/31.
//

#import "TTLocalLibModel.h"

@implementation TTLocalLibModel

/**
 绑定一个cell 类
 
 @return 返回类名
 */
-(NSString*)cellClassNameInTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    return @"TTLocalLibTableViewCell";
}

/**
 返回当前cell的高度
 
 @return cell、headerFooter的高度
 */
-(CGFloat)cellHeighInTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    return 44;
}

@end
