//
//  TTAnimationModel.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/22.
//

#import "TTAnimationModel.h"

@implementation TTAnimationModel

+ (instancetype)createT:(TTAnimationType)type {
    TTAnimationModel *model = [[self class] new];
    model.type = type;
    return model;
}

#pragma mark - table adapter
/**
 绑定一个cell 类
 
 @return 返回类名
 */
-(NSString*)cellClassNameInTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath{
    return @"TTAnimationTableViewCell";
}

/**
 返回当前cell的高度
 
 @return cell、headerFooter的高度
 */
-(CGFloat)cellHeighInTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    return 80;
}

@end
