//
//  BasicSquare.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/8/31.
//

#import "BasicSquare.h"

@implementation BasicSquare

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addBorder];
    }
    return self;
}

- (void)addBorder {
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    CGFloat lineWidth = 2;
    layer.lineWidth = lineWidth;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor blackColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.fsj_width, self.fsj_height)];
    
    layer.path = path.CGPath;
    
    [self.layer addSublayer: layer];
    
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        self.backgroundColor = self.color;
        self.alpha = 1;
    }
    else {
        self.alpha = 0;
    }
    
}

@end
