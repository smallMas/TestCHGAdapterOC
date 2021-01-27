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
    // 二叉树自上而下，自左而右
    TTTreeTypeUpDownLeftRight,
    // 二叉树自下而上，自左而右
    TTTreeTypeDownUpLeftRight,
};

@interface TTTreeQuestionModel : NSObject

@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *result;
@property (nonatomic, assign) TTTreeType type;
+ (instancetype)createT:(TTTreeType)type;
@end

NS_ASSUME_NONNULL_END
