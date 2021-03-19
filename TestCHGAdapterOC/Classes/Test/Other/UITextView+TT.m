//
//  UITextView+TT.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/6.
//

#import "UITextView+TT.h"

@implementation UITextView (TT)
- (void)setObj:(TTObject *)obj {
    objc_setAssociatedObject(self, _cmd, obj, OBJC_ASSOCIATION_RETAIN);
}

- (TTObject *)obj {
    TTObject *object = objc_getAssociatedObject(self, @selector(setObj:));
    if (object == nil) {
        TTObject *a = [TTObject new];
        [self setObj:a];
        return a;
    }
    return object;
}


@end
