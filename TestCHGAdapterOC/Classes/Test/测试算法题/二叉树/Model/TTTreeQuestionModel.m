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
            question = @"二叉树自上而下，自左而右遍历";
            break;
        case TTTreeTypeDownUpLeftRight:
            question = @"二叉树自下而上，自左而右遍历";
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
