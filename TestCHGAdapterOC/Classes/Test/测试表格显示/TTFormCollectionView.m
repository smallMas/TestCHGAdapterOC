//
//  TTFormCollectionView.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/6/21.
//

#import "TTFormCollectionView.h"

@implementation TTFormCollectionView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}
@end
