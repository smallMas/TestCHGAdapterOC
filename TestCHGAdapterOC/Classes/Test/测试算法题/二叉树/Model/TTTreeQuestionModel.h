//
//  TTTreeQuestionModel.h
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TTTreeType) {
    // 二叉树前序遍历
    TTTreeTypeBeforeSort,
    // 二叉树中序遍历
    TTTreeTypeCenterSort,
    // 二叉树后序遍历
    TTTreeTypeAfterSort,
    // 二叉树从上到下，从左到右
    TTTreeTypeUpDownLeftRight,
};

@interface TTTreeQuestionModel : NSObject

@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *result;
@property (nonatomic, assign) TTTreeType type;
+ (instancetype)createT:(TTTreeType)type;
@end

NS_ASSUME_NONNULL_END
