//
//  KLLiveGradientView.h
//  kunlun
//
//  Created by love on 2021/3/15.
//  Copyright © 2021 zhusanbao. All rights reserved.
//  KLGradientView

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLLiveGradientView : UIView

@property (copy, nonatomic) void (^colorsBlock)(NSArray <UIColor *>*colors);
@property (copy, nonatomic) void (^pointBlock)(CGPoint start, CGPoint end);
- (void)setGLOpacity:(CGFloat)opacity;
@end

NS_ASSUME_NONNULL_END
