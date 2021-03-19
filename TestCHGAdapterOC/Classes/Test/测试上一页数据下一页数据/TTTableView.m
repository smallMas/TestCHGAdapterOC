//
//  TTTableView.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/12.
//

#import "TTTableView.h"
#import <MJRefresh/MJRefresh.h>

@implementation TTTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        
    }
    return self;
}


- (void)setContentSize:(CGSize)contentSize
{
    NSLog(@"self.contentSize : %@ size : %@",NSStringFromCGSize(self.contentSize),NSStringFromCGSize(contentSize));
    if (!CGSizeEqualToSize(self.contentSize, CGSizeZero) && !CGSizeEqualToSize(self.contentSize, contentSize))
    {
        if (contentSize.height > self.contentSize.height)
        {
            CGPoint offset = self.contentOffset;
            CGFloat space = contentSize.height - self.contentSize.height;
            if (offset.y < 0) {
                offset.y += space;
            }
            NSLog(@"offset : %@",NSStringFromCGPoint(offset));
            self.contentOffset = offset;
        }
    }
    [super setContentSize:contentSize];
}

- (void)setContentOffset:(CGPoint)contentOffset {
    NSLog(@"set offset : %@ self.state : %d",NSStringFromCGPoint(contentOffset),self.mj_header.state);
    if (contentOffset.y > 800) {
        NSLog(@"");
    }
    [super setContentOffset:contentOffset];
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    NSLog(@"set inset : %@",NSStringFromUIEdgeInsets(contentInset));
    [super setContentInset:contentInset];
}


@end
