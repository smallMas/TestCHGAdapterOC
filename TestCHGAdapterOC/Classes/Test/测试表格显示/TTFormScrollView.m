//
//  TTFormScrollView.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/6/21.
//

#import "TTFormScrollView.h"

@implementation TTFormScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}
@end
