//
//  TTSudoku.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/7/22.
//  数独生成 https://blog.csdn.net/qq_39798042/article/details/78989675

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ TTSudokuArrayBlock) (NSArray *array);
typedef NS_ENUM(NSInteger, TTSudokuLevel) {
    TTSudokuLevelSimple, // 简单 20
    TTSudokuLevelCommon, // 普通 27 26
    TTSudokuLevelDifficulty,// 困难 39 37
    TTSudokuLevelInsane, // 疯狂 42 45
};

@interface TTSudoku : NSObject

@property (assign, nonatomic) TTSudokuLevel level;
@property (strong, nonatomic) NSMutableArray *allArray;
- (void)randomDataBlock:(TTSudokuArrayBlock)block;
@end

NS_ASSUME_NONNULL_END
