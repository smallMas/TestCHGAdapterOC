//
//  TTMenuModel.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/20.
//

#import "TTMenuModel.h"

@implementation TTMenuModel
+ (instancetype)createT:(NSString *)title toCS:(NSString * __nullable)toClassString type:(NSInteger)type data:(id)data {
    TTMenuModel *model = [[self class] new];
    model.title = title;
    model.toClassString = toClassString;
    model.type = type;
    model.data = data;
    return model;
}

+ (instancetype)createT:(NSString *)title toCS:(NSString * __nullable)toClassString {
    return [self createT:title toCS:toClassString type:0 data:nil];
}

+ (instancetype)createT:(NSString *)title type:(NSInteger)type {
    return [self createT:title toCS:nil type:type data:nil];
}

+ (instancetype)createT:(NSString *)title type:(NSInteger)type data:(id)data {
    return [self createT:title toCS:nil type:type data:data];
}

#pragma mark - adapter

/**
 绑定一个cell 类
 
 @return 返回类名
 */
-(NSString*)cellClassNameInTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath{
    return @"TTMenuTableViewCell";
}

/**
 返回当前cell的高度
 
 @return cell、headerFooter的高度
 */
-(CGFloat)cellHeighInTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    return 44;
}

@end
