//
//  TTTreeModel.h
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTTreeModel : NSObject
@property (nonatomic, strong) TTTreeModel *left;
@property (nonatomic, strong) TTTreeModel *right;
@property (nonatomic, assign) NSInteger value;

+ (instancetype)createTreeValue:(NSInteger)value;
@end

NS_ASSUME_NONNULL_END
