//
//  SquareGroup.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/8/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define kSquareWH ((int)FSJSCREENWIDTH/22) // 方便后面计算索引值，必须是整数

@interface SquareGroup : UIView

@property (strong, nonatomic) UIColor *color;

/// 提示下一个组合的面板
- (UIView *)tipBoard;

/// 回到起始位置
- (void)backToStartPoint:(CGPoint)startPoint;

/// 旋转
- (void)rotate:(BOOL(^)(NSArray *nextGroup))canRotate;

@end

NS_ASSUME_NONNULL_END
