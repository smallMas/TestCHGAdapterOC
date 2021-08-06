//
//  TTSudoku.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/7/22.
//

#import "TTSudoku.h"

@interface TTSudoku ()
@property (strong, nonatomic) NSMutableArray *dataArray, *holdArray;
@end

@implementation TTSudoku

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.level = TTSudokuLevelSimple;
    }
    return self;
}

- (void)randomDataBlock:(TTSudokuArrayBlock)block {
    [self resetAll];
    while (![self fillFrom:0 val:1]);
    [self printArray:self.dataArray];
    
    int count = [self holeCount];
    [self digHole:count];
    [self printArray:self.holdArray];
    
    for (int i = 0; i < self.dataArray.count; i++) {
        NSArray *arr0 = self.dataArray[i];
        NSArray *arr1 = self.holdArray[i];
        NSMutableArray *array = NSMutableArray.new;
        for (int j = 0; j < arr0.count; j++) {
            NSNumber *num0 = arr0[j];
            NSNumber *num1 = arr1[j];
            if (num1.intValue == 0) {
                [array addObject:@0];
            }else {
                [array addObject:num0];
            }
        }
        [self.allArray addObject:array];
    }
    [self printArray:self.allArray];
    
    if (block) {
        block(self.allArray);
    }
}

- (int)holeCount {
    int count = 20;
    switch (self.level) {
        case TTSudokuLevelSimple:
            count = 20;
            break;
        case TTSudokuLevelCommon:
            count = 27;
            break;
        case TTSudokuLevelDifficulty:
            count = 39;
            break;
        case TTSudokuLevelInsane:
            count = 45;
            break;
        default:
            break;
    }
    return 81-count;
}

- (void)digHole:(NSInteger)holeCnt {
    NSMutableArray *idx = [[NSMutableArray alloc] initWithCapacity:81];
    int i, k;
    for (i = 0; i < 81; i++) {
        self.holdArray[i/9][i%9] = @(0);
        idx[i] = @(i);
    }
    for (i = 0; i < holeCnt; i++) {
        k = arc4random()%81;
        NSNumber *tmp = idx[k];
        idx[k] = idx[i];
        idx[i] = tmp;
    }
    for (i = 0; i < holeCnt; i++) {
        int num = ((NSNumber *)idx[i]).intValue;
        self.holdArray[num/9][num%9] = @(1);
    }
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (NSMutableArray *)holdArray {
    if (!_holdArray) {
        _holdArray = [NSMutableArray new];
    }
    return _holdArray;
}

- (NSMutableArray *)allArray {
    if (!_allArray) {
        _allArray = [NSMutableArray new];
    }
    return _allArray;
}

- (void)printArray:(NSArray *)array {
    NSMutableString *string = NSMutableString.new;
    [string appendString:@"\n"];
    for (NSArray *arr in array) {
        for (NSNumber *num in arr) {
            [string appendFormat:@"%@ ",num];
        }
        [string appendString:@"\n"];
    }
    NSLog(@"== %@",string);
}

- (NSArray *)createXOrd {
    NSMutableArray *arr = NSMutableArray.new;
    for (int i = 0; i < 9; i++) {
        [arr addObject:@(i)];
    }
    
    // 随机交换位置
    int k;
    NSNumber *tmp;
    for (int i = 0; i < 9; i++) {
        k = arc4random()%9;
        tmp = arr[k];
        arr[k] = arr[i];
        arr[i] = tmp;
    }
    
    return arr;
}

- (BOOL)fillFrom:(int)y val:(int)val {
    NSArray *xOrd = [self createXOrd];
    
    for (int i=0; i<9; i++) {
        int x = ((NSNumber *)xOrd[i]).intValue;
        if ([self setValue:val x:x y:y]) {
            if (y == 8) {
                if (val == 9 || [self fillFrom:0 val:val+1]) {
                    return YES;
                }
            }else {
                if ([self fillFrom:y+1 val:val]) {
                    return YES;
                }
            }
            [self reset:x y:y];
        }
    }
    return NO;
}

- (BOOL)setValue:(int)value x:(int)x y:(int)y {
    if ([self numX:x y:y] != 0) { // 非空
        return NO;
    }
    int x0, y0;
    for (x0 = 0; x0 < 9; x0++) {
        if ([self numX:x0 y:y] == value) { // 行冲突
            return NO;
        }
    }
    for (int y0 = 0; y0 < 9; y0++) {
        if ([self numX:x y:y0] == value) {
            return NO;
        }
    }
    for (y0=y/3*3; y0<y/3*3+3; y0++) {
        for (x0=x/3*3; x0<x/3*3+3; x0++) {
            if ([self numX:x0 y:y0] == value) {
                return NO;
            }
        }
    }
    NSMutableArray *lineArray = [[NSMutableArray alloc] initWithArray:self.dataArray[y]];
    lineArray[x] = @(value);
    self.dataArray[y] = lineArray;
    return true;
}

- (void)reset:(int)x y:(int)y {
    NSMutableArray *lineArray = [[NSMutableArray alloc] initWithArray:self.dataArray[y]];
    lineArray[x] = @(0);
    self.dataArray[y] = lineArray;
}

- (int)numX:(int)x y:(int)y {
    NSNumber *num = self.dataArray[y][x];
    return num.intValue;
}

- (void)resetAll {
    [self.allArray removeAllObjects];
    [self.dataArray removeAllObjects];
    [self.holdArray removeAllObjects];
    for (NSInteger i = 1; i <= 9; i++) {
        NSMutableArray *arr = NSMutableArray.new;
        NSMutableArray *harr = NSMutableArray.new;
        for (NSInteger j = 1; j <= 9; j++) {
            [arr addObject:@0];
            [harr addObject:@0];
        }
        [self.dataArray addObject:arr];
        [self.holdArray addObject:harr];
    }
    
}

@end
