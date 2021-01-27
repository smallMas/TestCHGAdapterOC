//
//  TTTreeSortUtility.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/27.
//

#import "TTTreeSortUtility.h"

@implementation TTTreeSortUtility

// 前序 [根，左，右]
+ (NSArray *)beforeSort:(TTTreeModel *)model {
    if (model == nil) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray new];
    [self __beforeSort:model array:array];
    
    return array;
}

+ (void)__beforeSort:(TTTreeModel *)model array:(NSMutableArray *)array {
    if (model == nil) {
        return ;
    }
    
    [array addObject:@(model.value)];
    [self __beforeSort:model.left array:array];
    [self __beforeSort:model.right array:array];
}

// 中序 [左，根，右]
+ (NSArray *)centerSort:(TTTreeModel *)model {
    if (model == nil) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray new];
    [self __centerSort:model array:array];
    return array;
}

+ (void)__centerSort:(TTTreeModel *)model array:(NSMutableArray *)array {
    if (model == nil) {
        return;
    }
    
    [self __centerSort:model.left array:array];
    [array addObject:@(model.value)];
    [self __centerSort:model.right array:array];
}

// 后序 [左，右，根]
+ (NSArray *)afterSort:(TTTreeModel *)model {
    if (model == nil) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray new];
    [self __afterSort:model array:array];
    return array;
}

+ (void)__afterSort:(TTTreeModel *)model array:(NSMutableArray *)array {
    if (model == nil) {
        return;
    }
    
    [self __afterSort:model.left array:array];
    [self __afterSort:model.right array:array];
    [array addObject:@(model.value)];
}

// 二叉树自上而下，自左而右
+ (NSArray *)updownSort:(TTTreeModel *)model {
    if (model == nil) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray new];
    [self __updownSortArray:array tmp:@[model]];
    return array;
}

+ (void)__updownSortArray:(NSMutableArray *)array tmp:(NSArray *)tmpArray {
    if (tmpArray && tmpArray.count > 0) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        for (TTTreeModel *m in tmpArray) {
            [array addObject:@(m.value)];
            if (m.left) {
                [arr addObject:m.left];
            }
            if (m.right) {
                [arr addObject:m.right];
            }
        }
        [self __updownSortArray:array tmp:arr];
    }
}

// 二叉树自下而上，自左而右
+ (NSArray *)downupSort:(TTTreeModel *)model {
    if (model == nil) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray new];
    [self __downupSortArray:array tmp:@[model]];
    return array;
}

+ (void)__downupSortArray:(NSMutableArray *)array tmp:(NSArray *)tmpArray {
    if (tmpArray && tmpArray.count > 0) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        for (TTTreeModel *m in tmpArray) {
            if (m.left) {
                [arr addObject:m.left];
            }
            if (m.right) {
                [arr addObject:m.right];
            }
        }
        [self __downupSortArray:array tmp:arr];
        
        for (TTTreeModel *m in tmpArray) {
            [array addObject:@(m.value)];
        }
    }
}

@end
