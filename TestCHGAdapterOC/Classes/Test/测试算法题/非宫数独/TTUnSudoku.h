//
//  TTUnSudoku.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/8/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ TTUnSudokuArrayBlock) (NSArray *array);
@interface TTUnSudoku : NSObject

// 乘阶 默认3
@property (assign, nonatomic) NSInteger factorial;
@property (strong, nonatomic) NSMutableArray *allArray;

- (void)randomDataBlock:(TTUnSudokuArrayBlock)block;


@end

NS_ASSUME_NONNULL_END
