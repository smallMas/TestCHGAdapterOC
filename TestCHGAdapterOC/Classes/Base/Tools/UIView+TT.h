//
//  UIView+TT.h
//  TestCHGAdapterOC
//
//  Created by love on 2021/8/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (TT)

- (void)addShadowC:(UIColor *)color
            offset:(CGSize)offset
           opacity:(CGFloat)opacity
            radius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
