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
// 二叉树从上到下，从左到右
+ (NSArray *)updownSort:(TTTreeModel *)model;
@end

NS_ASSUME_NONNULL_END
