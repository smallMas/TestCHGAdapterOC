//
//  KLLiveGradientView.m
//  kunlun
//
//  Created by love on 2021/3/15.
//  Copyright © 2021 zhusanbao. All rights reserved.
//

#import "KLLiveGradientView.h"

@interface KLLiveGradientView ()
@property (strong, nonatomic) CAGradientLayer *glLayer;
@end

@implementation KLLiveGradientView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer addSublayer:self.glLayer];
        
        FSJ_WEAK_SELF
        self.colorsBlock = ^(NSArray * _Nonnull colors) {
            FSJ_STRONG_SELF
            NSMutableArray *gcolors = NSMutableArray.array;
            [colors enumerateObjectsUsingBlock:^(UIColor *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [gcolors addObject:(id)obj.CGColor];
            }];
            self.glLayer.colors = gcolors;
        };
        self.pointBlock = ^(CGPoint start, CGPoint end) {
            FSJ_STRONG_SELF
            self.glLayer.startPoint = start;
            self.glLayer.endPoint   = end;
        };
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.glLayer.frame = self.bounds;
}

- (CAGradientLayer *)glLayer {
    if (!_glLayer) {
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.opacity = 0.5;
        _glLayer = gradientLayer;
    }
    return _glLayer;
}

- (void)setGLOpacity:(CGFloat)opacity {
    self.glLayer.opacity = opacity;
}

@end
