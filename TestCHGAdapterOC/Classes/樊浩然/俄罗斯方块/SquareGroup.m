//
//  SquareGroup.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/8/31.
//

#import "SquareGroup.h"
#import "BasicSquare.h"

@interface SquareGroup ()

@property (strong, nonatomic) NSArray *types;
@property (strong, nonatomic) NSArray *group;
@property (assign, nonatomic) int groupIndex;

@property (strong, nonatomic) NSArray *tipGroup;

@property (strong, nonatomic) NSArray *tipTypes;
@property (assign, nonatomic) int tipIndex;

@property (strong, nonatomic) UIView *tipView;

@property (strong, nonatomic) NSArray<UIColor *> *colorArray;

@end

@implementation SquareGroup

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kSquareWH * 4, kSquareWH * 4);
        
        for (int i = 0; i < 16; i++) {
            BasicSquare *squareMask = [[BasicSquare alloc] initWithFrame: CGRectMake(i % 4 * kSquareWH, i / 4 * kSquareWH, kSquareWH, kSquareWH)];
            squareMask.selected = NO;
            [self addSubview:squareMask];
            
        }
    }
    return self;
}

- (UIView *)tipBoard {
    return self.tipView;
}

/// 更新下一个提示
- (void)updateTipView {
    
    for (BasicSquare *square in self.tipView.subviews) {
        square.selected = NO;
    }
    
    NSArray *tip = self.tipTypes[self.tipIndex];
    UIColor *color = self.colorArray[self.tipIndex];
    
    for (int i = 0; i < tip.count; i++) {
        int index = [tip[i] intValue];
        BasicSquare *square = self.tipView.subviews[index];
        square.color = color;
        square.selected = YES;
    }
    
}

/// 回到起始位置
- (void)backToStartPoint:(CGPoint)startPoint {
    self.fsj_origin = startPoint;
    [self clearPrevGroup];
    [self showCurrentGroup];
    [self initPosition];
    [self updateTipView];
}

/// 清空上次显示
- (void)clearPrevGroup {
    for (BasicSquare *square in self.subviews) {
        square.selected = NO;
    }
}

/// 显示组合
- (void)showCurrentGroup {
    
    if (self.tipGroup == nil) {
        
        NSArray *array = [self catchAnRandomGroup];
        self.tipGroup = [array firstObject];
        self.tipIndex = [[array lastObject] intValue];
    }
    
    self.group = self.tipGroup.copy;
    self.groupIndex = self.tipIndex;
    self.color = self.colorArray[self.groupIndex];
    
    for (int i = 0; i <self.group.count; i++) {
        
        int index = [self.group[i] intValue];
        BasicSquare *squareM = self.subviews[index];
        squareM.color = self.color;
        squareM.selected = YES;
    }
    
    NSArray *randomData = [self catchAnRandomGroup];
    self.tipGroup = [randomData firstObject];
    self.tipIndex = [[randomData lastObject] intValue];
}

/// 随机取出一个组合及其索引 [group, index]
- (NSArray *)catchAnRandomGroup {
    int bangIndex = arc4random_uniform((uint32_t)self.types.count);
    NSArray *randomBang = self.types[bangIndex];
    int groupindex = arc4random_uniform((uint32_t)randomBang.count);
    NSArray *randomGroup = randomBang[groupindex];
    return @[randomGroup, @(bangIndex)];
}

/// 设置初始位置
- (void)initPosition {
    // 新组合出现时只显示最下面一行
    for (int i = (int)self.subviews.count - 1; i >= 0; i--) {
        BasicSquare *lastSquare = self.subviews[i];
        if (lastSquare.selected) {
            self.fsj_top -= lastSquare.fsj_top;
            return;
        }
    }
}

/// 旋转
- (void)rotate:(BOOL(^)(NSArray *nextGroup))canRotate {
    
    // 找出包含待旋转方块组和的数组
    NSArray *array;
    
    for (int i = 0; i < self.types.count; i++) {
        NSArray *tempArray = self.types[i];
        if ([tempArray containsObject:self.group]) {
            array = tempArray;
        }
    }
    // 拿到该组合的索引，循环取出下一个组合
    NSInteger index = [array indexOfObject:self.group];
    NSInteger nextIndex = (index +1) % array.count;
    NSArray *nextGroup = array[nextIndex];
    
    // 显示组合
    if (canRotate(nextGroup)) {
        [self clearPrevGroup];
        
        for (int i = 0; i <nextGroup.count; i++) {
            int index = [nextGroup[i] intValue];
            BasicSquare *squareM = self.subviews[index];
            
            squareM.color = self.color;
            squareM.selected = YES;
        }
        self.group = nextGroup;
    }
}

#pragma mark - lazy loads

- (UIView *)tipView {
    if (!_tipView) {
        _tipView = [[UIView alloc] init];
        _tipView.frame = CGRectMake(0, 0, 4 *kSquareWH, 2 *kSquareWH);
        
        for (int i = 0; i < 8; i++) {
            
            BasicSquare *squareMask = [[BasicSquare alloc] initWithFrame: CGRectMake(i % 4 * kSquareWH, i / 4 * kSquareWH, kSquareWH, kSquareWH)];
            squareMask.selected = NO;
            [_tipView addSubview:squareMask];
        }
    }
    return _tipView;
}

/// 颜色
- (NSArray<UIColor *> *)colorArray {
    if (!_colorArray) {
        _colorArray = @[
                        [UIColor redColor],
                        [UIColor greenColor],
                        [UIColor blueColor],
                        [UIColor yellowColor],
                        [UIColor purpleColor],
                        [UIColor orangeColor],
                        [UIColor cyanColor]
                        ];
    }
    return _colorArray;
}

/// 提示类型
- (NSArray *)tipTypes {
    if (!_tipTypes) {
        _tipTypes = @[
                      @[@0, @1, @5, @6], // Z
                      @[@1, @2, @4, @5], // 反Z
                      @[@2, @4, @5, @6], // L
                      @[@0, @4, @5, @6], // 反L
                      @[@1, @4, @5, @6], // 凸
                      @[@0, @1, @4, @5], // 田
                      @[@4, @5, @6, @7], // 一
                      ];
    }
    return _tipTypes;
}

/// 组合类型
- (NSArray *)types {
    if (!_types) {
        _types = @[
                   @[
                       @[@1, @4, @5, @8],   // Z
                       @[@0, @1, @5, @6],
                    ],
                   
                   @[
                       @[@1, @5, @6, @10],  // 反Z
                       @[@1, @2, @4, @5],
                    ],
                   
                   @[
                       @[@1, @2, @6, @10],
                       @[@6, @8, @9, @10],
                       @[@0, @4, @8, @9],   // L
                       @[@0, @1, @2, @4],
                    ],
                   
                   @[
                       @[@0, @1, @4, @8],
                       @[@0, @1, @2, @6],
                       @[@2, @6, @9, @10],  // 反L
                       @[@4, @8, @9, @10],
                    ],
                   
                   @[
                       @[@1, @4, @5, @9],
                       @[@1, @4, @5, @6],   // 凸
                       @[@1, @5, @6, @9],
                       @[@4, @5, @6, @9],
                    ],
                   
                   @[
                       @[@0, @1, @4, @5],    // 田
                    ],
                   
                   @[
                       @[@4, @5, @6, @7],   // 一
                       @[@1, @5, @9, @13],
                    ],
                   
                  ];
    }
    return _types;
}



@end
