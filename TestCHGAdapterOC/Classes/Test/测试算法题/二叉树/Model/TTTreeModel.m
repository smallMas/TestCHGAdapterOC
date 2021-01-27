//
//  TTTreeModel.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/27.
//

#import "TTTreeModel.h"

@implementation TTTreeModel

+ (instancetype)createTreeValue:(NSInteger)value {
    TTTreeModel *model = [[self class] new];
    model.value = value;
    return model;
}
@end
