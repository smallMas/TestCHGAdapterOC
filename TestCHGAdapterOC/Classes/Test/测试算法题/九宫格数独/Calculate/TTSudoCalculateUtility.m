//
//  TTSudoCalculateUtility.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/28.
//

#import "TTSudoCalculateUtility.h"

@implementation TTSudoCalculateUtility

+ (NSArray <TTSudoModel *>*)randomCreate {
    // 先随机公式
    NSArray *gArray = [self onlyAnswer];
    
    NSInteger gIndex = arc4random()%gArray.count;
    TTGongModel *gModel = gArray[gIndex];
    
    for (NSInteger i = 0; i < 3; i++) {
        
    }
    
    return nil;
}

+ (BOOL)isOkBlock:(TTGongShiBlock)block {
    NSInteger upperLimit = 100;
    NSInteger a = arc4random()%upperLimit;
    NSInteger b = arc4random()%upperLimit;
    NSInteger c = arc4random()%upperLimit;
    CGFloat value = block(a, b, c);
    if ([self isInteger:value]) {
        
    }
    return YES;
}

+ (BOOL)isInteger:(CGFloat)value {
    NSInteger x = ceilf(value);
    if (x > value) {
        return NO;
    }
    return YES;
}

+ (NSNumber *)valueForArray:(NSArray *)array {
    if ([self isNineWithArray:array]) {
        // 记录当前算出值的索引
        NSInteger recorderIndex = -1;
        NSInteger value = 0;
        
        NSInteger currentNoValueRow = 0;
        CGFloat calValue1 = 0;
        CGFloat calValue2 = 0;
        NSArray *gongshiArray = [self gongshiArray];
        for (TTGongModel *gModel in gongshiArray) {
            for (NSInteger i = 0; i < array.count; i++) {
                NSArray *arr = array[i];
                TTSudoModel *model1 = arr[0];
                TTSudoModel *model2 = arr[1];
                TTSudoModel *model3 = arr[2];
                if (model1.isHaveValue &&
                    model2.isHaveValue &&
                    model3.isHaveValue) {
                    NSInteger a = model1.value;
                    NSInteger b = model2.value;
                    NSInteger c = model3.value;
                    CGFloat value = Cal(a, b, c, gModel.normalBlock);
                    if (recorderIndex == -1) {
                        calValue1 = value;
                        recorderIndex = i;
                    }else {
                        calValue2 = value;
                    }
                }else {
                    currentNoValueRow = i;
                }
            }
            if (calValue1 == calValue2) {
                // 满足公式条件
                NSLog(@"满足公式条件 : %@",gModel.title);
                if (gModel.reverseBlockA) {
                    NSArray *arr = array[currentNoValueRow];
                    TTSudoModel *model1 = arr[0];
                    TTSudoModel *model2 = arr[1];
                    TTSudoModel *model3 = arr[2];
                    NSInteger a = model1.value;
                    NSInteger b = model2.value;
                    NSInteger c = model3.value;
                    NSInteger v = calValue1;
                    
                    if (!model1.isHaveValue) {
                        value = Cal(v, b, c, gModel.reverseBlockA);
                    }else if (!model2.isHaveValue){
                        value = Cal(a, v, c, gModel.reverseBlockB);
                    }else if (!model3.isHaveValue){
                        value = Cal(a, b, v, gModel.reverseBlockC);
                    }
                }
                
                break;
            }
        }
        return @(value);
    }
    NSLog(@"各宫格数组个数不等于9个");
    return nil;
}

// 判断是否是九宫格
+ (BOOL)isNineWithArray:(NSArray *)array {
    BOOL is = YES;
    if (array.count == 3) {
        for (NSArray *arr in array) {
            if (arr.count != 3) {
                is = NO;
                break;
            }
        }
    }else {
        is = NO;
    }
    return is;
}

// 计算公式数组
+ (NSArray *)gongshiArray {
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[self onlyAnswer]];
    [array addObjectsFromArray:[self mutableAnwer]];
    return array;
}

// 唯一答案(可反推)
+ (NSArray *)onlyAnswer {
    return @[
        [TTGongModel createN:^CGFloat(NSInteger a, NSInteger b, NSInteger c) {
            return (c-a)/(CGFloat)b;
        } aB:^CGFloat(NSInteger v, NSInteger b, NSInteger c) {
            return c-b*v;
        } bB:^CGFloat(NSInteger a, NSInteger v, NSInteger c) {
            return (c-a)/(CGFloat)v;
        } cB:^CGFloat(NSInteger a, NSInteger b, NSInteger v) {
            return b*v+a;
        } title:@"(c-a)/b = v"],
        
        [TTGongModel createN:^CGFloat(NSInteger a, NSInteger b, NSInteger c) {
            return (c+a)/(CGFloat)b;
        } aB:^CGFloat(NSInteger v, NSInteger b, NSInteger c) {
            return b*v-c;
        } bB:^CGFloat(NSInteger a, NSInteger v, NSInteger c) {
            return (c+a)/(CGFloat)v;
        } cB:^CGFloat(NSInteger a, NSInteger b, NSInteger v) {
            return b*v-a;
        } title:@"(c+a)/b = v"]
    ];
}

// 多种答案
+ (NSArray *)mutableAnwer {
    return @[
        [TTGongModel createN:^CGFloat(NSInteger a, NSInteger b, NSInteger c) {
            return (c-a)%b;
        } title:@"(c-a)%b = v"],
        
        [TTGongModel createN:^CGFloat(NSInteger a, NSInteger b, NSInteger c) {
            return (c+a)%b;
        } title:@"(c+a)%b = v"],
    ];
}


@end
