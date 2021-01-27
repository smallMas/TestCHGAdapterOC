//
//  TTExerciseModel.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/27.
//

#import "TTExerciseModel.h"

@implementation TTExerciseModel

+ (instancetype)createExeType:(TTExerciseType)type {
    NSString *question = @"";
    switch (type) {
        case TTExerciseTypeZiMuToColum:
            question = @"用A表示1第一列，B表示2第二列，。。。，Z表示26，AA表示27，AB表示28。。。以此类推。请写出一个函数，输入用字母表示的列号编码，输出它是第几列。";
            break;
            
        default:
            break;
    }
    
    TTExerciseModel *model = [[self class] new];
    model.type = type;
    model.question = question;
    return model;
}

- (NSString *)questionString {
    return [NSString stringWithFormat:@"问题：%@",self.question];
}

- (NSString *)resultString {
    return [NSString stringWithFormat:@"结果：%@",self.result];
}

@end
