//
//  TTHomeMenuModel.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/8/6.
//

#import "TTHomeMenuModel.h"

@implementation TTHomeMenuModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layout.itemSize = kSize(FSJSCREENWIDTH, 100);
    }
    return self;
}

- (NSString *)idf {
    if (self.type % 2 == 0) {
        return @"TTHomeMenuCell";
    }else {
        return @"TTHomeMenuCell2";
    }
}

- (UIColor *)bgColor {
    if (!_bgColor) {
        _bgColor = [UIColor fsj_randomColor];
    }
    return _bgColor;
}

@end
