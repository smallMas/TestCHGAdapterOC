//
//  UIViewController+TTMeta.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/3/31.
//

#import "UIViewController+TTMeta.h"

@implementation UIViewController (TTMeta)
- (void)setMetaInfo:(id)metaInfo{
    objc_setAssociatedObject(self, _cmd, metaInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (id)metaInfo{
    return objc_getAssociatedObject(self, @selector(setMetaInfo:));
}
@end
