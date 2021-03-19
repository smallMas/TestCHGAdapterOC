//
//  TTCollectionViewController.m
//  TestCHGAdapterOC
//
//  Created by 燕来秋 on 2021/1/28.
//

#import "TTCollectionViewController.h"
#import <objc/message.h>

@interface TTCollectionViewController ()

@end

@implementation TTCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        NSString *clsStr = nil;
        if (self.clsBlock) {
            clsStr = self.clsBlock();
        }
        if (clsStr) {
            Class cls = NSClassFromString(clsStr);
            id myobjc = ((id (*)(id, SEL))objc_msgSend)(cls, @selector(alloc));
            _collectionView = ((id (*)(id, SEL, CGRect, id))objc_msgSend)(myobjc, @selector(initWithFrame:collectionViewLayout:),self.view.bounds,self.layout);
            _collectionView.collectionViewLayout = self.layout;
            _collectionView.frame = self.view.bounds;
        }else {
            _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
        }
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];

        [_collectionView setBackgroundColor:[UIColor clearColor]];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        // cell的行边距[ = ](上下边距)
        _layout.minimumLineSpacing = 5.0f;
        // cell的纵边距[ || ](左右边距)
        _layout.minimumInteritemSpacing = 0.0f;
        [_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    }
    return _layout;
}

@end
