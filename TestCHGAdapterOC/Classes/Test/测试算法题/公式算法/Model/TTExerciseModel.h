//
//  TTExerciseModel.h
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TTExerciseType) {
    // 根据字母计算在第几行
    TTExerciseTypeZiMuToColum,
};

@interface TTExerciseModel : NSObject
@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *result;
@property (nonatomic, assign) TTExerciseType type;

+ (instancetype)createExeType:(TTExerciseType)type;

- (NSString *)questionString;
- (NSString *)resultString;

@end

NS_ASSUME_NONNULL_END
