//
//  TTTreeQuestionModel.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/27.
//

#import "TTTreeQuestionModel.h"

@implementation TTTreeQuestionModel
+ (instancetype)createT:(TTTreeType)type {
    NSString *question = @"";
    switch (type) {
        case TTTreeTypeBeforeSort:
            question = @"二叉树前序遍历";
            break;
        case TTTreeTypeCenterSort:
            question = @"二叉树中序遍历";
            break;
        case TTTreeTypeAfterSort:
            question = @"二叉树后序遍历";
            break;
        case TTTreeTypeUpDownLeftRight:
            question = @"二叉树从上到下，从左到右遍历";
            break;
        default:
            break;
    }
    
    TTTreeQuestionModel *model = [[self class] new];
    model.type = type;
    model.question = question;
    return model;
}

@end
