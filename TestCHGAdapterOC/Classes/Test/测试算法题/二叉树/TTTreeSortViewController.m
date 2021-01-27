//
//  TTTreeSortViewController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/27.
//

#import "TTTreeSortViewController.h"
#import "TTTreeModel.h"

@interface TTTreeSortViewController ()

@end

@implementation TTTreeSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TTTreeModel *one = [TTTreeModel createTreeValue:4];
    one.left = [TTTreeModel createTreeValue:2];
    one.right = [TTTreeModel createTreeValue:7];
    
    TTTreeModel *two = one.left;
    two.left = [TTTreeModel createTreeValue:1];
    two.right = [TTTreeModel createTreeValue:3];
    
    TTTreeModel *twoR = one.right;
    twoR.left = [TTTreeModel createTreeValue:6];
    twoR.right = [TTTreeModel createTreeValue:9];
    
    NSLog(@"前序排列 : %@",[self beforeSort:one]);
    NSLog(@"中序排列 : %@",[self centerSort:one]);
    NSLog(@"后序排列 : %@",[self afterSort:one]);
}

// 前序 [根，左，右]
- (NSArray *)beforeSort:(TTTreeModel *)model {
    if (model == nil) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray new];
    [self __beforeSort:model array:array];
    
    return array;
}

- (void)__beforeSort:(TTTreeModel *)model array:(NSMutableArray *)array {
    if (model == nil) {
        return ;
    }
    
    [array addObject:@(model.value)];
    [self __beforeSort:model.left array:array];
    [self __beforeSort:model.right array:array];
}

// 中序 [左，根，右]
- (NSArray *)centerSort:(TTTreeModel *)model {
    if (model == nil) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray new];
    [self __centerSort:model array:array];
    return array;
}

- (void)__centerSort:(TTTreeModel *)model array:(NSMutableArray *)array {
    if (model == nil) {
        return;
    }
    
    [self __centerSort:model.left array:array];
    [array addObject:@(model.value)];
    [self __centerSort:model.right array:array];
    
}

// 后序 [左，右，根]
- (NSArray *)afterSort:(TTTreeModel *)model {
    if (model == nil) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray new];
    [self __afterSort:model array:array];
    return array;
}

- (void)__afterSort:(TTTreeModel *)model array:(NSMutableArray *)array {
    if (model == nil) {
        return;
    }
    
    [self __afterSort:model.left array:array];
    [self __afterSort:model.right array:array];
    [array addObject:@(model.value)];
    
}

@end
