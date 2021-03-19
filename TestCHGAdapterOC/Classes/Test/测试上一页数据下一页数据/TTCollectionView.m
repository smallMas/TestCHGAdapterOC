//
//  TTCollectionView.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/12.
//

#import "TTCollectionView.h"
#import <MJRefresh/MJRefresh.h>

@interface TTCollectionView ()

@property (assign, nonatomic) CGPoint kl_offset;

@end

@implementation TTCollectionView

- (void)setContentSize:(CGSize)contentSize
{
//    NSLog(@"self.contentSize : %@ size : %@ self.mj_header.state : %d",NSStringFromCGSize(self.contentSize),NSStringFromCGSize(contentSize),self.mj_header.state);
    if (!CGSizeEqualToSize(self.contentSize, CGSizeZero) &&
        !CGSizeEqualToSize(self.contentSize, contentSize))
    {
        if (contentSize.height > self.contentSize.height)
        {
            CGPoint offset = self.contentOffset;
            CGFloat space = contentSize.height - self.contentSize.height;
            if (offset.y < 0) {
                offset.y += space;
            }
            NSLog(@"offset : %@",NSStringFromCGPoint(offset));
            _kl_offset = offset;
            self.contentOffset = offset;
        }
    }else {
        if (!CGPointEqualToPoint(self.kl_offset, CGPointZero)) {
            if (self.mj_header.state == MJRefreshStateRefreshing) {
                self.contentOffset = self.kl_offset;
                self.kl_offset = CGPointZero;
            }
        }
    }
    [super setContentSize:contentSize];
}

- (void)setContentOffset:(CGPoint)contentOffset {
//    NSLog(@"set offset : %@ self.state : %d",NSStringFromCGPoint(contentOffset),self.mj_header.state);
//    if (contentOffset.y > 800) {
//        NSLog(@"");
//    }
    [super setContentOffset:contentOffset];
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
//    NSLog(@"set inset : %@",NSStringFromUIEdgeInsets(contentInset));
    [super setContentInset:contentInset];
}

@end
