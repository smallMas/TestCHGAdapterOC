//
//  TTChainCollectionHeaderView.m
//  TestCHGAdapterOC
//
//  Created by love on 2021/6/11.
//

#import "TTChainCollectionHeaderView.h"
#import "TTChainModel.h"

@interface TTChainCollectionHeaderView ()
@property (weak, nonatomic) UILabel *titleLab;
@end

@implementation TTChainCollectionHeaderView

- (UILabel *)titleLab {
    if (!_titleLab) {
        UILabel *obj = UILabel.new;
        obj.font = [UIFont systemFontOfSize:16];
        [self addSubview:_titleLab = obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            kMakeLV(15);
            kMakeCenterYV(0);
        }];
    }
    return _titleLab;
}

- (void)reusableViewWillAppear {
    [super reusableViewWillAppear];
    TTChainModel *model = self.model;
    self.titleLab.text = model.name;
    self.backgroundColor = [UIColor grayColor];
}
@end
