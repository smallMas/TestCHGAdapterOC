//
//  UIView+TT.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/8/6.
//

#import "UIView+TT.h"

@implementation UIView (TT)

- (void)addShadowC:(UIColor *)color
            offset:(CGSize)offset
           opacity:(CGFloat)opacity
            radius:(CGFloat)radius {
    self.layer.shadowColor = color.CGColor;//[UIColor colorWithRed:255/255.0 green:146/255.0 blue:99/255.0 alpha:0.2].CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
}
@end
