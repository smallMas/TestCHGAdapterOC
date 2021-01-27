//
//  TTTreeSortUtility.h
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/27.
//

#import <Foundation/Foundation.h>
#import "TTTreeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTTreeSortUtility : NSObject

// 前序 [根，左，右]
+ (NSArray *)beforeSort:(TTTreeModel *)model;
// 中序 [左，根，右]
+ (NSArray *)centerSort:(TTTreeModel *)model;
// 后序 [左，右，根]
+ (NSArray *)afterSort:(TTTreeModel *)model;
// 二叉树自上而下，自左而右
+ (NSArray *)updownSort:(TTTreeModel *)model;
// 二叉树自下而上，自左而右
+ (NSArray *)downupSort:(TTTreeModel *)model;
@end

NS_ASSUME_NONNULL_END
